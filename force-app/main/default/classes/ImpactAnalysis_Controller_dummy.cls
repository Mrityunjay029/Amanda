global with sharing class ImpactAnalysis_Controller_dummy{
    
    /*Public List<sobjectWrapper> sobjectWrapperList{get;set;}
    public String jsonObjects{get;set;}
    Public List<FieldWrapper> FieldWrapperList{get;set;}
    public set<string>typeset{get;set;}
    public list<pdfWrapper> pdfwrapperList{get;set;}   
    Public String JSONField{get;set;}
    public string choices{get;set;}
    public String SelectedObject{get;set;}  
    Public String Jsoncontent{get;set;}
    Public Map<String,list<pdfWrapper>> componentsmap{get;set;}
    public list<string> typenew{get;set;}
    public string SelectedField{get;set;}
    public String Jsonbody{get;set;}
    public boolean showfieldsection{get;set;}
    public boolean showobjsection{get;set;} 
    Public String ImpactedComponents{get;set;}    
    Public String OrgURL{get;set;}
    public String baseurl{get;set;}   
    public boolean mainscreen{get;set;}   
    Public boolean header{get;set;}
    Public boolean loader{get;set;}
    Public String Layoutobjectid{get;set;}
    Public String FieldLabel{get;set;}
    public boolean isOnLoad{get;set;}
    public string pagemessage{get;set;}
    public boolean isTrial{get;set;}
    Public boolean classtrigger{get;set;}
    Public boolean workflow{get;set;}
    Public boolean fieldupdate{get;set;}
    Public boolean validation{get;set;}
    Public boolean form{get;set;}
    Public boolean playout{get;set;}
    Public boolean email{get;set;}
    Public boolean approv{get;set;}
    Public boolean pages{get;set;}
    Public boolean flowsAndProcess{get;set;}
   
    public ImpactAnalysis_Controller_dummy(){
        loader = false;
        mainscreen=true;           
        baseurl = System.URL.getSalesforceBaseURL().toExternalForm();      
        OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';  //fetch Salesforce instance URl   
        isOnLoad = true;
        pagemessage = '';
        isTrial = false;
        for(Amanda_License__c lic: Amanda_License__c.getAll().values()){
            if(lic.Name == userInfo.getOrganizationName() && lic.Status__c == 'Free') {
                isTrial = true;
            }
        }             
    }
    
    //function is invoked when Field analyse link is clicked on.
    public void Returnpage(){
        mainscreen=false;
        
        if(choices=='FieldsValues'){
        
            sobjectWrapperList = new List<sobjectWrapper>();
            String baseurl = System.URL.getSalesforceBaseURL().toExternalForm();
            OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';  // fetch salesforce instance url
                
            AllObjectList = new Set<string>();
                     
            List<Schema.SobjectType> SobjectList= Schema.getGlobalDescribe().values();   // fetch the list of all sobject in salesforce org
            for(Schema.SobjectType s:SobjectList){ 
               
                AllObjectList.add(s.getDescribe().getName());
                sobjectWrapperList.add(new sobjectWrapper(s.getDescribe().getLabel(),s.getDescribe().getName()));                
            }  
            sobjectWrapperList.sort();
            jsonObjects = JSON.serialize(AllObjectList);                        
            showfieldsection =false;
            showobjsection = true;            
        }    
    } 
   
    
    Set<String> AllObjectList;
    public void rerenderpage(){ //function invoked on selecting an object  
           
    
        if(AllObjectList.contains(SelectedObject) ){ //if selected object is not null then fetch all the fields of selected object
              
            List<String> AllFieldsList =new List<String>();  //initialise  a list to store all field of selected object to be shown on autocomplete
            FieldWrapperList = new List<FieldWrapper>();   //create a wrapper that will store information regarding field name,api name or field type
            
            
            Map<String,Schema.SObjectField> schemaFieldMap = Schema.getGlobalDescribe().get(SelectedObject).getDescribe().fields.getMap();
            List<Schema.SObjectField> FieldList =  schemaFieldMap.values();
            
            for(Schema.SObjectField field:schemaFieldMap.values()){
                
                AllFieldsList.add(field.getDescribe().getName());               
                FieldWrapperList.add(new FieldWrapper(field.getDescribe().getLabel(),field.getDescribe().getName(),String.valueof(field.getDescribe().getType())));
            }
            FieldWrapperList.sort();
            showfieldsection = true;
            showobjsection = false; 
             
            header = false;                   
            JSONField   = JSON.serialize(FieldWrapperList);
           
        }else{
            header = true;           
            showfieldsection = false;
            showobjsection = true;
        }     
    }
    
    
    Public String CreateJsonData(String Jsoncontent,Map<String,ImpactAnalysis_Controller_dummy.ValidationWrapper> GeneralWrapper){
        transient String general = '';
        integer c=1;
        
        for(String validID:GeneralWrapper.keyset()){
            if(Jsoncontent==''){                   
                    if(c==1){
                        if(GeneralWrapper.keyset().size()==c){
                            String s = '[{"attributes":{"type":"'+GeneralWrapper.get(validID).type +'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}]';                     

                            general=Jsoncontent+ s;
                        }
                        else{
                            String s = '[{"attributes":{"type":"'+GeneralWrapper.get(validID).type +'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}';                                
                            general=Jsoncontent+s;
                            c  = c +1;
                        }
                    } 
                       
                else{
                    if(GeneralWrapper.keyset().size()==c){
                        String s = ',{"attributes":{"type":"'+GeneralWrapper.get(validID).type +'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}]';                     

                        general=general+s;
                    }
                    else{
                                                                                               
                        String s=',{"attributes":{"type":"'+GeneralWrapper.get(validID).type +'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}';
                        system.debug(s.length());
                        general=general+s;                     

                        c =c +1;
                    }                           
                }     
                      
            }                 
            else{
                if(general==''){
                    if(GeneralWrapper.keyset().size()!=c) {
                         general=Jsoncontent+',{"attributes":{"type":"'+GeneralWrapper.get(validID).type+'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}';
                         c=c+1;
                    }
                    else{
                        general=Jsoncontent +',{"attributes":{"type":"'+GeneralWrapper.get(validID).type+'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}]';
                    }
                }
                else{
                    if(GeneralWrapper.keyset().size()!=c) {    
                        String s = ',{"attributes":{"type":"'+GeneralWrapper.get(validID).type+'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}';
                        general=general+s;
                        c = c+1;      
                    }
                    else{
                        String s = ',{"attributes":{"type":"'+GeneralWrapper.get(validID).type+'"},"Id":"'+validID+'","Name":"'+GeneralWrapper.get(validID).VName+'"}]';
                            
                        general=general+s;                        
                    }                         
                }//else close
            }
       }
        GeneralWrapper.clear();  
        return general;   
    }
    //function invoke on clicking save analyis when pdf is opened
    public pagereference callpageredirect(){
        
        componentsmap = new map<String,list<pdfWrapper>>();
        typeset = new set<string>();
        typenew = new list<string>();
        pdfwrapperList = new list<pdfWrapper>();
        
        typenew = Jsoncontent.split('"type":');
        if(typenew != null && typenew.size()>0){
            for(string st :typenew){
                if(st!= typenew[0]){
                
                    string type = st.substringBetween('"');
                                                                              
                    list<string> name = st.split('"Name":');
                    string name1 = name[1].substringBetween('"');
                    
                    list<string> idvalue = st.split('"Id":');
                    string  id1 = idvalue[1].substringBetween('"');
                    
                    Id myId = Id.valueOf(id1);

                   
                    
                    if(componentsmap.containskey(type)){
                            
                        list<pdfwrapper> pdf2 = componentsmap.get(type);
                        pdfwrapper pdf = new pdfwrapper(name1,myId);
                        pdf2.add(pdf);                                                                  
                    }
                    else{
                        pdfwrapperlist = new list<pdfwrapper>();
                        pdfwrapper pdf = new pdfwrapper(name1,myId);
                        pdfwrapperlist.add(pdf);
                        componentsmap.put(type ,pdfwrapperlist);                        
                    }                                    
                }                
            }
        }
        //typenew.clear();    
        typeset.AddAll(componentsmap.KeySet()); 
        //componentsmap.clear();
        PageReference PagePDF = new PageReference('/apex/saveAnalysisPDF');
        PagePDF.setRedirect(false);
        return PagePDF;        
    }
    Set<string> allobjLookupFieldList ;
    String prefix ;
    Boolean flag; //tells object is custom or standard
    //function invoked on clicking field name or selcting field from autocomplete. this method is basically used in batch calling.
    Public void callApexcomponents(){
    
        List<Amanda__c> ss = [select id,ComponentType__c  from Amanda__c where id != null];
        List<Amanda__c> amandaList = new List<Amanda__c>();
        
        for(Amanda__c a:ss){
            amandaList.add(a);
        }
        delete amandaList;  // Delete all custom setting records. because meanwhile some components may be del
        
        loader = true;   // when field is clicked on loader is run.
        
        System.debug('SelectedObject!!!'+SelectedObject+'SelectedField!!!'+SelectedField);
        
        
        if(classtrigger == true){
        
            GetApexComponents   lhr1=new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'apexclassntrigger');
            apexid = Database.executeBatch(lhr1);
        }

      
        if(flowsAndProcess == true){
            GetFlowsAndProcesses batchIns1=new GetFlowsAndProcesses(UserInfo.getSessionId(),'Flow',SelectedObject,SelectedField);
            flowBatchId = Database.executeBatch(batchIns1, 100);
        }
        system.debug('flowsAndProcess: '+flowsAndProcess+'  approv = '+approv);
        if(approv == true){
            GetFlowsAndProcesses batchIns2=new GetFlowsAndProcesses(UserInfo.getSessionId(),'Approval Process',SelectedObject,SelectedField);
            apBatchId = Database.executeBatch(batchIns2, 100);
        }
     
       
        String FieldAPI = SelectedField;
         if(FieldAPI.countMatches('__')==2){
            prefix = FieldAPI.substringbefore('__');  //prefix of the org
            FieldAPI = FieldAPI.substringafter('__');               
        }                                     
        // finding child objects of selected object
        Map <String,Schema.SobjectType> schemaMap=Schema.getGlobalDescribe();              
        sObject s1 = schemaMap.get(SelectedObject).newSObject() ;
        Schema.DescribeSObjectResult Result = s1.getSObjectType().getDescribe();
        flag = Result.isCustom();
        
        List<Schema.ChildRelationship> Ch = Result.getChildRelationships();
        Set<string> childList = new Set<String>(); //Child list will contain all child objects of selected object if selected object is parent.
        
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
        childList.add(SelectedObject); 
        // ChildList containing all the child object and selected object itself.
        
        List<string> formulaFieldList =  new List<string>();             
        Set<String> LookupFieldList = new Set<String>(); //if a field is used in formula field of child object.then llokup field is refrence in formula. 
        allobjLookupFieldList = new Set<String>();
        
        String formf;   //field is used for formula fields only
        if(prefix == null || prefix == '' )formf = FieldAPI;
        else if(prefix != null && prefix!= '' && !FieldAPI.contains(prefix+'__'))   
            formf = prefix + '__'+FieldAPI;                             // since formula fields contaiins the prefix of org.
        
        for(string child:childList){    //iterate through all child object of selected object
            LookupFieldList = new Set<String>();
                                     
            Map<String, Schema.SObjectField> schemaFieldMap1 = schemaMap.get(child).getDescribe().fields.getMap();  //find field description of all child object
            String child1 = child;
            
            if(child1.countMatches('__')==2)
                child1 = child1.substringafter('__');
            
            
            for (Schema.SObjectField fn: schemaFieldMap1.values()){ 
                
                List<Schema.sObjectType> listt = fn.getDescribe().getReferenceTo();     //those fields in child object that refrence to selected object
                if(listt.size()>0){ 
                   
                    if(String.valueof(listt[0])==SelectedObject){
                        string FIELDNAME = fn.getDescribe().getName();   //
                        if(fn.getDescribe().isCustom())
                             FIELDNAME = FIELDNAME.substring(0,FIELDNAME.lastindexof('__c'))+'__r';   
                         else
                             FIELDNAME  = FIELDNAME.substringbefore('Id');
                        allobjLookupFieldList.add(FIELDNAME);    
                        LookupFieldList.add(FIELDNAME );                               //this is the list of all lookup fields in child object(where selected object has lookup)
                        
                     }
                }
            } 
           
            for (Schema.SObjectField fn: schemaFieldMap1.values()){ 
                                 
                if(fn.getDescribe().isCalculated()){ //if field is formula field
                    String Formula = fn.getDescribe().getCalculatedFormula();    
                      
                    
                    boolean flag = checkFormula(SelectedObject,child,formf,Formula,LookupFieldList );
                    if(flag){
                        String ff=fn.getDescribe().getName(); 
                        system.debug('ff---'+ff);                      
                        formulaFieldList.add(child1+'.'+ff); //we store child1 as the (object of formula field) and ff is formula field
                    }
                }                 
            }         
        }
        system.debug('formulaFieldList!!!!!'+formulaFieldList.size());
        if(form == true){
            if(!formulaFieldList.isEmpty()){
            
                GetApexComponents   lhr=new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,formulaFieldList,'formula');
                i = Database.executeBatch(lhr,100);
                System.debug('id##########'+i);
            } 
        }
        
        
        Layoutobjectid = SelectedObject; //This is used in Page Layout URL .If the object is custom ,url contains id of object else if it is standard nameof obj.
        
       
            if(workflow == true){
                GetApexComponents   w =new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'workflow');
                work = Database.executeBatch(w,100);
            }
            if(validation == true){
                GetApexComponents   validationcall = new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'validation');
                valid = Database.executeBatch(validationcall ,100);
            }
             
       
        
       
            if(playout == true){
                GetApexComponents   pg =new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'Page Layout');
                layout = Database.executeBatch(pg,100);
            }
        
             
    }
    
    ID i,work,layout,valid,apexid,flowBatchId,apBatchId;
    Public void displaychart(){
    
        Jsonbody = '';    // to empth the json body, if another object is selected.
        
        Set<Id> IDList = new Set<ID>();
        String sobj  =  SelectedObject;
        String FieldAPI = SelectedField;
        if(i !=null)   //i is formula field id.
            IDList.add(i);        
        if(apexid != null)
             IDList.add(apexid);
             
        if(work != null)
            IDList.add(work );
        if(layout != null)
            IDList.add(layout);
        if(valid != null)
            IDList.add(valid);
        if(flowBatchId != null)
            IDList.add(flowBatchId);
        if(apBatchId != null)
            IDList.add(apBatchId);
            
           
        List<AsyncApexJob> aajList = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
        FROM AsyncApexJob WHERE ID IN :IDList];   // query on job to know when all batch will be executed .        
        
        String status = 'false';
        if(aajList != null && !aajList.isEmpty()){
            for(AsyncApexJob aj:aajList ){
                
                if(aj.Status == 'completed')
                    status = 'true'  ;  
                else{
                    status = 'false'; 
                    break;
                }   
            }
        }
        Map<String,ValidationWrapper> generalwrapper = new Map<String,ValidationWrapper>();  // general wrapper to put data of all apex components
        
        if(aajList == null || aajList.isEmpty()){
        
            // finding ApexPages  
            if(pages == true){
                for(ApexPage ap:[select id,Markup,name from ApexPage limit  50000]){
                
                    String lowermarkup = string.valueof(ap.Markup ).toLowerCase();           
                    String objf = sobj+'.'+FieldAPI;                
                    if(lowermarkup.contains(objf.toLowerCase())){
                    
                        ValidationWrapper obj =new ValidationWrapper(ap.name,ap.id,'Apex Page');            
                        generalwrapper.put(ap.id,obj); 
                    }
                }  
            }
            // finding ApexPages ends
            
            // finding email template
            if(email == true){
                List<EmailTemplate > TemplateList  = getreferenceEmailTemplate(sobj,FieldAPI);
                for(EmailTemplate et:TemplateList){
                    ValidationWrapper obj =new ValidationWrapper(et.name,et.id,'Email Template');            
                    generalwrapper.put(et.id,obj);
                
                }
            }
            // finding email template ends
            
            //finding workflowfieldupdate
            if(fieldupdate == true){
                System.debug('fieldupdate@@@@@@@@@');
                Map<String,ValidationWrapper> fieldupdateMap = findWorkflowfieldupdate(sobj,FieldAPI,allobjLookupFieldList,flag);
                 System.debug('fieldupdateMap @@@@@@@@@'+fieldupdateMap );
                if(fieldupdateMap  != null && !fieldupdateMap.isEmpty()){
                    for(String s:fieldupdateMap.keyset()){
                        generalwrapper.put(s,fieldupdateMap.get(s));
                    
                    }
                }
            }
            
            //finding workflowfieldupdate ends
            
            
            String  genral;
            Jsonbody  = '';
            if(generalwrapper.size()>0){
                if(Jsonbody != null && !String.isEmpty(Jsonbody)) { 
                    String SplittedJSON= Jsonbody.substring(0,Jsonbody.lastIndexof(']'));
                    genral = CreateJsonData(SplittedJSON,generalwrapper);
                }            
            
                else{
                            genral = CreateJsonData(Jsonbody,generalwrapper);
                }
                Jsonbody = genral;
            }   
             loader = false; 
            System.debug('Jsonbody @@@@@@'+Jsonbody );
        }
         
        if(status  == 'true'){    // if status is true , it means all batch status is completed
            loader = false;         //loader is stopped
            
            Set<String> classIDList = new Set<String>();
            Set<String> triggerIDList = new Set<String>();
            List<String> FormulaList =new List<String>();
            List<String> workflowist =new List<String>();
            List<String> LayoutList =new List<String>();
            List<String> validationList =new List<String>();
            List<String>flowList =new List<String>();
            List<String>apList =new List<String>();

            List<Amanda__c> AmandaList = Amanda__c.getall().values();
            System.debug('AmandaList ###############'+AmandaList );
            
            if(AmandaList != null && !AmandaList.isEmpty()){
                for(Amanda__c a:AmandaList){
                    
                    if(a.ComponentType__c.contains('Apex Class')){                      
                        classIDList.addAll(a.ComponentIDs__c.split(','));
                        
                    }else if (a.ComponentType__c.contains('Apex Trigger')){
                        triggerIDList.addAll(a.ComponentIDs__c.split(','));
                        
                    }else if (a.ComponentType__c.contains('Formula Field')){
                        FormulaList.addAll(a.ComponentIDs__c.split(','));
                        
                    }else if (a.ComponentType__c.contains('WorkFlow Rule')){
                        workflowist.addAll(a.ComponentIDs__c.split(','));
                        
                    }else if(a.ComponentType__c.contains('Page Layout')){
                        LayoutList.addAll(a.ComponentIDs__c.split(','));
                        
                    }else if(a.ComponentType__c.contains('Validation Rule')){
                         validationList.addAll(a.ComponentIDs__c.split(','));
                    }else if(a.ComponentType__c.contains('Approval Process')){
                         apList.addAll(a.ComponentIDs__c.split(','));
                    }else if(a.ComponentType__c.contains('Flow')){
                         flowList.addAll(a.ComponentIDs__c.split(','));
                    }
                }
            }
            
            system.debug('classIDList@@@'+classIDList+'triggerIDList@@@'+triggerIDList);
            if(classtrigger == true){
                for(Apexclass apx:[select id,name from Apexclass where id IN:classIDList]){
                    ValidationWrapper obj =new ValidationWrapper(apx.name,apx.id,'Apex Class');            
                    generalwrapper.put(apx.id,obj);
                }
                    
                for(ApexTrigger apt:[select id,name from ApexTrigger where id IN:triggerIDList]){
                    ValidationWrapper obj =new ValidationWrapper(apt.name,apt.id,'Apex Trigger');            
                    generalwrapper.put(apt.id,obj);
                }
            }
            if(form == true){   
                For(String f:FormulaList){
                    ValidationWrapper obj =new ValidationWrapper(f.substringafter(';'),f.substringbefore(';'),'Formula Field');            
                    generalwrapper.put(f.substringbefore(';'),obj);                    
                }
            }
            if(workflow == true ){   
                For(String f:workflowist){
                    ValidationWrapper obj =new ValidationWrapper(f.substringafter(';'),f.substringbefore(';'),'WorkFlow Rule');            
                    generalwrapper.put(f.substringbefore(';'),obj);                    
                }
            }
            if(approv == true){
                for(ProcessDefinition pd: [SELECT Id,name FROM ProcessDefinition where id =: aplist ]){
                    ValidationWrapper obj =new ValidationWrapper(pd.name,pd.id,'Approval Process');            
                    generalwrapper.put(pd.id,obj);
                }
            }
            if(validation == true){
                For(String v:validationList){
                    ValidationWrapper obj =new ValidationWrapper(v.substringafter(';'),v.substringbefore(';'),'Validation Rule');            
                    generalwrapper.put(v.substringbefore(';'),obj);                    
                }
            }
            if(playout == true){
                For(String l: LayoutList){
                    ValidationWrapper obj =new ValidationWrapper(l.substringafter(';'),l.substringbefore(';'),'Page Layout');            
                    generalwrapper.put(l.substringbefore(';'),obj);             
                }
            }
            if(flowsAndProcess == true){
                For(String l: flowList){
                    ValidationWrapper obj =new ValidationWrapper(l.substringafter(';'),l.substringbefore(';'),'Flows & Processes');            
                    generalwrapper.put(l.substringbefore(';'),obj);             
                }
            }
            
            // finding id of selected object used in Page layout URL where Objectid used if object custom else object name used if object is standard.
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('GET');           
            Http http = new Http();            
            String layID = sobj;

            if(sobj.countMatches('__')==2)    
                sobj = sobj.substringafter('__');  
                    
            Map <String,Schema.SobjectType> schemaMap=Schema.getGlobalDescribe();            
            sObject s1 = schemaMap.get(layID).newSObject() ;
            Schema.DescribeSObjectResult Result = s1.getSObjectType().getDescribe();
            
            if(Result.iscustom()){
                req.setEndpoint(OrgURL+'/services/data/v34.0/tooling/query/?q=select+id,developername+from+customobject+where+developername=\''+sobj.substringbeforelast('__c')+'\'');
                HTTPResponse objres = http.send(req);                   
                List<String> layIDList = objres.getBody().split('"Id":');
                String SobjID = layIDList[1].substringbetween('"');
                layIDList.clear();
                layID = SobjID;
            }
            Layoutobjectid = layID ;
            // Finding object id ends
            
            
            // finding ApexPages   
            if(pages == true){
                for(ApexPage ap:[select id,Markup,name from ApexPage limit 50000]){
                
                    String lowermarkup = string.valueof(ap.Markup ).toLowerCase();           
                    String objf = sobj+'.'+FieldAPI;                
                    if(lowermarkup.contains(objf.toLowerCase())){
                    
                        ValidationWrapper obj =new ValidationWrapper(ap.name,ap.id,'Apex Page');            
                        generalwrapper.put(ap.id,obj); 
                    }
                }   
            }
            // finding ApexPages ends
            
            // finding email template 
            if(email == true){
                List<EmailTemplate > TemplateList  = getreferenceEmailTemplate(sobj,FieldAPI);
                for(EmailTemplate et:TemplateList){
                    ValidationWrapper obj =new ValidationWrapper(et.name,et.id,'Email Template');            
                        generalwrapper.put(et.id,obj);
                
                }
            }
            // finding email template ends
            //finding workflowfieldupdate
            if(fieldupdate == true){
                Map<String,ValidationWrapper> fieldupdateMap = findWorkflowfieldupdate(sobj,FieldAPI,allobjLookupFieldList,flag);
                if(fieldupdateMap  != null && !fieldupdateMap.isEmpty()){
                    for(String s:fieldupdateMap.keyset()){
                        generalwrapper.put(s,fieldupdateMap.get(s));
                    
                    }
                }
            }
            
            //finding workflowfieldupdate ends
            
            
            // Creating JSOn data from wrapper
            String  genral;
            Jsonbody  = '';
            if(generalwrapper.size()>0){
                if(Jsonbody != null && !String.isEmpty(Jsonbody)) { 
                    String SplittedJSON= Jsonbody.substring(0,Jsonbody.lastIndexof(']'));
                    genral = CreateJsonData(SplittedJSON,generalwrapper);
                }            
            
                else{
                            genral = CreateJsonData(Jsonbody,generalwrapper);
                }
                Jsonbody = genral;
            }               
            system.debug('Jsonbody@@@@@@@@@@@'+Jsonbody);     
        }
          
    }
    
    
    // function is used to find particula field in formula.here main is the selected object ,obj is the child object,field is selected field , formula is formula field
    //lookup field list is the field name in child obbject that are refering selected object.
    
    Public boolean checkFormula(string main,String Obj,string Fieldd,string Formula,Set<String> LookupfieldList){
        system.debug('main---'+main+'Obj---'+Obj+'Fieldd---'+Fieldd+'Formula---'+Formula+'LookupfieldList-----'+LookupfieldList);
        boolean flag= false;
        if(!String.isEmpty(Formula)){
             if(main==obj){                
                if(Formula.contains(Fieldd)){                                       
                    String EForm =  Formula.replace('.'+Fieldd,'');     //if .is used it means this is the field of another object not itself.
                    if(EForm!='') EForm = EForm.toLowerCase();
                   
                    if(EForm.contains(Fieldd.toLowerCase()) && !EForm.contains('_'+Fieldd.toLowerCase()) && !EForm.contains(Fieldd.toLowerCase()+'_')){ 
                        flag =  true;                       
                    }
                                                
                 }                 
             }
            //else{
                if(LookupfieldList!= null && LookupfieldList.size()>0){
                    for(String lp:LookupfieldList){
                       
                        Formula = Formula.toLowerCase();
                        if(Formula.contains(lp.toLowerCase()+'.'+Fieldd.toLowerCase())){
                             
                             flag = true;                          
                        }                         
                    }
                }
            //}  
        } 
        
        return flag;
    }
    //it finds field used in  workflowfieldupdates
    Public Map<String,ValidationWrapper> findWorkflowfieldupdate(String sobjectname,String sfield,Set<String> lookupfieldList,boolean custom){
        System.debug('findworkflowfield!!!!!!!!'+lookupfieldList);  
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');           
        Http http = new Http();      
        req.setEndpoint(OrgURL+'/services/data/v34.0/tooling/query/?q=select+id,FullName,metadata+from+WorkflowFieldUpdate');
        HTTPResponse objres = http.send(req);   
        List<String> fupdate = objres.getBody().split('"Id":');
        Map<String,ValidationWrapper> generalwrapper = new Map<String,ValidationWrapper>();
         integer i=0;
        if(custom == true && prefix != null && prefix != '')
            sobjectname  = prefix +'__'+sobjectname  ;
        for(String s:fupdate){
            if(s != fupdate[0]){  
                i= i+1;        
                String ID =  s.substringBetween('"');
                List<String> URLLsit = fupdate[i-1].split('"url":');
                String URL = URLLsit[1].substringbetween('"');
                
                List<String> nameList = fupdate[i].split('"FullName":');
                String name = nameList[1].substringbetween('"').substringafter('.');
                String objname = nameList[1].substringbetween('"').substringbefore('.');
               
                
                List<String> fieldList = fupdate[i].split('"field":');
                String field = fieldList[1].substringbetween('"');
                
                
                List<String> formulaLsit = fupdate[i].split('"formula":');
                String formula = formulaLsit[1].substringBefore('"literalValue":');
                boolean flag = false;
                System.debug('field###########'+field+'sfield##'+sfield+'objname@@'+objname+'sobjectname@@'+sobjectname);
                              
                if(field == sfield && objname == sobjectname ){
                    flag = true;
                }
                else{
                    
                    flag = checkFormula(sobjectname,objname,sfield,formula,lookupfieldList);
                    
                }
                
                if(flag == true){
                
                    ValidationWrapper obj =new ValidationWrapper(name,ID,'Workflow Field Update');            
                    generalwrapper.put(ID,obj); 
                }
        }
        }
        return generalwrapper;
    
    }
    
    
    // it finds email template on field click....
    Public List < EmailTemplate > getreferenceEmailTemplate(String ObjectName,String fieldName){
    
        List < EmailTemplate > templist = new List < EmailTemplate > ();
        
        if(ObjectName != null && fieldName != null ) {
            for(EmailTemplate ee:[select id,Name,Body from  EmailTemplate limit  50000]){
                if(ee.Body != null ){
                    Pattern MyPattern = Pattern.compile('\\{!.*'+ObjectName.toLowerCase()+'\\.'+fieldName.toLowerCase()+'.*}');
                    system.debug(''+MyPattern+'fieldName-----'+fieldName+'ObjectName---'+ObjectName);
                    Matcher MyMatcher = MyPattern.matcher(ee.Body.toLowerCase());
                    if(MyMatcher.find()) {
                        templist.add(ee);
                    }
                }
            }
        }             
        return templist;
    }
    public void createLicenseRecord() {
        String orgName = UserInfo.getOrganizationName();
        boolean isAllreadyExist = false;
        for(Amanda_License__c  lic: Amanda_License__c.getAll().values()){
            if(orgName == lic.Name) isAllreadyExist = true;
        }  
        if(!isAllreadyExist){
            Amanda_License__c lic = new Amanda_License__c(name=orgName,Status__c = 'Free');   
            try{
                if(Schema.sObjectType.Amanda_License__c.isCreateable())
                    insert lic; 
            }catch(Exception ex){
                pagemessage = ex.getMessage();
            }
        }
        isOnLoad= false;
        
    }
    
    // validate license key
    public string LicenseKey{get;set;}
    public void validateLicenseKey(){
        pagemessage = '';
        String orgId = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        //sfLma__Subscriber_Org_ID__c.subString(0,15).subString(licRec[0].sfLma__Subscriber_Org_ID__c.subString(0,15).length()-5,licRec[0].sfLma__Subscriber_Org_ID__c.subString(0,15).length())+''+licRec[0].sfLma__Subscriber_Org_ID__c.subString(0,5)+''+soundex.tosoundex(licRec[0].sfLma__Lead__r.Company)+''+'0';     
        if(LicenseKey != orgId){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Sorry, key is invalid.'));displayPopupDisp1 = true;  
            pagemessage = 'Sorry, key is invalid.';
        }else{
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Key validated.'));displayPopupDisp1 = false;
            //pagemessage = 'Key validated.';
            Amanda_License__c AmandaLic = null;
            for(Amanda_License__c lic: Amanda_License__c.getAll().values()){
                if(lic.Name == UserInfo.getOrganizationName()) {
                    AmandaLic = lic;AmandaLic.Status__c = 'Paid';AmandaLic.Key__c= LicenseKey; 
                }
            } 
            if(AmandaLic != null && (Schema.sObjectType.Amanda_License__c.isCreateable() || Schema.sObjectType.Amanda_License__c.isUpdateable())) 
                upsert AmandaLic;
            isTrial = false; 
        }
           
    }
   
    
   
    public class ValidationWrapper{
    
        Public String VName;
        Public String compid;
        Public String type; 
        public ValidationWrapper() {}      
        
        public ValidationWrapper(String VNames,string compids,string types){
        
          VName = VNames;
          compid = compids;
          type = types;
        } 
    }
    // Used to sort Object List
    Public class sobjectWrapper implements Comparable{
        public String label{get;set;}
        public String APIname{get;set;}
        
        public sobjectWrapper(String labels,String APInames){
            label = labels;
            APIname = APInames;          
        }
         Public Integer compareTo(Object ObjToCompare){      
            return label.CompareTo(((sobjectWrapper)ObjToCompare).label);
        } 
    }
    public void tempmethod(){}
    
    // Used to sort Field List
    Public class FieldWrapper implements Comparable{
        public String label{get;set;}
        public String APIname{get;set;}
        Public String type{get;set;}
        
        public FieldWrapper(String labels,String APInames,String types){
            label = labels;
            APIname = APInames; 
            type = types;         
        }
         public  Integer compareTo(Object ObjToCompare) {
            return label.CompareTo(((FieldWrapper)ObjToCompare).label);
        }
    }
    
    // wrapper used in Pdf document
    Public class pdfWrapper{
       
        public string names{get;set;}
        public Id Id2{get;set;}
      
        public pdfWrapper(string names2 ,Id Idname ){
            names = names2; 
            Id2 = Idname;
       
        }
    }*/

}