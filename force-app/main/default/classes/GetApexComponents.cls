Global with sharing class GetApexComponents implements Database.Batchable<String>, Database.AllowsCallouts,Database.Stateful {

    public  String sobj;
    public String FieldAPI ;
    public String componentType;
    public final String sessionIdd;
    public final String OrgURL;
    Public List<String> compList;
    Global integer counter = -1;

    // Here obj is selected object , field is selected field ,formulalist is the list of formula fields in case of formulas and random string in any other component, comptype is compponent type
    public GetApexComponents(String sessionid,String obj,String field,List<String> formulaList,String comptype){
        sobj = obj ;
        FieldAPI = field;
        sessionIdd = sessionid;
        String baseurl = System.URL.getSalesforceBaseURL().toExternalForm();
        OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';         
        compList = formulaList;
        componentType = comptype;         
    }
    
    public Iterable<String> start(Database.BatchableContext BC) {
        // System.debug('ApexClass access'+ ApexClass.SObjectType.getDescribe().isAccessible());
        // System.debug('ApexClassId access'+ Schema.SObjectType.ApexClass.fields.Id.isAccessible());
        // System.debug('ApexClassBody access'+ Schema.SObjectType.ApexClass.fields.body.isAccessible());
    
        HTTPResponse response;
    
        if(componentType == 'workflow' || componentType == 'validation' ){  // finding all urllist of workflow/validation rules where field can be used.
        
            compList.clear();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth '+sessionIdd);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('GET');           
            Http http = new Http();
                                  
            sObject s1 = Schema.getGlobalDescribe().get(sobj).newSObject() ;
            Schema.DescribeSObjectResult Result = s1.getSObjectType().getDescribe(); //meta data of selected object
        
            List<Schema.ChildRelationship> Ch = Result.getChildRelationships();  // finding child object of selected object.
            
            Set<string> childList = new Set<String>();            
            Set<string> childObjectList = new Set<String>{'Account','Lead','Contact','Opportunity','Case','Product','Opportunity Line Item','Order','Asset','Agreement'};                    
            
            for (Schema.ChildRelationship cr: Ch){                //iterate through all child relationships of selected object
            
                String sc = String.valueof(cr.getchildSobject());    
                
                integer size = sc.length()-3;
                if(sc.lastindexof('__c')!=-1 && (sc.lastindexof('__c')==size) )   //if and child object is custom add in the list
                     childList.add(String.valueof(cr.getchildSobject())); 
                 else{          
                    if(childObjectList.contains(String.valueof(cr.getchildSobject())))  //else check if child object contains in standard sobject list
                        childList.add(String.valueof(cr.getchildSobject()));
                }
            }
            Ch.clear();
       
            
            if(componentType == 'workflow'){
                req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+fullname,TableEnumOrId+from+workflowrule');
                 req.setTimeout(120000);
                response =http.send(req);
            }
            else if(componentType == 'validation'){
            
                req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+EntityDefinition.DeveloperName+from+ValidationRule');
                 req.setTimeout(120000);
                response =http.send(req);
            }
            
            Set<String> queriedObjList  = new Set<string>();  //initialise a set to store the object on which workflow rules are applied
            List<String> Rlist;
            if(componentType == 'workflow')
                Rlist =  response.getbody().split('"TableEnumOrId":');  //find the object on which workflow rules are applied
            else
                if(componentType == 'validation')
                    Rlist =  response.getbody().split('"DeveloperName":'); //find the object on which validation rules are applied  
            
            
            Map<String,Set<String>> ObjNURLs = new Map<String,Set<String>>();  //initialise a map to store set of workflow urls where object is key
            //system.debug('Rlist@@@@@@'+Rlist);
                   
            if(Rlist!=null && Rlist.size()>0){
                integer i=0;
                for(String r:Rlist){
                    
                    if(r!=Rlist[0]){
                        i =i+1;
                        String objnames =  r.substringBetween('"');
                       
                        if(componentType == 'validation'){
                            if(objnames.lastIndexOf('__c')!=-1 && objnames.lastIndexOf('__c') == objnames.length()-3 ){ 
                                objnames = objnames.substringBeforeLast('__c');
                                if(objnames.countMatches('__')==1)    
                                    objnames = objnames.substringafter('__');  
                            }  
                        }
                        queriedObjList.add(objnames);    //add the object into WorkflowqueriedObjList
                   
                        List<String> URLLsit = Rlist[i-1].split('"url":');
                        String URL = URLLsit[1].substringbetween('"');
                            
                        if(ObjNURLs.containskey(objnames)){   //if map already contains an object then store url into the list
                            Set<String> URLSet = ObjNURLs.get(objnames);
                            URLSet.add(URL);
                            ObjNURLs.put(objnames,URLSet);
                        }
                        else{
                            Set<String> URLSET =new Set<String>();   //initialise a list and add URL into it.
                            URLSET.add(URL);
                            ObjNURLs.put(objnames,URLSET);
                        }
                    }
                }                        
            
            
            }
            Rlist.clear();
            
            Set<string> relName = new Set<string>(); 
             String validobject = sobj;   
            if(componentType == 'validation'){
                 
                if(validobject.lastIndexOf('__c')!=-1 && validobject.lastIndexOf('__c') == validobject.length()-3){ 
                    validobject = validobject.substringBeforeLast('__c');                                                                         
                        if(validobject.countMatches('__')==1)    
                            validobject = validobject.substringafter('__');    
                    
                }  
            }
                               
            relName.add(validobject );
            //system.debug('relName@@@@@@@@'+relName+'ObjNURLs@@@@@@@@'+ObjNURLs);
            //if(sobj != 'USer'){
                for (String s: childList){  //child list the list of object which contains all child object of selected object because field can be used in 
                                            //workflow rules of child object
                    if(componentType == 'validation'){
                        s = s.substringBeforeLast('__c');
                        if(s.countMatches('__')==1) 
                            s = s.substringAfter('__');
                    }
                    if(queriedObjList.contains(s))
                        relName.add(s);             
                }
            //}
            Set<String> URLList = new Set<String>();
            for(string s: relName){        //iterate through object whose workflow rules can contain field                
                    
                    Set<String> URLS = ObjNURLs.get(s);       //get a list of urls of selected object
                    if(URLS  != null && !URLS.isEmpty())
                        URLList.addAll(URLS);
            }
            //system.debug('URLList !!!'+URLList);
            compList.addAll(URLList);     
        }
        
        /* finding Page Layouts */
        if(componentType == 'Page Layout' ){
            compList.clear();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth '+sessionIdd);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('GET');           
            Http http = new Http();
        
            String layID = sobj;
            
            if(sobj.countMatches('__')==2)    
                sobj = sobj.substringafter('__');  
                
                    
            sObject s1 = Schema.getGlobalDescribe().get(layID).newSObject() ;
            Schema.DescribeSObjectResult Result = s1.getSObjectType().getDescribe();
            
            // in page layout url ,for custom object object id is used while for standard object ,object name is used.Layid stored id if customm obj and name 
            
            if(Result.iscustom()){
                req.setEndpoint(OrgURL+'/services/data/v34.0/tooling/query/?q=select+id,developername+from+customobject+where+developername=\''+sobj.substringbeforelast('__c')+'\'');
                HTTPResponse objres = http.send(req); 
                
                List<String> layIDList = objres.getBody().split('"Id":');
                String SobjID = layIDList[1].substringbetween('"');
                layIDList.clear();
                layID = SobjID;
            }
            
            req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+FullName+from+layout+where+TableEnumOrId=\''+layID+'\'');   
            req.setTimeout(120000);
                                
            HTTPResponse Layoutres = http.send(req);  //layout metadata for selected object          

            List<String> SplittedNames = Layoutres.getBody().split('"FullName":');            
            List<String> URLList = new List<String>();
            String approvalpattern = '.*\\s04a[a-zA-Z0-9]{12}$';     //to remove approval process page layouts from criteria.regex of approval process layout
            Pattern approvallayout = Pattern.compile(approvalpattern );
    
    
            for(integer i=1;i<SplittedNames.size();i++){
    
                String layoutname  = SplittedNames[i].substringBetween('"');   
                List<String> layoutURLList = SplittedNames[i-1].split('"url":');  
                String url = layoutURLList[1].substringbetween('"');
                layoutURLList.clear();
                Matcher MyMatcher = approvallayout.matcher(layoutname);
    
                if(!MyMatcher.matches())
                    URLList.add(url);
            }
            SplittedNames.clear();
            
            compList.addAll(URLList); 
        }
        
        /* finding Page Layouts ends */
        
        
        return compList;
    
    
    
    }
    
    public void execute (Database.BatchableContext BC, List<String> scope) {    
        //system.debug('execute!!!'+scope.size());
        counter = counter +1;
        List<ValidationWrapper> GeneralList  = new List<ValidationWrapper>();
        HttpRequest req = new HttpRequest();
        //system.debug('session'+UserInfo.getSessionId());                                          //instantiate HTTP request
        req.setHeader('Authorization', 'OAuth '+sessionIdd );
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        req.setTimeout(120000);
        Http http = new Http();
        
        String prefix ;
        if(FieldAPI.countMatches('__')==2){
            prefix = FieldAPI.substringbefore('__');
            FieldAPI = FieldAPI.substringafter('__');             
        }
        
        /* finding formula field */   //Purpose is just to find ids of formula fields
        if(componentType  == 'formula'){
        List<ValidationWrapper> FormulaList = new List<ValidationWrapper>();
        
        //here scope is the list of formula field names with its object name separated by dot.
        for(String ff:scope){   
        
            String OBJFormula =ff;
            //system.debug('OBJFormula ###########'+OBJFormula );
            
            if(ff != null && ff !=''){ 
                ff=ff.substringafter('.');
                ff = ff.substring(0,ff.lastindexof('__c')); //this is formula fieldname
                
                if(ff.countMatches('__')==1)
                    ff = ff.substringafter('__');   //this is used to remove prefix
               
            }   
           
            req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+id,FullName+from+CustomField+where+DeveloperName=\''+ff+'\'');
            HTTPResponse formularesponse =http.send(req); 
            //system.debug('formularesponse !!!!!'+formularesponse.getBody() );
            
            if(prefix != '' && prefix != null &&  !OBJFormula.contains(prefix +'__'))
                OBJFormula = prefix + '__'+OBJFormula;  // to add prefix in object name.
                
            //system.debug('OBJFormulaagain%%%%% '+OBJFormula );
             
            String FormulaFieldId='';   
            if(formularesponse.getBody()!=null){
            
                List<string> SizeList = formularesponse.getBody().split('"size":');               
                String Size = SizeList[1].substring(0,SizeList[1].indexof(',',0));
                SizeList.clear();
                
                if(Integer.valueOf(size)>0){  
                    if(Integer.valueOf(size)>1){ //meaning same formula field name is used in more than one object.
                    
                        List<String> FullnameList = formularesponse.getBody().split('"FullName":');
                        
                        for(integer i=0;i<FullnameList.size();i++){
                            
                            if(FullnameList[i].substringBetween('"')==OBJFormula){   
                                
                                List<string> IDlistt  = FullnameList[i-1].split('"Id":');
                                FormulaFieldId  = IDlistt[1].substringBetween('"') ;   //add formula field URL in the list
                                IDlistt.clear();
                                break;
                            }
                        } 
                        FullnameList.clear();
                    }else if(Integer.valueOf(size)== 1){
                        List<string> IdList = formularesponse.getBody().split('"Id":');                     
                        FormulaFieldId = IdList[1].substringbetween('"');
                        IdList.clear();
                        
                    }
                }   
            }   
                        
                ValidationWrapper obj =new ValidationWrapper(ff,FormulaFieldId,'Formula Field');                                    
                GeneralList.add(obj);      
            }
            scope.clear();    
        }
        // Finding Formula field IDs end
        
        /* finding apex class or apex trigger */
        if(componentType== 'apexclassntrigger'){
        
            Map <String,Schema.SObjectType> schemaMap=Schema.getGlobalDescribe();       
            Schema.DescribeSObjectResult obj  = schemaMap.get(sobj).getDescribe();
            Schema.DescribeFieldResult fres ;
            if(prefix != null && prefix != '')
             fres = obj.Fields.getMap().get(prefix+'__'+FieldAPI).getDescribe();
             else
                 fres = obj.Fields.getMap().get(FieldAPI).getDescribe();
                 
            String Fstandard;
            
            String fields = FieldAPI.substringBeforeLast('__c').replace('_', '+');   //format field for searching using tooling api
            // system.debug(fields);
            // system.debug(FieldAPI);
            // system.debug(OrgURL);
            if(fres.isCustom() == true){
                Fstandard = 'custom Field';
                req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/search/?q=FIND{'+ fields+'}');
            }
            else{
                Fstandard = 'standard Field';
                req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/search/?q=FIND{'+FieldAPI+'}'); 
            }
            // system.debug(req);
            Set<String> ClassIDList = new Set<String>();   //initialise sets to store class ids and triggers ids where particular field is used
            Set<String> TriggerIDList = new Set<String>();  
                         
            String detailedresp= http.send(req).getBody(); 
            // system.debug('detailedresp@@@@@@@@@@'+detailedresp);
                
            if(detailedresp != null){
                List<String> ComponenURLList = detailedresp.split('"url":');
                
                if(ComponenURLList!=null && ComponenURLList.size()>0){
                
                    for(String s:ComponenURLList){
                        if(s!=ComponenURLList[0]){
                                 
                            string urls =s.substringBetween('"');
                            if(urls.contains('ApexClass'))
                                ClassIDList.add(urls.substringAfterLast('/'));                      
                            else
                            if(urls.contains('ApexTrigger'))
                                TriggerIDList.add(urls.substringAfterLast('/'));
                        } 
                    }  
                } 
                ComponenURLList.clear();
            } 
            
            
            //finding parent object of selected object
            Set<string> childObjectList = new Set<String>{'Account','Lead','Contact','Opportunity','Case','Product','Opportunity Line Item','Order','Asset','Agreement'};
            
            Set<String> lookupList = new Set<String>();
            Map<String,Schema.SObjectField> schemaFieldMap = schemaMap.get(sobj).getDescribe().fields.getMap();  //describe field schema of selected object
                
            for(Schema.SObjectField fieldd:schemaFieldMap.values()){
                List<Schema.sObjectType> listt = fieldd.getDescribe().getReferenceTo();   //check if field is lookup
                
                if(listt.size()>0){
                
                    String  lookupfield = String.valueof(listt[0]);     //this is lookup object
                    if(lookupfield.lastindexof('__c')!=-1 && lookupfield.lastIndexOf('__c') == lookupfield.length()-3){  //if lookup object is custom add into lookup list
                        lookupList.add(lookupfield);
                        
                    }
                    else{
                        
                        if(childObjectList.contains(lookupfield))
                            lookupList.add(lookupfield);                   
                    }   
                }  
                listt.clear();
            }
            //system.debug('lookuplist----'+lookuplist);
            Set<String> relationList = new Set<String>(); 
            
            for(String lookup:lookupList){   //iterate through all all lookup objects
                
                Schema.DescribeSObjectResult R = schemaMap.get(lookup).getDescribe();
                List<Schema.ChildRelationship> C = R.getChildRelationships();              //find out all child relationship of child object
                for(Schema.ChildRelationship ci:C){
                    if(string.valueof(ci.getChildSObject())==sobj){
                        if(ci.getRelationshipName()!=null ){
                             if(ci.getRelationshipName().countmatches('__') == 2)
                                relationList.add(ci.getChildSObject()+':'+ci.getRelationshipName().substringafter('__') ); 
                            else
                                relationList.add(ci.getChildSObject()+':'+ci.getRelationshipName() );
                        }
                    }                 
                }
                 C.clear();
            }
           
            lookupList.clear();
            
            Map<string,string> objNfieldCombo =new Map<string,string>();
            
            Schema.DescribeSObjectResult objdes = schemaMap.get(sobj).getDescribe();
            List<Schema.ChildRelationship> relationship = objdes.getChildRelationships();         
            
            for(Schema.ChildRelationship ci:relationship){
            
                String fname = String.valueof(ci.getField());
                string objname = String.valueof(ci.getChildSObject());
                if(objname.lastindexof('__c')!=-1 && objname.lastIndexOf('__c') == objname.length()-3){
                    if(objname.countMatches('__') == 2)
                        objname = objname.substringAfter('__');
                }
                
                if(fname.lastindexof('__c')!=-1 && fname.lastIndexOf('__c') == fname.length()-3){
                        if(fname.countMatches('__') == 2)
                            fname = fname.substringAfter('__');
                        fname = fname.substring(0,fname.lastindexof('__c'))+'__r';
                        objNfieldCombo.put(objname,fname);
                }
                else{                  
                    objNfieldCombo.put(objname,fname.substringbefore('Id')); 
                }           
            }
            relationship.clear();
            childObjectList.clear();
            
            List<String> classIDS = new List<string>();
            List<String> TriggerDS = new List<string>();
            
            List<ValidationWrapper> ComponentWrapperMap;
            
            if(Fstandard=='standard Field'){            
                ComponentWrapperMap = fetchcomponentWrapper( sobj, FieldAPI,ClassIDList,TriggerIDList,relationList,objNfieldCombo);   //relation list contains all relationship name of selecetd object          
                 
            }
            else{
                if(Fstandard=='custom Field'){
                    String FieldAPIs;
                    
                    if(FieldAPI.countMatches('__')==2)
                        FieldAPIs = FieldAPI.substringAfter('__');
                    else
                        FieldAPIs = FieldAPI;
    
                                
                    String fieldss = FieldAPIs.substring(0,FieldAPIs.lastindexof('__c'));
                    
                    req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+id+from+CustomField+where+DeveloperName=\''+fieldss+'\'');
                    
                    String Customresp = http.send(req).getBody();               
                   
                    if(Customresp!=null && Customresp!='' ){
                    
                        List<string> SizeList = Customresp.split('"size":');
                        
                        if(SizeList!=null && SizeList.size()>0){
                        
                            String Size = SizeList[1].substring(0,SizeList[1].indexof(',',0));
                            
                                if(Integer.valueof(size)==1){
                                    //system.debug('single object');
                                    
                                    Set<String> singlefidclassSet = new Set<string>();
                                    Set<String> singlefidtriggerSet = new Set<string>();
                                    // For Field and Object Security Check
                                    if(
                                        ApexClass.SObjectType.getDescribe().isAccessible() &&
                                        Schema.SObjectType.ApexClass.fields.Id.isAccessible() &&
                                        Schema.SObjectType.ApexClass.fields.body.isAccessible()
                                    ){
                                        for(ApexClass app:[select id,body from ApexClass where id in:ClassIDList]){
                                            if(app.body.toLowerCase().contains(FieldAPI.toLowerCase())){                                                              
                                                classIDS.add(app.id);  
                                            }
                                            
                                        }
                                        // System.debug('Inside Apex Class Block**'+classIDS);
                                    }
                                    
                                    // For Field and Object Security Check
                                    if(
                                        ApexTrigger.SObjectType.getDescribe().isAccessible() &&
                                        Schema.SObjectType.ApexTrigger.fields.Id.isAccessible() &&
                                        Schema.SObjectType.ApexTrigger.fields.body.isAccessible()
                                    ){
                                        for(ApexTrigger apt:[select id,body from ApexTrigger where id in:TriggerIDList]){
                                            if(apt.body.toLowerCase().contains(FieldAPI.toLowerCase())){                                                           
                                                TriggerDS.add(apt.id);      
                                            }             
                                        }
                                        // System.debug('Inside Apex Trigger Block**'+TriggerDS);
                                    }
                                    
                                      
                                }
                                else{
                                    if(Integer.valueof(size)>1){
                                                                            
                                        ComponentWrapperMap = fetchcomponentWrapper( sobj, FieldAPI,ClassIDList,TriggerIDList,relationList,objNfieldCombo); 
                                    }
                                }
                        }
                    }//response if close
                }//custom if close          
            }
            ClassIDList.clear();
            TriggerIDList.clear();
            // system.debug('ComponentWrapperMap##############'+ComponentWrapperMap);
            if(ComponentWrapperMap != null && !ComponentWrapperMap.isEmpty()){
                for(ValidationWrapper v:ComponentWrapperMap){
                    if(v.type == 'Apex Class' )
                        classIDS.add(v.compid);
                    else if(v.type == 'Apex Trigger')
                        TriggerDS.add(v.compid);        
                }
            }
            
            // storning ID of apex class and apex trigger in custom setting
            integer counting = 0;
            // system.debug('classIDS@@@@@@@'+classIDS+'TriggerDS@@@@@'+TriggerDS);
            List<Amanda__c>  amList = new List<Amanda__c>();   
            if(!classIDS.isEmpty()){
                       
                String s= '';
                for(Integer i = 0; i< classIDS.size();i++){
                
                    s = classIDS[i].mid(0,15)+','+s;
                    //system.debug('value@@@@'+s);
                    //code for check user permissions on object
                                                  
                    if(i+1 == classIDS.size() || math.mod(i+1,15) == 0  ){    //we can store 15 ids in one custom setting record.
                        Amanda__c am = new Amanda__c(name= String.valueOf(counting )+'-'+'Apex Class');
                        //Code to check createable permission for fields
                        if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                            && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                                am.ComponentIDs__c = s;
                                am.ComponentType__c = 'Apex Class';
                                s = '';
                                amList.add(am);
                                counting = counting +1; 
                            }
                    }           
                }
                 
            }
            
            counting = 0;
            if(!TriggerDS.isEmpty()){
                //List<Amanda__c> amList = new List<Amanda__c>();            
                String s= '';
                for(Integer i = 0; i< TriggerDS.size();i++){
                
                    s = TriggerDS[i].mid(0,15)+','+s;
                                                  
                    if(i+1 == TriggerDS.size() || math.mod(i+1,15) == 0  ){
                        Amanda__c am = new Amanda__c(name= String.valueOf(counting)+'-'+'Apex Trigger');
                        if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                            && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                                am.ComponentIDs__c = s;
                                am.ComponentType__c = 'Apex Trigger';
                                s = '';
                                amList.add(am);
                                counting = counting +1;
                            }
                    }           
                }                                         
            }
            if(amList != null && !amList.isEmpty() && Schema.sObjectType.Amanda__c.isCreateable()){
                //system.debug('amList@@@@@@'+amList);
                insert amList;
                amList.clear();
            } 
        }
        
         /* Finding Workflow and validation Rules */
        if(componentType == 'workflow' || componentType == 'validation' ){
        
            Map <String,Schema.SobjectType> schemaMap=Schema.getGlobalDescribe();                         
            sObject s1 = schemaMap.get(sobj).newSObject() ;
            Schema.DescribeSObjectResult Result = s1.getSObjectType().getDescribe();
        
            List<Schema.ChildRelationship> Ch = Result.getChildRelationships();    // get child objects of selected object
            Set<string> childList = new Set<String>();
            
            Set<string> childObjectList = new Set<String>{'Account','Lead','Contact','Opportunity','Case','Product','Opportunity Line Item','Order','Asset','Agreement'};        
            
            
            for (Schema.ChildRelationship cr: Ch){                //iterate through all child relationships of selected object
            
                String sc = String.valueof(cr.getchildSobject());    
                
                integer size = sc.length()-3;
                if(sc.lastindexof('__c')!=-1 && (sc.lastindexof('__c')==size) )   //if and child object is custom add in the list
                     childList.add(String.valueof(cr.getchildSobject())); 
                 else{          
                    if(childObjectList.contains(String.valueof(cr.getchildSobject())))  //else check if child object contains in standard sobject list
                        childList.add(String.valueof(cr.getchildSobject()));
                }
            }
            Ch.clear();
            childObjectList.clear();
            childList.add(sobj);  // childList contains all child object of selected object including selected object.
            
            
            List<string> LookupFieldList = new List<String>();
            Map<String,List<String>> objectNlookupSobj = new Map<String,List<String>>(); 
            
            
            for(string child:childList){    //iterate through all child object of selected object
                LookupFieldList = new List<String>();
                                         
                Map<String, Schema.SObjectField> schemaFieldMap1 = schemaMap.get(child).getDescribe().fields.getMap();  //find field description of all child object
                String child1 = child;
                if(child1.lastIndexOf('__c')!=-1 && child1.lastIndexOf('__c') == child1.length()-3){
                       
                    if(child1.countMatches('__')==2)
                        child1 = child1.substringafter('__');        //done to remove prefix
                       
                }  
                else
                    if(child1.countMatches('__')==2)
                        child1 = child1.substringafter('__');
                                
                for (Schema.SObjectField fn: schemaFieldMap1.values()){                      
                    List<Schema.sObjectType> listt = fn.getDescribe().getReferenceTo();
                   
                    if(listt.size()>0){ 
                        for(Schema.sObjectType l:listt){
                      
                        if(String.valueof(l)==sobj){
                            string FIELDNAME = fn.getDescribe().getName();   //
                                if(fn.getDescribe().isCustom())
                                     FIELDNAME = FIELDNAME.substring(0,FIELDNAME.lastindexof('__c'))+'__r'; 
                                 else                                 
                                     FIELDNAME  = FIELDNAME.substringbefore('Id'); 
                                 if(FIELDNAME   == 'Owner' && listt.size() > 1 )
                                     LookupFieldList.add('Owner:User');       
                                 else                                
                                     LookupFieldList.add(FIELDNAME );    
                                                         //this is the list of all lookup fields in child object(where selected object has lookup)
                                
                             }
                         }
                    }
                } 
               objectNlookupSobj.put(child,LookupFieldList);
            }
            
            if(scope != null && scope.size()>0 ){
                //system.debug('scope ############'+scope );
                //system.debug('objectNlookupSobj@@@@@'+objectNlookupSobj);
                String fie = FieldAPI.replaceAll(' ','');                        
                if( prefix != null && prefix != '' && !FieldAPI.contains(prefix +'__'))
                    fie = prefix +'__'+fie;
                //system.debug('fie!!!!!'+fie);
                        
                for(String url:scope){                       // List of Workflow or validaion url in which fields need to be checked.
                
                    req.setEndpoint( OrgURL+url);                 //send a request to url                       
                    String respose = http.send(req).getBody(); 
                    
                    List<string> wIDList =respose.split('"Id":'); 
                    String wID = wIDList[1].substringbetween('"');         // WID contains workflow or validation id.
                    wIDList.clear();
                    
                    List<string> nameList;
                    if(componentType == 'workflow')
                        nameList =respose.split('"Name":'); 
                    else
                        if(componentType == 'validation')
                            nameList =respose.split('"ValidationName":'); 
                    String wname = nameList[1].substringbetween('"');       // wname contains Workflow or validation name.
                    nameList.clear();               
                    
                    //system.debug('FieldAPI!!!!!'+FieldAPI);
                    if(componentType == 'workflow'){
                    
                        List<String> objectList =respose.split('"TableEnumOrId":');
                        String objname = objectList[1].substringbetween('"');  // objname is the object on which workflow rules are applied
                        objectList.clear();
                                                          
                        List<String> WorkFields = respose.split('"field":');           // fields used in entry criteria
                        
                        List<String> FormulaList = respose.split('"formula":');         
                        Integer eindex=  FormulaList[1].indexof('"urls":');                        
                        String Formula = FormulaList[1].substring(1,eindex);      // formula used in Workflow or validation rules
                        FormulaList.clear();   
                        Set<String> Flist = new Set<String>();  //initialise set to store the field used in workflow rule criteria
                        
                        for(string w:WorkFields){
                            if(w!=WorkFields[0]){                    
                                string f = w.substringbetween('"');
                                                
                                if(f.contains(sobj)){
                                            
                                    Flist.add(f.substringAfterLast(sobj+'.'));   // Flist is the list of fields used in entry criteria
                                }
                            }                  
                        }
                       
                        boolean flag=false;
                        
                        if(Formula != 'ull'){                           
                            List<string > LookupListtt = objectNlookupSobj.get(objname ); 
                            if(LookupListtt == null){
                                LookupListtt = objectNlookupSobj.get(objname +'__c');
                                
                                if(LookupListtt == null && prefix != null && prefix != '' && !objname.contains(prefix +'__')){
                                    LookupListtt = objectNlookupSobj.get(prefix +'__'+objname +'__c');                                
                                }  
                            }
                            flag = checkFormula(sobj,objname,fie,Formula,LookupListtt);                            
                        }   
                        //system.debug('Flist!!!'+Flist+'fie!!!'+fie); 
                        if(Flist.contains(fie) || flag){     // checking entry critera and formula field used in workflow rules
                            ValidationWrapper obj =new ValidationWrapper(wname,wID,'WorkFlow Rule');                    
                            GeneralList.add(obj);                                                                       
                        }     
                    }//if close
                    else if(componentType == 'validation'){
                    
                            List<String> fullnameList =respose.split('"FullName":');
                            String objname = fullnameList[1].substringbetween('"');
                            objname  = objname.substringbefore('.');
                             
                            List<String> Splittedvalidation =respose.split('errorConditionFormula');
                            integer eindex = Splittedvalidation[1].indexof('"errorDisplayField":');
                            String errorconditionformuls = Splittedvalidation[1].substring(0,eindex);

                            boolean flag;
                            if(errorconditionformuls!='ull'){   
                                
                                List<string > LookupListtt = objectNlookupSobj.get(objname ); 
                                
                                //if(LookupListtt == null)
                                       // LookupListtt = objectNlookupSobj.get(objname +'__c');
                                 
                                if( prefix != null && prefix != '' ){         
                                    //LookupListtt = objectNlookupSobj.get(prefix +'__'+objname +'__c');
                                    
                                    if(!FieldAPI.contains(prefix +'__'))
                                        FieldAPI = prefix +'__'+FieldAPI ; 
                                 }   
                                 flag = checkFormula(sobj,objname ,FieldAPI,errorconditionformuls,LookupListtt);                            
                            }   
                                               
                            if(flag){ 
                                 ValidationWrapper obj =new ValidationWrapper(wname,wID,'Validation Rule');                                    
                                 GeneralList.add(obj);                                                                                                      
                            }   
                                            
                        }//else close
                    }  //for close                 
                }  // if close 

                //system.debug('GeneralList########'+GeneralList        );        
        }
        
        /* Finding Workflow and validation Rules ends */
        
        
        /* Finding Page layouts*/
        
        if(componentType == 'Page Layout' ){    
            for(String url:scope){     // Scope is the List of url in Page layouts
            
                req.setEndpoint( OrgURL+url);            
                HTTPResponse Layoutfieldres = http.send(req); 
                
                string resp = Layoutfieldres.getBody();           
                 //system.debug('resp!!!'+resp);
                List<String> fieldList = resp.split('"field":');
                
                List<String> splittedName =resp.split('"Name":');                      
                String layoutname = splittedName[1].substringbetween('"');           
                
                List<String> splittedID =resp.split('"Id":');                        
                String ID = splittedID[1].substringbetween('"');          
                
                Set<String> AllfieldSet = new Set<String>();
                for(String SplittedField:fieldList){
                
                    if(SplittedField!=fieldList[0]){
                                                           
                        String f=SplittedField.substringbetween('"');
                        AllfieldSet.add(f);                    
                    }
                }
                fieldList.clear();
               
                if(prefix != null && prefix != '' && !FieldAPI.contains(prefix+'__'))
                    FieldAPI = prefix +'__' +FieldAPI ;
                
                if(AllfieldSet.contains(FieldAPI)){
                
                    ValidationWrapper obj = new ValidationWrapper(layoutname,ID,'Page Layout');                                                 
                    GeneralList.add(obj);                
                } 
                AllfieldSet.clear();
            }//Finding PageLayout
        }
            
        /* Finding Page Layout ends */
        
        
         /* storing data into custom settings*/
         if(componentType == 'workflow' || componentType  == 'Page Layout' || componentType == 'validation'  || componentType == 'formula'  ){
            String comp ;
            if(componentType == 'workflow' )
                comp = 'WorkFlow Rule';
            else if(componentType == 'Page Layout' )
                comp = 'Page Layout';
             else if(componentType == 'validation' )
                 comp = 'Validation Rule';
             else if(componentType == 'formula' )
                 comp = 'Formula Field';
            
            
            List<Amanda__c> amList = new List<Amanda__c>();            
            String olds= '';
            String news = '';
            integer count = 0;
            
            for(Integer i = 0; i< GeneralList.size();i++){
                //system.debug('formula###'+GeneralList[i]);
            
                news = GeneralList[i].compid.mid(0,15)+';'+GeneralList[i].VName+','+olds;
                 //system.debug('news###'+news);
                if(news.length() > 255){   // this id ane name combo can not be stored in this custom setting record,so stored in old variable.
                
                   
                    Amanda__c am = new Amanda__c(name=String.valueOf(counter)+ String.valueOf(count)+'-'+comp);
                    if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                        && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                            am.ComponentIDs__c = olds;
                            am.ComponentType__c = comp;
                            olds = GeneralList[i].compid.mid(0,15)+';'+GeneralList[i].VName;
                            news = '';
                            amList.add(am);
                            count = count + 1;
                        }
                    
                    
                    if(i+1 == GeneralList.size() ){
                        Amanda__c am1 = new Amanda__c(name=String.valueOf(counter)+ String.valueOf(count)+'-'+comp);
                        if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                            && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                                am1.ComponentIDs__c =  GeneralList[i].compid.mid(0,15)+';'+GeneralList[i].VName;
                                am1.ComponentType__c = comp;                       
                                amList.add(am1);
                            }
                        
                    }                    
                }
                else if(news.length() == 255){   // this is the last id and name that can be stored in custom setting record.
                    Amanda__c am = new Amanda__c(name= String.valueOf(counter)+String.valueOf(count)+'-'+comp);
                    //Code to check createable permission for fields
                    if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                        && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                            am.ComponentIDs__c = news;
                            am.ComponentType__c = comp;
                            olds = '';
                            news = '';
                            amList.add(am);
                            count = count + 1;
                        }
                    
                    
                }else if(news.length() < 255){  // means more id and names can be stored in custom setting record.
                    if(i == GeneralList.size()-1 ){
                         Amanda__c am = new Amanda__c(name= String.valueOf(counter)+String.valueOf(count)+'-'+comp);
                        if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                            && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                                am.ComponentIDs__c = news;
                                am.ComponentType__c = comp;
                                olds = '';
                                news = '';
                                amList.add(am);
                            }
                        
                    
                    
                    }else
                    olds = news;
                }
                            
            }
            //system.debug('amList!!'+amList);
             if(Schema.sObjectType.Amanda__c.isCreateable()){
                 insert amList;
                 amList.clear();
             }
            }
 
        }
    
   
    
    String query12;
    public List<String> fetchinnerquery(String query){ //function invoked to fetch the part of inner query from the query itself 
    
        //system.debug('query----'+query);
        List<String> innerqueryList = new List<string> ();       //initialise list to sore all inner query of  a query                           

        while(query.contains('(select ') && query.contains(')') ){ //check query contains inner query
            integer startindex = query.indexof('(select ');
            
            integer endindex;
            if(query.contains('),'))                //if more than one sub query exist
                endindex = query.indexof('),',startindex)+1;
            else
                endindex = query.indexof(')',startindex)+1; 
                                
            string sub = query.substring(startindex,endindex);
            innerqueryList.add(sub);                      // add innner query into the list
           
            query  = query.replace(sub,'');               // replace the inner qyery with space to remove innner query that has been add into the lsit
                         
        }
        //system.debug('innerqueryList----'+innerqueryList);
        return innerqueryList;      
    }
    
    public String fetchouterquery(String query){  // function invoke to fetch outer query
        
        //system.debug('query-----'+query);
        while(query.contains('(select ') && query.contains(')') ){  //untill inner query is found in the query replace the inner query with space
            integer startindex = query.indexof('(select ');
            integer endindex;
            if(query.contains('),'))
                endindex = query.indexof('),',startindex)+1;
            else
                endindex = query.indexof(')',startindex)+1;    
            string sub = query.substring(startindex,endindex);
           
            query  = query.replace(sub,'');                         
        }
        //system.debug('outerquery---'+query);
        //system.debug('heapsize@@@@@@@@@!!!!'+Limits.getHeapSize() );
        return query;         // return outer query
    }
    
    String flag1;
    String objectname;
    string fieldname;
    List<string> GlobalQueryList;
    
    Public String fetchSoqLQuery(String input,String Patterns,Set<String> relationList,String FieldAPIs,String objnames,Map<String,String> objNfieldCombo){
                       
        String flag1='FALSE';
        List<string> QueryList = input.split('\\[select ');  // input is the body of apex class  or apex trigger in query list we get the list of all soql  
        String objname;
        if(QueryList != null && QueryList.size()>0){            
            for(String q:QueryList){                        // iterate through all queries
                if(q!=QueryList[0]){
                    String query ='select '+q.substringBefore(';');          //get the query
                    
                    String query11 =fetchouterquery(query); 
                  //fetch outer query
                  //system.debug('query11!!!!!!!!'+query11);
                  //system.debug('objNfieldCombo!!!'+objNfieldCombo);
                  //system.debug('FieldAPIs!!!!!'+FieldAPIs);
                    
                    // objNfieldCombo is map which contains lookupfield of selected object where child object is key
                    for(string relfieds:objNfieldCombo.values()){     //for finding relationship field in outer query
                        String rsfields = relfieds+'.'+FieldAPIs;
                        if(query11.toLowerCase().contains(rsfields.toLowerCase())){                         
                            flag1='true';
                            return flag1;    
                        }
                    }              
                    objectname = objnames;
                    //system.debug('query11!!!!!!!'+query11);
                    boolean found =PatternMatcher(Patterns,query11,'Fieldanalyse');   //for finding normal fields in outer query
                    if(found==true){                    
                        flag1='true';
                        return flag1;                 
                    }
                    else{
                        
                        String patterns11 = '.*from\\s*'+objnames.toLowerCase()+'\\s.*where.*'+FieldAPIs.toLowerCase()+'.*'; //for finding fields in where clause
                        //system.debug('whereclause---'+objnames+'----'+FieldAPIs+'patterns11!!'+patterns11);
                        boolean found1 =PatternMatcher(patterns11,query11,'Fieldanalysewhere');
                        if(found1==true){                                                          
                            flag1='true';
                            return flag1;                                   
                        }
                    }     
                  
                    if(flag1!='true') {  //if field is not found in outer query check in inner query
                        
                        List<string> innerList = fetchinnerquery(query);    //innerlist the list of inner queries
                        
                        if(innerList!=null && innerList.size()>0){
                        
                            relationList.add('object'+':'+objnames);    //done due tquery reside in IN operator                                   
            
                            for(String s:innerList){            //iterate through all inner queries
                                //  objNfieldCombo is map child object v/s lookfield                    
                                for(string relfieds:objNfieldCombo.values()){   //for finding relationship field
                                    String rsfields = relfieds+'.'+FieldAPIs;
                                    if(s.toLowerCase().contains(rsfields.toLowerCase())){
                                        flag1='true';                                       
                                        return flag1;    
                                    }
                                }
                                
                                for(string r:relationList){  //relationlist is the list of relationship names used in query
                                
                                    //system.debug('name@@@'+r);
                                    List<string> objNrel = r.split(':');
                                    r = objNrel[1];
                                    objectname = r;
                                    
                                    String patterns1 = '.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+'\\s.*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+'\\).*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+'\\].*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+';.*';                       
                                    
                                    //system.debug('body---newdtobe checed'+s);
                                    //system.debug('objectname---'+objectname);
                                    
                                    boolean found1 =PatternMatcher(patterns1,s,'Fieldanalyse');
                                    if(found1==true){                                   
                                        flag1='true';
                                        return flag1;                                   
                                    } 
                                    else{                    //check in where part of query             
                                        String patterns11 = '.*from\\s*'+r.toLowerCase()+'\\s.*where.*'+FieldAPIs.toLowerCase()+'.*'; 
                                        found1 =PatternMatcher(patterns11,s,'Fieldanalysewhere');
                                        if(found1==true){                                   
                                            flag1='true';
                                            return flag1;                                   
                                        } 
                                        
                                    }
                                }
                                                                                      
                            }//for close
                        }//if close
                    }//if close   
                    
               
            }//if close
        }//for close
    }
        QueryList.clear();        
        if(flag1!='true'){//check in dynamic query
            List<string> QueryList1 = input.split('\'select ');
            if(QueryList1 != null && QueryList1.size()>0){
                for(String q:QueryList1){
                    if(q!=QueryList1[0]){
                    
                        String query = 'select '+q.substringBefore(';');  // get the query                                              
                        String query11 = fetchouterquery(query);
                        
                        query11 =query11.substring(0,query11.lastindexof('\''))+';';
                        //system.debug('query1--'+query11);
                        boolean found =PatternMatcher(Patterns,query11,'Fieldanalyse');
                        if(found==true){                       
                            flag1='true';
                            break;                       
                        }//if close
                    }
                }//for close
            }
        }//if   close                
        return flag1;
 
    }
    Public boolean PatternMatcher(String Patterns,string body,String analysetype){  //pattern matcher used in regular expressions
        
       
        Pattern MyPattern = Pattern.compile(Patterns);
       
        String chunkbody = body.toLowerCase();
        if(body.contains('\r\n'))
            chunkbody = body.toLowerCase().replace('\r\n','');
        else
            if(body.contains('\n'))
                chunkbody = body.toLowerCase().replace('\n','');         
         
        String objnamestring  =chunkbody.substringafter('from ').removestart(' ');  //take out string part after from
        //objnamestring = objnamestring.removestart(' ');    
        String fieldnamestring='';     
        if(analysetype.contains('Fieldanalyse')){
        
            if(objnamestring!=null && objnamestring!='') {
                fieldnamestring = chunkbody;
                if(analysetype == 'fieldanalysewhere') 
                    fieldnamestring = chunkbody.substringafter('where ');
                else
                    if(analysetype == 'Fieldanalyse')
                        fieldnamestring = chunkbody.substringbefore('from ');
                       
                if(fieldnamestring.contains(fieldname.toLowerCase()) && objnamestring.startswith(objectname.toLowerCase()) ){
                    string f = chunkbody.substringBefore(fieldname.toLowerCase());        
                                        
                    objnamestring = objnamestring.replaceFirst(objectname.toLowerCase(),'');
                    //system.debug('objnamestring---'+objnamestring+'field---'+f);
                    if((objnamestring.startswith(' ') || objnamestring.startswith(')') || objnamestring.startswith(']') || objnamestring.startswith(';'))&&(f.endsWith(' ') || f.endsWith(',')) ){
                        //system.debug('chunkbpdy---'+chunkbody+'MyPattern---'+MyPattern);
                        Matcher MyMatcher = MyPattern.matcher(chunkbody);            
                        if(MyMatcher.find()) { 
                            chunkbody = null;
                            return true;
                        }
                    }
                }
            }
        }        
        return false;
    }
    
    
    List<string> globalLists  ; 
    
    Public List<ValidationWrapper> fetchcomponentWrapper(String sobj,String FieldAPI ,set<String> ClassIDList,set<string> TriggerIDList,Set<string> relatonList,Map<string,String> objNfieldCombo){  // function invoke if field is used in mre than two objects
        
        //system.debug('fetchcomponentWrapper---'+FieldAPI); 
        objectname = sobj;
        fieldname =FieldAPI; 
                      
        String objtype;
        String objname;
        objname = objectname;
        
        if(sobj.lastIndexOf('__c')!=-1 && sobj.lastIndexOf('__c') == sobj.length()-3){
                    
            if(sobj.countMatches('__')==2)
                sobj = sobj.substringafter('__');        //done to remove prefix 
                                             
        }
                
        String relationfield = objname+'.'+ FieldAPI ;
                
        //system.debug('ClassIDList---'+ClassIDList+'sobj---'+sobj);
                
        List<ValidationWrapper> ComponentWrapper = new List<ValidationWrapper>();
        
        if(ClassIDList!=null && ClassIDList.size()>0){
            //For Object & Field Security Check
            if(
                ApexClass.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.ApexClass.fields.Id.isAccessible() &&
                Schema.SObjectType.ApexClass.fields.body.isAccessible() &&
                Schema.SObjectType.ApexClass.fields.name.isAccessible()
            ){
                // System.debug('Inside Apex Class 2 block');
                for(ApexClass ap:[select id,name,body from ApexClass where id in:ClassIDList and Name !='MetadataService'  ] ){
                    if(ap.body!=null ){
                        
                        String FieldAPIs;
                        
                        if(FieldAPI.lastIndexOf('__c')!=-1 && FieldAPI.lastIndexOf('__c') == FieldAPI.length()-3){
                            
                            if(FieldAPI.countMatches('__')==2)
                                FieldAPIs = FieldAPI.substringafter('__');        //done to remove prefix 
                            else    
                                FieldAPIs = FieldAPI;                                
                        }else 
                            FieldAPIs = FieldAPI;  
                        
                        String patterns = '.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s*,' +'.*from\\s*'+sobj.toLowerCase()+'\\s.*'+ 
                            '|.*select'+'\\s*'+FieldAPIs.toLowerCase() +'.*from\\s*'+sobj.toLowerCase()+'\\s.*'+
                            '|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s'+'\\s*from\\s*'+sobj.toLowerCase()+'\\s.*'+
                            '|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s*,' +'.*from\\s*'+sobj.toLowerCase()+'\\).*'+
                            '|.*select'+'\\s*'+FieldAPIs.toLowerCase()+'.*from\\s*'+sobj.toLowerCase()+'\\).*'+
                            +'|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s'+'\\s*from\\s*'+sobj.toLowerCase()+'\\).*'+
                            '|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s*,'+ +'.*from\\s*'+sobj.toLowerCase()+'\\].*'+
                            '|.*select'+'\\s*'+FieldAPIs.toLowerCase()+ +'.*from\\s*'+sobj.toLowerCase()+'\\].*'+
                            '|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s'+'\\s*from\\s*'+sobj.toLowerCase()+'\\].*'+
                            '|.*select.*'+',\\s*'+ FieldAPIs.toLowerCase() +'\\s*,'+ '.*from\\s*'+sobj.toLowerCase()+';.*'+
                            '|.*select'+'\\s*'+ FieldAPIs.toLowerCase() + '.*from\\s*'+sobj.toLowerCase()+';.*'+
                            '|.*select.*'+',\\s*'+ FieldAPIs.toLowerCase() +'\\s'+'\\s*from\\s*'+sobj.toLowerCase()+';.*';
                        
                        List<String> relationshipList = new List<String>();
                        for(String r:relatonList){
                            String patterns1 = '.*select.*'+',\\s*'+FieldAPIs.toLowerCase() +'\\s*,' +'.*from\\s*'+r.toLowerCase()+'.*'+
                                '|.*select'+'\\s'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+'\\s.*'+
                                '|.*select.*'+',\\s*'+FieldAPIs.toLowerCase()+'\\s'+'\\s*from\\s*'+r.toLowerCase()+'\\s.*';
                            
                            relationshipList.add(patterns1);
                        }
                        
                        
                        String found ;
                        
                        found =fetchSoqLQuery(ap.body.toLowerCase(),patterns,relatonList,FieldAPI,sobj,objNfieldCombo);
                        
                        if(found=='true'){
                            
                            ValidationWrapper obj =new ValidationWrapper(ap.name,ap.id,'Apex Class');                              
                            ComponentWrapper.add(obj);                              
                        }                   
                    }
                }
            }

        }
        ClassIDList.clear();
        if(TriggerIDList!=null && TriggerIDList.size()>0){
            //For Object & Field Security Check
            if(
                ApexTrigger.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.ApexTrigger.fields.Id.isAccessible() &&
                Schema.SObjectType.ApexTrigger.fields.body.isAccessible() &&
                Schema.SObjectType.ApexTrigger.fields.name.isAccessible()
            ){
                
                for(ApexTrigger at:[select id,name,body from ApexTrigger where id in:TriggerIDList]){
                    
                    if(at.body!=null   ){
                        
                        String FieldAPIs;
                        
                        if(FieldAPI.lastIndexOf('__c')!=-1 && FieldAPI.lastIndexOf('__c') == FieldAPI.length()-3){
                            
                            if(FieldAPI.countMatches('__')==2)
                                FieldAPIs = FieldAPI.substringafter('__');        //done to remove prefix 
                            else    
                                FieldAPIs = FieldAPI;
                        }else
                            FieldAPIs = FieldAPI;
                        
                        String patterns = '.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+sobj.toLowerCase()+'\\s.*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+sobj.toLowerCase()+'\\).*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+sobj.toLowerCase()+'\\].*'+'|.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+sobj.toLowerCase()+';.*';
                        
                        List<String> relationshipList = new List<String>();
                        for(String r:relatonList){
                            String patterns1 = '.*select.*'+FieldAPIs.toLowerCase() +'.*from\\s*'+r.toLowerCase()+'.*';
                            relationshipList.add(patterns1);
                        }                     
                        
                        String found ;
                        found =fetchSoqLQuery(at.body.toLowerCase(),patterns,relatonList,FieldAPI,sobj,objNfieldCombo);
                        
                        if(found=='true'){
                            
                            ValidationWrapper obj =new ValidationWrapper(at.name,at.id,'Apex Trigger');                                               
                            ComponentWrapper.add(obj);
                            
                        }//if close
                    }//if close
                }//for close
            }//if close
        }//if close
        TriggerIDList.clear();
       
        return ComponentWrapper;                
    } 
    
      public class ValidationWrapper{
    
        Public String VName;              
        Public String compid; 
        Public String type;
        public ValidationWrapper() {}      
        
        public ValidationWrapper(String VNames,String compids,String types){
        
          VName = VNames;    
          compid =  compids;
          type = types;   
        } 
    }
    
     // function is used to find particula field in formula.here main is the selected object ,obj is the child object,field is selected field , formula is formula field
    //lookup field list is the field name in child obbject that are refering selected object.
    
    Public boolean checkFormula(string main,String Obj,string Fieldd,string Formula,List<String> LookupfieldList){
        //system.debug('main---'+main+'Obj---'+Obj+'Fieldd---'+Fieldd+'Formula---'+Formula+'LookupfieldList-----'+LookupfieldList);
        boolean flag= false;
        if(!String.isEmpty(Formula)){
             if(main==obj){                
                if(Formula.contains(Fieldd)){                                       
                    String EForm =  Formula.replace('.'+Fieldd,'');     //if .is used it means this is the field of another object not itself.
                    if(EForm!='') EForm = EForm.toLowerCase();
                   
                   
                    if(EForm.contains(Fieldd.toLowerCase()) ){ 
                         Pattern MyPattern = Pattern.compile(Fieldd.toLowerCase()+'[^a-z_]');
                         Matcher MyMatcher = MyPattern.matcher(EForm.toLowerCase()); 
                        
                        Pattern MyPattern1 = Pattern.compile('[^a-z_]'+Fieldd.toLowerCase());
                        Matcher MyMatcher1 = MyPattern1.matcher(EForm.toLowerCase());  
                        
                        Pattern MyPattern2 = Pattern.compile('[^a-z_]'+Fieldd.toLowerCase()+'[^a-z_]');
                        Matcher MyMatcher2 = MyPattern2.matcher(EForm.toLowerCase());    
                        if( (MyMatcher2.find()) || (EForm.substringafter(Fieldd.toLowerCase()) == '' && EForm.substringbefore(Fieldd.toLowerCase()) == '')  ||(EForm.substringafter(Fieldd.toLowerCase()) == '' && MyMatcher1.find()  ) ||(EForm.substringbefore(Fieldd.toLowerCase()) == '' && MyMatcher.find())  ) {
                        
                            flag = true;
                        }
                                           
                    }
                                                
                 }                 
             }
            else{
                if(LookupfieldList!= null && LookupfieldList.size()>0){
                    for(String lp:LookupfieldList){
                       
                        Formula = Formula.toLowerCase();
                        if(Formula.contains(lp.toLowerCase()+'.'+Fieldd.toLowerCase())){
                             
                             flag = true;                          
                        }                         
                    }
                }
            }  
        } 
        
        return flag;
    }
    public void finish (Database.BatchableContext BC) {}
 
}