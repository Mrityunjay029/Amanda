global with sharing class ImpactAnalysis_Controller{
    
    Public Transient List<List<sobjectWrapper>> sobjectWrapperList{get;set;}
    public Transient String jsonObjects{get;set;}
    Public Transient  List<List<FieldWrapper>> FieldWrapperList{get;set;}
    public set<string>typeset{get;set;}
    public List<list<pdfWrapper>> pdfwrapperList{get;set;}   
    Public String JSONField{get;set;}
    public string choices{get;set;}
    public String SelectedObject{get;set;}  
    Public String Jsoncontent{get;set;}
    Public Map<String,List<list<pdfWrapper>>> componentsmap{get;set;}
    public list<string> typenew{get;set;}
    public string SelectedField{get;set;}
    public Transient   String Jsonbody{get;set;}
    public boolean showfieldsection{get;set;}
    public boolean showobjsection{get;set;} 
    Public String ImpactedComponents{get;set;}    
    Public String OrgURL{get;set;}
    public Transient  String baseurl{get;set;}   
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
    Public boolean reports{get;set;}
    Public String Pageurl{get;set;}
    Public String alertmsg{get;set;}
    Public String buttonname{get;set;}
    
    public ImpactAnalysis_Controller(){
        Pageurl = 'https://' +ApexPages.currentPage().getHeaders().get('Host');
        loader = false;
        mainscreen=true;           
        baseurl = System.URL.getSalesforceBaseURL().toExternalForm();      
        OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';  //fetch Salesforce instance URl   
        isOnLoad = true;
        pagemessage = '';
        isTrial = false;
        /*List<Amanda_License__c> LicenseList = [select id from Amanda_License__c];
        if(LicenseList == null && LicenseList.size() == 0){
            Amanda_License__c am = new Amanda_License__c(name = userInfo.getOrganizationName(),Status__c = 'Free');
            insert am;
        }*/
        
        Organization[] org = new Organization[]{};
            if(
                Organization.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.Organization.fields.Id.isAccessible() &&
                Schema.SObjectType.Organization.fields.OrganizationType.isAccessible() &&
                Schema.SObjectType.Organization.fields.isSandbox.isAccessible()
            ) {
                org = [select Id, OrganizationType, isSandbox from Organization limit 1];
            }
        //system.debug('org--'+org);
        if(org[0].OrganizationType == 'Developer Edition' || org[0].IsSandbox == true){
            //if(lic.Name == userInfo.getOrganizationName() && lic.Status__c == 'Free') {
                isTrial = true;     // It should display the dummy data for DE and Sandboxes
            //}
            //Show original data for a client
            String OrgId =  org[0].id;
            //system.debug('orgId--'+org[0].id);
            //if(OrgId.contains('00D1h0000000drd') || OrgId.contains('00D0o000000S4Dx') || OrgId.contains('00D280000019ual')){
            //    isTrial = false;   
            //}
            
            // Show real data for this developer org where Amanda is developed 
            if(OrgId.contains('00D280000019ual') || OrgId.contains('00D10000000KBRB') || OrgId.contains('00D4W000002T9yM')){
                isTrial = false;
            }
        }
       /* for(Amanda_License__c lic: Amanda_License__c.getAll().values()){
            /*if(lic.Name == userInfo.getOrganizationName() && lic.Status__c == 'Free') {
                isTrial = true;
            }
            Organization[] org = new Organization[]{};
            org = [select Id, OrganizationType, isSandbox from Organization limit 1];
            system.debug('org--'+org);
            if(org[0].OrganizationType == 'Developer Edition' || org[0].IsSandbox == true){
                //if(lic.Name == userInfo.getOrganizationName() && lic.Status__c == 'Free') {
                    isTrial = true;
                //}
            }
            /*else{
                string APP_NAMESPACE_PREFIX = 'ChangeGuru';
                PackageLicense packageLicensing = [SELECT AllowedLicenses, UsedLicenses,ExpirationDate, CreatedDate, IsProvisioned, Status FROM PackageLicense WHERE NamespacePrefix = :APP_NAMESPACE_PREFIX LIMIT 1];
                //system.debug('packageLicensing --'+APP_NAMESPACE_PREFIX +'----'+packageLicensing );
                date d = date.today().addDays(-1); 
                if(packageLicensing.status == 'Active' && packageLicensing.ExpirationDate != d){
                    if(lic.Name == userInfo.getOrganizationName() && lic.Status__c == 'Free') {
                        isTrial = true;
                    }    
                }
            }
        }   */          
    }
    
      
      //function is invoked when Field analyse link is clicked on.
    public void Returnpage(){
        HTTPResponse response;
        String baseurl1 = System.URL.getSalesforceBaseURL().toExternalForm();
        String OrgURL = 'https://'+baseurl1.substringBetween('.')+'.salesforce.com';     
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');           
        Http http = new Http();
       
            req.setEndpoint( OrgURL+'/services/data/v34.0/tooling/query/?q=select+FullName+from+layout+where+TableEnumOrId=\'Account\'');
          
            try{response =http.send(req);
            }catch(System.CalloutException ae){
               
                if(ae.getMessage().contains('Unauthorized endpoint, please check Setup->Security->Remote site settings')){
                    alertmsg = 'Please set the instance URL'+'"'+OrgURL+ '"'+'in Remote Site Setting.';                   
                }
            }
         
        if(choices=='FieldsValues' && alertmsg  == null){
            mainscreen=false;
            sobjectWrapperList = new List<List<sobjectWrapper>>();
            String baseurl = System.URL.getSalesforceBaseURL().toExternalForm();
            OrgURL = 'https://'+baseurl.substringBetween('.')+'.salesforce.com';  // fetch salesforce instance url
                
            AllObjectList = new Set<string>();
            List<sobjectWrapper> tempList = new List<sobjectWrapper>();
            
            List<Schema.SobjectType> SobjectList= Schema.getGlobalDescribe().values();   // fetch the list of all sobject in salesforce org
            for(Schema.SobjectType s:SobjectList){ 
               
                AllObjectList.add(s.getDescribe().getName());
                tempList.add(new sobjectWrapper(s.getDescribe().getLabel(),s.getDescribe().getName()));   
                if(tempList.size() == 1000){
                    tempList.sort();
                    sobjectWrapperList.add(tempList);
                    tempList = new List<sobjectWrapper>();                  
                }               
            }  
            //sobjectWrapperList.sort();
            tempList.sort();
            sobjectWrapperList.add(tempList);
            
            jsonObjects = JSON.serialize(AllObjectList); 
            //system.debug(jsonObjects);                       
            showfieldsection =false;
            showobjsection = true;            
        }    
    }  
   
    
    Transient Set<String> AllObjectList;
    public void rerenderpage(){ //function invoked on selecting an object  
           
    
        
              
            List<FieldWrapper> AllFieldsList =new List<FieldWrapper>();  //initialise  a list to store all field of selected object to be shown on autocomplete
            FieldWrapperList = new List<List<FieldWrapper>>();   //create a wrapper that will store information regarding field name,api name or field type
            List<FieldWrapper> tempList = new List<FieldWrapper>();
            
            Map<String,Schema.SObjectField> schemaFieldMap = Schema.getGlobalDescribe().get(SelectedObject).getDescribe().fields.getMap();
            List<Schema.SObjectField> FieldList =  schemaFieldMap.values();
            
            for(Schema.SObjectField field:schemaFieldMap.values()){
                
                AllFieldsList.add(new FieldWrapper(field.getDescribe().getLabel(),field.getDescribe().getName(),String.valueof(field.getDescribe().getType())));            
                tempList.add(new FieldWrapper(field.getDescribe().getLabel(),field.getDescribe().getName(),String.valueof(field.getDescribe().getType())));
                if(tempList.size() == 1000){
                   tempList.sort();
                    FieldWrapperList.add(tempList);
                   tempList = new List<FieldWrapper>();
                }
            }
            tempList.sort();
            FieldWrapperList.add(tempList);
            
            //FieldWrapperList.sort();
            showfieldsection = true;
            showobjsection = false; 
             
            header = false;                   
            JSONField   = JSON.serialize(AllFieldsList);
           
            
    }
    
     //function invoke on clicking save analyis when pdf is opened
    public pagereference callpageredirect(){
        
        componentsmap = new map<String,List<list<pdfWrapper>>>();
        typeset = new set<string>();
        typenew = new list<string>();
        pdfwrapperList = new List<list<pdfWrapper>>();
        
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
                            
                        List<list<pdfwrapper>> pdf2 = componentsmap.get(type);
                        pdfwrapper pdf = new pdfwrapper(name1,myId);
                        
                        boolean flag = false;
                        for(list<pdfwrapper> p:pdf2){
                        
                            if(p.size() < 1000){
                                p.add(pdf);
                                flag = true;
                                break;
                            }
                        }
                        if(flag == false)
                            pdf2.add(new List<pdfwrapper>{pdf});
                            
                        componentsmap.put(type ,pdf2);  
                                                                                         
                    }
                    else{
                        pdfwrapperlist = new List<list<pdfwrapper>>();
                        pdfwrapper pdf = new pdfwrapper(name1,myId);                        
                        pdfwrapperlist.add(new List<pdfwrapper>{pdf});
                        componentsmap.put(type ,pdfwrapperlist);                        
                    }                                    
                }                
            }
        }
        //typenew.clear();    
        typeset.AddAll(componentsmap.KeySet()); 
        //componentsmap.clear();
          PageReference PagePDF;
        if(buttonname == 'save analysis'){
             PagePDF = new PageReference('/apex/saveAnalysisPDF');
            PagePDF.getHeaders().put('content-disposition', 'attachment; filename=AnalysisReport.pdf');
        }else if(buttonname == 'Open Analysis'){
            PagePDF = new PageReference('/apex/saveAnalysis_vf');    
        }
        
        PagePDF.setRedirect(false);
        return PagePDF;          
    }
    Set<string> allobjLookupFieldList ;
    String prefix ;
    Boolean flag; //tells object is custom or standard
    //function invoked on clicking field name or selcting field from autocomplete. this method is basically used in batch calling.
    Public void callApexcomponents(){
        rerenderpage();
        //System.debug('FieldWrapperList!!!'+FieldWrapperList);
        prefix = '';
        List<Amanda__c> ss;
        if(
            Amanda__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Amanda__c.fields.Id.isAccessible() &&
            Schema.SObjectType.Amanda__c.fields.ComponentType__c.isAccessible()
        ) {
            ss = [select id,ComponentType__c  from Amanda__c where id != null];
        }
        List<Amanda__c> amandaList = new List<Amanda__c>();
        
        for(Amanda__c a:ss){
            if ( Amanda__c.SObjectType.getDescribe().isAccessible() && Schema.sObjectType.Amanda__c.isDeletable() ){
                amandaList.add(a);
            }
        }
        if ( Amanda__c.SObjectType.getDescribe().isAccessible() && Amanda__c.sObjectType.getDescribe().isDeletable() ){
            delete amandaList;  // Delete all custom setting records. because meanwhile some components may be del
        }
        loader = true;   // when field is clicked on loader is run.
        
     
        
        /* finding apex class apex trigger */
        if(classtrigger == true){
        
            GetApexComponents   lhr1=new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'apexclassntrigger');
            apexid = Database.executeBatch(lhr1);
        }

        /* finding apex class apex trigger ends */
        
        
         /*----Calling batch for Flows/Process/Approval processes start-----*/
        if(flowsAndProcess == true){
            GetFlowsAndProcesses batchIns1=new GetFlowsAndProcesses(UserInfo.getSessionId(),'Flow',SelectedObject,SelectedField);
            flowBatchId = Database.executeBatch(batchIns1, 100);
        }

        if(approv == true){
            GetFlowsAndProcesses batchIns2=new GetFlowsAndProcesses(UserInfo.getSessionId(),'Approval Process',SelectedObject,SelectedField);
            apBatchId = Database.executeBatch(batchIns2, 100);
        }
        /*----Calling batch for Flows/Process/Approval processes end------*/
        
        /*----Calling batch for Reports start-----*/
        if(reports == true){
            GetReports batchIns3=new GetReports(UserInfo.getSessionId(),'Report',SelectedObject,SelectedField);
            reportBatchId = Database.executeBatch(batchIns3, 100);
            //system.debug('For Report: '+reportBatchId);
        }
        /*----Calling batch for Reports end-----*/
        
        
        /*Finding formula fields */
        
       
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
                    for(Schema.sObjectType l:listt){
                        if(String.valueof(l)==SelectedObject){
                            string FIELDNAME = fn.getDescribe().getName();   //
                            if(fn.getDescribe().isCustom())
                                 FIELDNAME = FIELDNAME.substring(0,FIELDNAME.lastindexof('__c'))+'__r';   
                             else
                                 FIELDNAME  = FIELDNAME.substringbefore('Id');
                            if(FIELDNAME   == 'Owner' && listt.size() > 1 ){
                                allobjLookupFieldList.add('Owner:User');    
                                LookupFieldList.add('Owner:User');   
                            }else{
                                allobjLookupFieldList.add(FIELDNAME);    
                                LookupFieldList.add(FIELDNAME );   
                            }                            //this is the list of all lookup fields in child object(where selected object has lookup)
                            
                         }
                     }
                }
            } 
           
            for (Schema.SObjectField fn: schemaFieldMap1.values()){ 
                                 
                if(fn.getDescribe().isCalculated()){ //if field is formula field
                    String Formula = fn.getDescribe().getCalculatedFormula();    
                      
                    
                    boolean flag = checkFormula(SelectedObject,child,formf,Formula,LookupFieldList );
                    if(flag){
                        String ff=fn.getDescribe().getName();                                           
                        formulaFieldList.add(child+'.'+ff); //we store child1 as the (object of formula field) and ff is formula field
                    }
                }                 
            }         
        }
        
        if(form == true){
            if(!formulaFieldList.isEmpty()){
                
                GetApexComponents   lhr=new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,formulaFieldList,'formula');
                i = Database.executeBatch(lhr,100);               
            } 
        }
        /* Finding formula Fields end */
        
        Layoutobjectid = SelectedObject; //This is used in Page Layout URL .If the object is custom ,url contains id of object else if it is standard nameof obj.
        
        /*---Finding workflow rules and validation rules---*/
            if(workflow == true){
                GetApexComponents   w =new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'workflow');
                work = Database.executeBatch(w,100);
            }
            if(validation == true){
                GetApexComponents   validationcall = new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'validation');
                valid = Database.executeBatch(validationcall ,100);
            }
             
        /* finding workflow rules and vaildation rules ends */
        
        /* Finding Page Layouts */
            if(playout == true){
                GetApexComponents   pg =new GetApexComponents(UserInfo.getSessionId(),SelectedObject,SelectedField,new List<String>{'xxx'},'Page Layout');
                layout = Database.executeBatch(pg,100);
            }
         /* Finding Page Layouts ends */
             
    }
    
    ID i,work,layout,valid,apexid,flowBatchId,apBatchId,reportBatchId;
    Public void displaychart(){
      rerenderpage();
 
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
        if(reportBatchId != null)
            IDList.add(reportBatchId);
            
        List<AsyncApexJob> aajList;
        if(
            AsyncApexJob.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.AsyncApexJob.fields.Id.isAccessible() &&
            Schema.SObjectType.AsyncApexJob.fields.Status.isAccessible() &&
            Schema.SObjectType.AsyncApexJob.fields.JobItemsProcessed.isAccessible() &&
            Schema.SObjectType.AsyncApexJob.fields.TotalJobItems.isAccessible() &&
            Schema.SObjectType.AsyncApexJob.fields.NumberOfErrors.isAccessible()
        ) {
            aajList = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors
                       FROM AsyncApexJob WHERE ID IN :IDList];   // query on job to know when all batch will be executed .  
        }
        //system.debug('Job List: '+aajList);
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
                if(
                    ApexPage.SObjectType.getDescribe().isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.id.isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.Markup.isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.name.isAccessible()
                ) {
                    for(ApexPage ap:[select id,Markup,name from ApexPage limit  50000]){
                        
                        String lowermarkup = string.valueof(ap.Markup ).toLowerCase();           
                        String objf = sobj+'.'+FieldAPI;                
                        if(lowermarkup.contains(objf.toLowerCase())){
                            
                            ValidationWrapper obj =new ValidationWrapper(ap.name,ap.id,'Apex Page');            
                            generalwrapper.put(ap.id,obj); 
                        }
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
                //System.debug('fieldupdate@@@@@@@@@');
                Map<String,ValidationWrapper> fieldupdateMap = findWorkflowfieldupdate(sobj,FieldAPI,allobjLookupFieldList,flag);
                 //System.debug('fieldupdateMap @@@@@@@@@'+fieldupdateMap );
                if(fieldupdateMap  != null && !fieldupdateMap.isEmpty()){
                    for(String s:fieldupdateMap.keyset()){
                        generalwrapper.put(s,fieldupdateMap.get(s));
                    
                    }
                }
            }
            
            //finding workflowfieldupdate ends
            
            
            String  genral;
            Jsonbody  = '';
            if(generalwrapper != null && generalwrapper.size()>0){
               
                genral = JSON.serialize(generalwrapper.values());               
                Jsonbody = genral;
            }   
             loader = false;            
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
            List<String>reportList =new List<String>();
            List<String>apList =new List<String>();

            List<Amanda__c> AmandaList = Amanda__c.getall().values();
            // for(Amanda__c amn : AmandaList)
            // System.debug('AmandaList ###############'+amn );
            
            if(AmandaList != null && !AmandaList.isEmpty()){
                for(Amanda__c a:AmandaList){
                    //system.debug('Component Type: '+a.ComponentType__c);
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
                    }else if(a.ComponentType__c.contains('Report')){
                         reportList.addAll(a.ComponentIDs__c.split(','));
                         //system.debug('reportList: '+reportList);
                    }
                    // System.debug('CLASSIDLIST'+ classIDList);
                }
            }
                      
            if(classtrigger == true){
                if(
                    Apexclass.SObjectType.getDescribe().isAccessible() &&
                    Schema.SObjectType.Apexclass.fields.id.isAccessible() &&
                    Schema.SObjectType.Apexclass.fields.name.isAccessible()
                ) {
                    for(Apexclass apx:[select id,name from Apexclass where id IN:classIDList]){
                        ValidationWrapper obj =new ValidationWrapper(apx.name,apx.id,'Apex Class');            
                        generalwrapper.put(apx.id,obj);
                        // System.debug('ImpactctrlApexclass'+ apx.Name);
                    }
                }
                if(
                    ApexTrigger.SObjectType.getDescribe().isAccessible() &&
                    Schema.SObjectType.ApexTrigger.fields.id.isAccessible() &&
                    Schema.SObjectType.ApexTrigger.fields.name.isAccessible()
                ) {
                    for(ApexTrigger apt:[select id,name from ApexTrigger where id IN:triggerIDList]){
                        ValidationWrapper obj =new ValidationWrapper(apt.name,apt.id,'Apex Trigger');            
                        generalwrapper.put(apt.id,obj);
                        // System.debug('ImpactctrlApexclass'+ apt.Name);
                    }
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
                if(
                    ProcessDefinition.SObjectType.getDescribe().isAccessible() &&
                    Schema.SObjectType.ProcessDefinition.fields.Id.isAccessible() &&
                    Schema.SObjectType.ProcessDefinition.fields.name.isAccessible()
                ) {
                    for(ProcessDefinition pd: [SELECT Id,name FROM ProcessDefinition where id =: aplist ]){
                        ValidationWrapper obj =new ValidationWrapper(pd.name,pd.id,'Approval Process');            
                        generalwrapper.put(pd.id,obj);
                    }
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
            if(reports == true){
                For(String l: reportList){
                    ValidationWrapper obj =new ValidationWrapper(l.substringafter(';'),l.substringbefore(';'),'Reports');            
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
                req.setTimeout(120000);
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
                if(
                    ApexPage.SObjectType.getDescribe().isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.id.isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.Markup.isAccessible() &&
                    Schema.SObjectType.ApexPage.fields.name.isAccessible()
                ) {
                    for(ApexPage ap:[select id,Markup,name from ApexPage limit 50000]){
                        
                        String lowermarkup = string.valueof(ap.Markup ).toLowerCase();           
                        String objf = sobj+'.'+FieldAPI;                
                        if(lowermarkup.contains(objf.toLowerCase())){
                            
                            ValidationWrapper obj =new ValidationWrapper(ap.name,ap.id,'Apex Page');            
                            generalwrapper.put(ap.id,obj); 
                        }
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
            if(generalwrapper != null && generalwrapper.size()>0){
                
                genral = JSON.serialize(generalwrapper.values());                
                Jsonbody = genral;
            }                              
        }
        List<amanda__c> amList;
        if(
            amanda__c.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.amanda__c.fields.id.isAccessible()
        ) {
            amList = [select id from amanda__c Where Id!= Null];
        }
         if(amList  != null && amList.size() >0)
             amList.clear();
    }
    
    
    // function is used to find particula field in formula.here main is the selected object ,obj is the child object,field is selected field , formula is formula field
    //lookup field list is the field name in child obbject that are refering selected object.
    
    Public boolean checkFormula(string main,String Obj,string Fieldd,string Formula,Set<String> LookupfieldList){
        
        boolean flag= false;
        if(!String.isEmpty(Formula)){
             if(main==obj){                
                if(Formula.contains(Fieldd)){                                       
                    String EForm =  Formula.replace('.'+Fieldd,'');     //if .is used it means this is the field of another object not itself.
                    if(EForm!='') EForm = EForm.toLowerCase();
                   
                    //System.debug('EForm !!!'+EForm +'@@@@@@'+Fieldd.toLowerCase());
                    if(EForm.contains(Fieldd.toLowerCase())){ 
                        Pattern MyPattern = Pattern.compile(Fieldd.toLowerCase()+'[^a-z_]');
                        Matcher MyMatcher = MyPattern.matcher(EForm.toLowerCase()); 
                        
                        Pattern MyPattern1 = Pattern.compile('[^a-z_]'+Fieldd.toLowerCase());
                        Matcher MyMatcher1 = MyPattern1.matcher(EForm.toLowerCase());  
                        
                        Pattern MyPattern2 = Pattern.compile('[^a-z_]'+Fieldd.toLowerCase()+'[^a-z_]');
                        Matcher MyMatcher2 = MyPattern2.matcher(EForm.toLowerCase());   
                        
                         if( (MyMatcher2.find()) || (EForm.substringafter(Fieldd.toLowerCase()) == '' && EForm.substringbefore(Fieldd.toLowerCase()) == '')  ||(EForm.substringafter(Fieldd.toLowerCase()) == '' && MyMatcher1.find()  ) ||(EForm.substringbefore(Fieldd.toLowerCase()) == '' && MyMatcher.find())  ) {
                          
                             //System.debug('find formula fieldsssssssssssss');
                            flag = true;      
                          }               
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
        //System.debug('findworkflowfield!!!!!!!!'+lookupfieldList);  
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET'); 
        
        Http http = new Http();      
        req.setEndpoint(OrgURL+'/services/data/v34.0/tooling/query/?q=select+id,FullName,metadata+from+WorkflowFieldUpdate');
        req.setTimeout(120000);
        HTTPResponse objres = http.send(req); 
        //System.debug('objres.getBody@@@@'+objres.getBody());  
        List<String> fupdate = objres.getBody().split('"Id":');
        Map<String,ValidationWrapper> generalwrapper = new Map<String,ValidationWrapper>();
         integer i=0;
        if(custom == true && prefix != null && prefix != '' &&  !sobjectname.contains(prefix +'__'))
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
        String fieldName1 = fieldName;
        String ObjectName1 = ObjectName;
        
        if(fieldName.countMatches('__')==2)
            fieldName1 = fieldName1.substringafter('__');   
                
        if(ObjectName.countMatches('__')==2)
            ObjectName1 = ObjectName.substringafter('__');
            
        
    
        List < EmailTemplate > templist = new List < EmailTemplate > ();
        
        if(ObjectName != null && fieldName != null ) {
            if(
                EmailTemplate.SObjectType.getDescribe().isAccessible() &&
                Schema.SObjectType.EmailTemplate.fields.id.isAccessible() &&
                Schema.SObjectType.EmailTemplate.fields.Name.isAccessible() &&
                Schema.SObjectType.EmailTemplate.fields.Body.isAccessible()
            ) {
                for(EmailTemplate ee:[select id,Name,Body from  EmailTemplate limit  50000]){
                    if(ee.Body != null ){
                        Pattern MyPattern = Pattern.compile('\\{!.*'+ObjectName.toLowerCase()+'\\.'+fieldName.toLowerCase()+'.*}' + 
                                                            '|\\{!.*'+ObjectName1.toLowerCase()+'\\.'+fieldName1.toLowerCase()+'.*}');                    
                        Matcher MyMatcher = MyPattern.matcher(ee.Body.toLowerCase());
                        if(MyMatcher.find()) {
                            templist.add(ee);
                        }
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
            Amanda_License__c lic;
            if(
                Amanda_License__c.SObjectType.getDescribe().isCreateable() &&
                Schema.SObjectType.Amanda_License__c.fields.Status__c.isCreateable() &&
                Schema.SObjectType.Amanda_License__c.fields.name.isCreateable() 
            ){
                 lic = new Amanda_License__c(name=orgName,Status__c = 'Free');  
            }
            
            try{
                if(Schema.sObjectType.Amanda_License__c.isCreateable())
                    insert lic; 
            }catch(Exception ex){
                pagemessage = ex.getMessage();/*ApexPages.addMessages(ex);*/
            }
        }
        isOnLoad= false;
        
    }
    
    // validate license key
    public string LicenseKey{get;set;}
    public void validateLicenseKey(){
        pagemessage = '';
        //String orgId = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        String orgId = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationId())+''+'0';
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
                    if(
                        Amanda_License__c.SObjectType.getDescribe().isCreateable() &&
                        Schema.SObjectType.Amanda_License__c.fields.Status__c.isCreateable() &&
                        Schema.SObjectType.Amanda_License__c.fields.Key__c.isCreateable() &&
                        Amanda_License__c.SObjectType.getDescribe().isUpdateable()&&
                        Schema.SObjectType.Amanda_License__c.fields.Key__c.isUpdateable() &&
                        Schema.SObjectType.Amanda_License__c.fields.Status__c.isUpdateable()
                    ) {
                        AmandaLic = lic;AmandaLic.Status__c = 'Paid';AmandaLic.Key__c= LicenseKey; 
                    }
                }
            } 
            if(AmandaLic != null && (Schema.sObjectType.Amanda_License__c.isCreateable() && Schema.sObjectType.Amanda_License__c.isUpdateable())){ 
                upsert AmandaLic;
            }    
            isTrial = false; 
        }
           
    }
   
    
   
    public class ValidationWrapper{
    
        Public String Name;
        Public String Id;
        Public String type; 
        public ValidationWrapper() {}      
        
        public ValidationWrapper(String VNames,string compids,string types){
        
          Name = VNames;
          Id = compids;
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
    public void tempmethod(){
    
         rerenderpage();   
    }
    
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
    }

}