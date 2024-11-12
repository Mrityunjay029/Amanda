public with sharing class GetFlowsAndProcesses implements Database.Batchable<String>, Database.AllowsCallouts,Database.Stateful {
    public final String sObj;
    public final String fieldapi;
    public final String compType;
    public final Map<String, String>fullNameAndID = new Map<String, String>();
    public final String sessionIdd;
    public Integer cc;
    public final String OrgURL;
    public final List<String>customSettingName= new List<String>();
    public final Integer numberOfCustomSetting;
    public GetFlowsAndProcesses(String sessionid, String type,String Obj,String field){
        cc=0;
        //system.debug('sessionid::: '+sessionid);
        sessionIdd = sessionid;
        compType = type;
        sObj = Obj;
        fieldapi = field;
        String baseurl = System.URL.getSalesforceBaseURL().toExternalForm();
        OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';
        if(compType=='Approval Process'){
            if(
                ProcessDefinition.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.Id.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.name.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.DeveloperName.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.TableEnumOrId.isAccessible()
            ) {
                for(ProcessDefinition pd: [SELECT Id,DeveloperName,name,TableEnumOrId FROM ProcessDefinition where Id != null /*AND State='Active'*/])
                    //fullNameAndID.put(sObj+'.'+pd.DeveloperName,pd.Id);
                    fullNameAndID.put(pd.TableEnumOrId+'.'+pd.DeveloperName,pd.Id);
            }
        }
        //system.debug('fullNameAndID:'+fullNameAndID);
    }  
    public Iterable<String> start (Database.BatchableContext BC) {
        List<String> scope= new List<String>();        
        if(compType == 'Approval Process' ){
            if(
                ProcessDefinition.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.Id.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.name.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.DeveloperName.isAccessible() &&
                Schema.SObjectType.ProcessDefinition.fields.TableEnumOrId.isAccessible()
            ) {
                for(ProcessDefinition pd: [SELECT Id,DeveloperName,name,TableEnumOrId FROM ProcessDefinition where Id != null /* AND State='Active' */]){
                    if(pd != null){
                        //System.debug('ap name: '+pd.DeveloperName+'   table name: '+pd.TableEnumOrId);
                        //fullNameAndID.put(sObj+'.'+pd.DeveloperName,pd.Id);
                        fullNameAndID.put(pd.TableEnumOrId+'.'+pd.DeveloperName,pd.Id);
                        scope.add(pd.TableEnumOrId+'.'+pd.DeveloperName);
                    }
                } 
            }
        }
        else if(compType == 'Flow'){ 
            HttpRequest req = new HttpRequest();                                        
            req.setHeader('Authorization', 'OAuth '+sessionIdd);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('GET');
            Http http = new Http();
            Map<String, String>FlowNamesAndURLS= new MAp<String,String>(); 
            Set<String>flowIDS= new Set<String>();
            String stat='Active';
            req.setEndpoint(orgurl+'/services/data/v39.0/tooling/query/?q=select+ProcessType,VersionNumber,Status+from+Flow+where+Status=\''+stat+'\'');
            req.setTimeout(120000);
            HTTPResponse flowResponse =http.send(req);
            //system.debug('flow res:'+flowResponse.getBody()); 
            List<string> SizeList = flowResponse.getBody().split('"size":');
            //system.debug('SizeList==>'+SizeList); 
            //system.debug('sizeList1==>'+sizeList.size());            
            String Size = SizeList[1].substring(0,SizeList[1].indexof(',',0));
            //system.debug('size==>'+size);
            SizeList.clear();
            if(Integer.valueOf(size)>0){ 
                List<String> ComponenURLList = flowResponse.getBody().split('"url":');
                if(ComponenURLList!=null && ComponenURLList.size()>0){
                    for(String s: ComponenURLList){
                        //system.debug('s::'+s);
                        if(s!=ComponenURLList[0]){
                            string urls =s.substringBetween('"');
                            flowIDS.add(urls);
                        }
                    }    
                }  
                //system.debug('flowIDS::'+flowIDS); /*--- This set contains all Flows and and Process URLs------*/
                if(flowIDS.size()>0)
                    scope = new List<String>(flowIDS);
            }
        }
        return scope;
    }

    public void execute (Database.BatchableContext BC, List<String> scope) {
        Set<String> IdsSet = new Set<String>();
        //system.debug('fullNameAndID:: '+fullNameAndID);
        
        /*---------ApprovalProcess analysis starts-------*/
        if(compType == 'Approval Process' ){
            MetadataService.MetadataPort service = new MetadataService.MetadataPort();
            service.timeout_x = 120000;
            service.SessionHeader = new MetadataService.SessionHeader_element();
            //system.debug('sessionId: '+sessionIdd);
            service.SessionHeader.sessionId = sessionIdd;
        
            if(scope.size()>10){
                for(Integer ii = 0; ii<scope.size(); ii=ii+10){
                    String [] fullNameArray = new String[] {};
                    for(Integer j=ii; j<ii+10 && j<scope.size(); j++){//10->20
                        fullNameArray.add(scope[j]);
                    }
                    MetadataService.IReadResult res= service.readMetadata('ApprovalProcess', fullNameArray);
                    if(res != null){
                        MetadataService.ApprovalProcess[] approvalProcessList =(MetadataService.ApprovalProcess[])res.getRecords();
                        fullNameArray.clear();
                        if(approvalProcessList != null && !approvalProcessList.isEmpty() ){
                            for(MetadataService.ApprovalProcess ap: approvalProcessList){
                                //system.debug('AP Name:'+ap.fullName);
                                try{
                                if(ap.EntryCriteria != null && ap.EntryCriteria.criteriaItems != null)
                                    for(MetadataService.FilterItem i: ap.EntryCriteria.criteriaItems){
                                        //system.debug('name:'+ap.fullName+'   id:-'+fullNameAndID.get(ap.fullName));
                                        if(i.field != null && i.field.equals(sobj+'.'+FieldAPI) && fullNameAndID.size()>0 && fullNameAndID.get(ap.fullName) != null)
                                            idsSet.add(fullNameAndID.get(ap.fullName));   
                                    }
                                }catch(Exception e){
                                    //System.debug('excetpion:  '+e);
                                }
                                    /*if(ap.approvalStep != null)
                                    for(MetadataService.ApprovalStep step: ap.approvalStep){
                                        for(MetadataService.FilterItem i: step.entryCriteria.criteriaItems){
                                        system.debug('name:'+ap.fullName);
                                            if(i.field != null && i.field.equals(sobj+'.'+FieldAPI) && fullNameAndID.size()>0 && fullNameAndID.get(ap.fullName) != null)
                                                idsSet.add(fullNameAndID.get(ap.fullName));   
                                        }
                                    }*/
                             }
                         }
                    }
                }
            }
            if(scope.size()<=10){
                MetadataService.IReadResult res= service.readMetadata('ApprovalProcess', scope);
                //system.debug('res : '+res);
                if(res != null){
                    MetadataService.ApprovalProcess[] approvalProcessList =(MetadataService.ApprovalProcess[])res.getRecords();
                    if(approvalProcessList != null && !approvalProcessList.isEmpty() )
                        for(MetadataService.ApprovalProcess ap: approvalProcessList){
                        try{
                                if(ap.EntryCriteria != null)
                                for(MetadataService.FilterItem i: ap.EntryCriteria.criteriaItems){
                                    //system.debug(i.field);
                                    //system.debug('name:'+ap.fullName+'   id:-'+fullNameAndID.get(ap.fullName));
                                    if(i.field != null && i.field.equals(sobj+'.'+FieldAPI) && fullNameAndID.size()>0 && fullNameAndID.get(ap.fullName) != null)
                                        idsSet.add(fullNameAndID.get(ap.fullName));    
                                }
                            }catch(Exception e){/*system.debug('exception::'+e);*/}
                        }
                }
            }
            
        }
        /*-----------Flow analysis starts-----------*/
        if(compType == 'Flow'){
            
            /*-----one by one making callouts to get data of individual Flow/Process-----*/
            for(String url: scope){
                HttpRequest req = new HttpRequest();
                req.setHeader('Authorization', 'OAuth '+sessionIdd);
                req.setHeader('Content-Type', 'application/json');
                req.setMethod('GET');
                Http http1 = new Http();
                req.setEndpoint(OrgURL+url);
                req.setTimeout(120000);
                HTTPResponse flowResponse = http1.send(req);
                //System.debug('flowResponse:: '+flowResponse.getbody());/*----response will be parsed to get required field--------*/ 
                //String[] res=flowResponse.getbody().split('"object":');
                String jsonString = flowResponse.getBody();
                jsonString=jsonString.replaceAll('"object":', '"object_x":');
                //System.debug('jsonString:: '+jsonString);
                try{
                JsonResponse_x responseObj = jsonResponse_x.parse(jsonString);
                if(responseObj != null){
                    if(responseObj.Metadata != null && responseObj.Metadata.recordCreates != null && responseObj.Metadata.recordCreates.size()>0){
                        //system.debug('responseObj.Metadata.recordCreate : '+responseObj.Metadata.recordCreates[0]);
                        //system.debug('responseObj.Metadata.recordCreates. object_x: '+responseObj.Metadata.recordCreates[0].object_x);
                        //system.debug('responseObj.Metadata.recordCreates.inputAssignments: '+responseObj.Metadata.recordCreates[0].inputAssignments);
                        for(Integer i=0; i<responseObj.Metadata.recordCreates.size(); i++){
                            if(responseObj.Metadata.recordCreates[i].object_x == sobj && 
                                                                responseObj.Metadata.recordCreates[i].inputAssignments != null && 
                                                                responseObj.Metadata.recordCreates[i].inputAssignments.size()>0 )
                            for(Integer j=0;j<responseObj.Metadata.recordCreates[i].inputAssignments.size(); j++){
                                if(responseObj.Metadata.recordCreates[i].inputAssignments[j].field == fieldapi){
                                    idsSet.add(responseObj.id+';'+responseObj.FullName);
                                }
                            }
                        }
                    }
                    if(responseObj.Metadata != null && responseObj.Metadata.recordDeletes != null && responseObj.Metadata.recordDeletes.size()>0)
                        for(Integer i=0; i<responseObj.Metadata.recordCreates.size(); i++){
                            if(responseObj.Metadata.recordDeletes[i].object_x == sobj && 
                                                                responseObj.Metadata.recordDeletes[i].filters != null && 
                                                                responseObj.Metadata.recordDeletes[i].filters.size()>0 )
                            for(Integer j=0;j<responseObj.Metadata.recordDeletes[i].filters.size(); j++){
                                if(responseObj.Metadata.recordDeletes[i].filters[j].field == fieldapi){
                                    idsSet.add(responseObj.id+';'+responseObj.FullName);
                                }
                            }
                        }
                    if(responseObj.Metadata != null && responseObj.Metadata.recordLookups != null && responseObj.Metadata.recordLookups.size()>0)
                        for(Integer i=0; i<responseObj.Metadata.recordLookups.size(); i++){
                            if(responseObj.Metadata.recordLookups[i].object_x == sobj){ 
                                if(responseObj.Metadata.recordLookups[i].filters != null && responseObj.Metadata.recordLookups[i].filters.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.recordLookups[i].filters.size(); j++){
                                    if(responseObj.Metadata.recordLookups[i].filters[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                                if(responseObj.Metadata.recordLookups[i].outputAssignments != null && responseObj.Metadata.recordLookups[i].outputAssignments.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.recordLookups[i].outputAssignments.size(); j++){
                                    if(responseObj.Metadata.recordLookups[i].outputAssignments[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                            }
                        }
                    if(responseObj.Metadata != null && responseObj.Metadata.recordUpdates != null && responseObj.Metadata.recordUpdates.size()>0)
                        for(Integer i=0; i<responseObj.Metadata.recordUpdates.size(); i++){
                            if(responseObj.Metadata.recordUpdates[i].object_x == sobj){ 
                                if(responseObj.Metadata.recordUpdates[i].filters != null && responseObj.Metadata.recordUpdates[i].filters.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.recordUpdates[i].filters.size(); j++){
                                    if(responseObj.Metadata.recordUpdates[i].filters[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                                if(responseObj.Metadata.recordUpdates[i].inputAssignments != null && responseObj.Metadata.recordUpdates[i].inputAssignments.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.recordUpdates[i].inputAssignments.size(); j++){
                                    if(responseObj.Metadata.recordUpdates[i].inputAssignments[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                            }
                        }
                    if(responseObj.Metadata != null && responseObj.Metadata.dynamicChoiceSets != null && responseObj.Metadata.dynamicChoiceSets.size()>0)
                        for(Integer i=0; i<responseObj.Metadata.dynamicChoiceSets.size(); i++){
                            if(responseObj.Metadata.dynamicChoiceSets[i].object_x == sobj){ 
                                if(responseObj.Metadata.dynamicChoiceSets[i].filters != null && responseObj.Metadata.dynamicChoiceSets[i].filters.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.dynamicChoiceSets[i].filters.size(); j++){
                                    if(responseObj.Metadata.dynamicChoiceSets[i].filters[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                                if(responseObj.Metadata.dynamicChoiceSets[i].outputAssignments != null && responseObj.Metadata.dynamicChoiceSets[i].outputAssignments.size()>0 )
                                for(Integer j=0;j<responseObj.Metadata.dynamicChoiceSets[i].outputAssignments.size(); j++){
                                    if(responseObj.Metadata.dynamicChoiceSets[i].outputAssignments[j].field == fieldapi){
                                        idsSet.add(responseObj.id+';'+responseObj.FullName);
                                    }
                                }
                            }
                        }
                }
                }catch(Exception ex){
                    //System.debug('Exception occurred at '+ex.getStackTraceString()+' with message '+ex.getMessage()+' for the exception '+ex);
                }
                //system.debug('ress: '+responseObj.Metadata.recordCreates); 
            } 
        }                    
        /*------------Flow analysis Ends------------*/
        //System.debug('ids Set:'+idsSet.size());
        if(idsSet.size()>0 && compType == 'Approval Process'){
            List<String> Ids = new List<String>(idsSet);
            List<Amanda__c>amList = new List<Amanda__c>();
            Map<Id,Amanda__c>amList1 = new Map<Id,Amanda__c>();
            for(Integer i = 0; i<ids.size(); i=i+15){
                String s='';
                for(Integer j=i; j<i+15 && j<ids.size(); j++){//10->20
                    //System.debug('id:-'+ids[j]);
                    s=ids[j].substring(0, 15)+','+s; 
                }
                
                List<Amanda__c>amm=Amanda__c.getall().values();
                if(amm != null && !amm.isEmpty() && amm.size()>0){
                    for(Amanda__c cus: Amanda__c.getall().values()){
                        if(cus.ComponentType__c == compType){
                            Integer last=0;
                            Integer start=0;
                            //system.debug('ids in am:'+cus.ComponentIDs__c.split(',').size());
                            if(cus.ComponentIDs__c.split(',').size()<15){
                                Integer left = 15-cus.ComponentIDs__c.split(',').size();
                                last = start+(left*16)-1;
                                //system.debug('left:'+left+'  start:'+start+'  last:'+last);
                                //s=s.substring(start,last);
                                if(start<=s.length()){
                                    if(last>s.length()){
                                        last = s.length();
                                        cus.ComponentIDs__c = s.substring(start,last)+','+cus.ComponentIDs__c;
                                        amList1.put(cus.id,cus);
                                        s='';
                                        //system.debug('string cut');
                                    }else{
                                        cus.ComponentIDs__c = s.substring(start,last)+','+cus.ComponentIDs__c;
                                        amList1.put(cus.id,cus);
                                        s=s.substring(last+1,s.length());
                                        //system.debug('string cut');
                                    }     
                                } 
                                //start = last; 
                                
                            }
                            else if(last !=0){ 
                                //system.debug('start:'+start+' last:'+last+' cc:'+cc);
                                //system.debug('s:'+s);
                                //system.debug('s:'+s.split(',').size());
                                
                                if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                                    Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                                    Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                                    Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                                    Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                                    Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                                    Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                                        Amanda__c am = new Amanda__c(name= compType+'-'+String.valueOf(cc)+String.valueOf(last)+'-'+ids[i].substring(0, 15));
                                        am.ComponentIDs__c =  s;
                                        am.ComponentType__c = compType;
                                        amList.add(am);
                                        s='';
                                        cc++;
                                        
                                        break;
                                    }
                            }
                        }
                        else{
                            if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                                Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                                Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                                Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                                Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                                Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                                Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                                    Amanda__c am = new Amanda__c(name= compType+'-'+String.valueOf(cc)+'-'+ids[i].substring(0, 15));
                                    am.ComponentIDs__c =  s;
                                    am.ComponentType__c = compType;
                                    amList.add(am);
                                    s='';
                                    cc++;
                                    break;
                                }
                        }
                    }//end  of for
                    if(s != '' ){
                        //system.debug('start:'+start+' last:'+last+' cc:'+cc);
                        //system.debug('s:'+s);
                        //system.debug('s:'+s.split(',').size());
                        if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                            Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                            Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                            Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                                Amanda__c am = new Amanda__c(name= compType+'-'+String.valueOf(cc)+String.valueOf(999)+'-'+ids[i].substring(0, 15));
                                am.ComponentIDs__c =  s;
                                am.ComponentType__c = compType;
                                amList.add(am);
                                cc++;
                            }
                    }
                }
                else{
                    if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                            Amanda__c am = new Amanda__c(name= compType+'-'+String.valueOf(cc)+'-'+ids[i].substring(0, 15));
                            am.ComponentIDs__c = s;
                            am.ComponentType__c = compType;
                            amList.add(am);
                            s='';
                            cc++;
                        }
                }
                
            }
            //system.debug('update list:'+amList1.values());
            if(Schema.sObjectType.Amanda__c.isUpdateable()){
                update amList1.values();
            }
            //system.debug('insert list:'+amList);
            if(Schema.sObjectType.Amanda__c.isCreateable()){
                insert amList;
            }
        }
        if(idsSet.size()>0 && compType == 'Flow'){
            List<String> flowsIdsAndName= new List<String>(idsSet);
            List<Amanda__c> amList = new List<Amanda__c>();            
            String olds= '';
            String news = '';
            integer count = 0;
            for(Integer i = 0; i< flowsIdsAndName.size();i++){
                news = flowsIdsAndName[i]+','+olds;
                //System.debug('news###'+news);
                if(news.length() > 255){
                    
                    if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                            
                            Amanda__c am = new Amanda__c(name=String.valueOf(cc)+ String.valueOf(count)+'-'+'Flow');
                            am.ComponentIDs__c = olds;
                            am.ComponentType__c = 'Flow';
                            olds = flowsIdsAndName[i];
                            news = '';
                            amList.add(am);
                            count = count + 1;
                            
                        }
                }
                else if(news.length() == 255){
                    if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                        Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                        Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                        Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                            Amanda__c am = new Amanda__c(name= String.valueOf(cc)+String.valueOf(count)+'-'+'Flow');
                            am.ComponentIDs__c = news;
                            am.ComponentType__c = 'Flow';
                            olds = '';
                            news = '';
                            amList.add(am);
                            count = count + 1;
                            
                        }
                }else if(news.length() < 255){
                    if(i == flowsIdsAndName.size()-1 ){
                        if (Amanda__c.SObjectType.getDescribe().isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() &&
                            Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible() && 
                            Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && 
                            Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.name.isAccessible() &&
                            Schema.sObjectType.Amanda__c.fields.name.isCreateable()){
                                Amanda__c am = new Amanda__c(name= String.valueOf(cc)+String.valueOf(count)+'-'+'Flow');
                                am.ComponentIDs__c = news;
                                am.ComponentType__c = 'Flow';
                                olds = '';
                                news = '';
                                amList.add(am);
                                
                            }
                    }else
                    olds = news;
                }
                        
            }
            //System.debug('amList!!'+amList);
            if(Schema.sObjectType.Amanda__c.isCreateable()){
                insert amList;
            }
            amList.clear();
        }       
    }
    
    public void finish (Database.BatchableContext BC) {

        // Make another callout

        // Parse response
        
    }
}