@isTest
public class ImpactAnalysis_ControllerTest  {
  
    /*private class WebServiceMockImpl implements WebServiceMock 
    {
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType) 
        {
            if(request instanceof MetadataService.retrieve_element)
                response.put('response_x', new MetadataService.retrieveResponse_element());
            else if(request instanceof MetadataService.checkDeployStatus_element)
                response.put('response_x', new MetadataService.checkDeployStatusResponse_element());
            else if(request instanceof MetadataService.listMetadata_element)
                response.put('response_x', new MetadataService.listMetadataResponse_element());
            else if(request instanceof MetadataService.checkRetrieveStatus_element)
                response.put('response_x', new MetadataService.checkRetrieveStatusResponse_element());
            else if(request instanceof MetadataService.describeMetadata_element)
                response.put('response_x', new MetadataService.describeMetadataResponse_element());
            else if(request instanceof MetadataService.deploy_element)
                response.put('response_x', new MetadataService.deployResponse_element());
            else if(request instanceof MetadataService.updateMetadata_element)
                response.put('response_x', new MetadataService.updateMetadataResponse_element());
            else if(request instanceof MetadataService.renameMetadata_element)
                response.put('response_x', new MetadataService.renameMetadataResponse_element());
            else if(request instanceof  MetadataService.cancelDeploy_element)
                response.put('response_x', new MetadataService.cancelDeployResponse_element());
            else if(request instanceof  MetadataService.deleteMetadata_element)
                response.put('response_x', new MetadataService.deleteMetadataResponse_element());
            else if(request instanceof  MetadataService.upsertMetadata_element)
                response.put('response_x', new MetadataService.upsertMetadataResponse_element());
            else if(request instanceof  MetadataService.createMetadata_element)
                response.put('response_x', new MetadataService.createMetadataResponse_element());
            else if(request instanceof  MetadataService.deployRecentValidation_element)
                response.put('response_x', new MetadataService.deployRecentValidationResponse_element());
            else if(request instanceof MetadataService.describeValueType_element)
                response.put('response_x', new MetadataService.describeValueTypeResponse_element());
            else if(request instanceof MetadataService.checkRetrieveStatus_element)
                response.put('response_x', new MetadataService.checkRetrieveStatusResponse_element());
            return;
        }
    } 
    
    //class
    public static testMethod void myUnitTest1() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();

        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'name';
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.pages = true;
        sc1.email = true;       
        sc1.classtrigger = true;

        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        
        Test.startTest();
        new MetadataService();

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
        Amanda__c am = new Amanda__c();
        am.name = '1-Apex Class';
        am.ComponentIDs__c = '011,022,033';
        am.ComponentType__c = 'Apex Class';
        insert am;
        
        Amanda__c am1 = new Amanda__c();
        am1.name = '1-Apex Trigger';
        am1.ComponentIDs__c = '011,022,033';
        am1.ComponentType__c = 'Apex Trigger';
        insert am1;
        
        Amanda__c am6 = new Amanda__c();
        am6.name = '00-Flow';
        am6.ComponentIDs__c = '011,022,033';
        am6.ComponentType__c = '00-flow';
        insert am6;
        
        Amanda__c am3 = new Amanda__c();
        am3.name = '00-Formula Field';
        am3.ComponentIDs__c = '011,022,033';
        am3.ComponentType__c = 'Formula Field';
        insert am3;     
        
        Test.stopTest();  
        sc1.displaychart();   
        
    }

    //page layout
    public static testMethod void myUnitTest2() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.rerenderpage();

        sc1.playout = true;

        sc1.Jsoncontent = '{"attributes":{"type":"Layout","url":"/services/data/v34.0/tooling/sobjects/Layout/00h280000038NU0AAM"},"Id":"00h280000038NU0AAM","Name":"Account (Marketing) Layout","NamespacePrefix":"ChangeGuru","TableEnumOrId":"Account","CreatedDate":"2016-01-15T11:08:19.000+0000","CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-12-19T08:48:02.000+0000","LastModifiedById":"005280000022DtkAAE","ShowSubmitAndAttachButton":true,"Metadata":{"customButtons":null,"customConsoleComponents":null,"emailDefault":false,"excludeButtons":null,"feedLayout":null,"headers":["PersonalTagging","PublicTagging"],"layoutSections":[{"customLabel":false,"detailHeading":false,"editHeading":true,"label":"Account Information","layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"OwnerId","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Required","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Name","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ParentId","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"AccountNumber","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Site","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__csrvalue__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Readonly","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__nnn__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__cs__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Readonly","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__formulatesting__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__testing__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__CustomObj__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null},{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Rating","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Phone","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Fax","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Website","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"TickerSymbol","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null}],"style":"TwoColumnsTopToBottom"},{"customLabel":false,"detailHeading":false,"editHeading":true,"label":"Address Information","layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"BillingAddress","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null},{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ShippingAddress","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null}],"style":"TwoColumnsTopToBottom"},{"customLabel":false,"detailHeading":false,"editHeading":true,"label":"Additional Information","layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__Active__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__CustomerPriority__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Required","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__SLA__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Required","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__SLASerialNumber__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Industry","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"AnnualRevenue","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Ownership","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null},{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__UpsellOpportunity__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__NumberofLocations__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Required","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"ChangeGuru__SLAExpirationDate__c","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Type","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Sic","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null},{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"NumberOfEmployees","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null}],"style":"TwoColumnsLeftToRight"},{"customLabel":false,"detailHeading":false,"editHeading":true,"label":"System Information","layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Readonly","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"CreatedById","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null},{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Readonly","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"LastModifiedById","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null}],"style":"TwoColumnsTopToBottom"},{"customLabel":false,"detailHeading":false,"editHeading":true,"label":"Description Information","layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":"Edit","canvas":null,"component":null,"customLink":null,"emptySpace":null,"field":"Description","height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null}],"style":"OneColumn"},{"customLabel":false,"detailHeading":false,"editHeading":false,"label":null,"layoutColumns":[{"layoutItems":[{"analyticsCloudComponent":null,"behavior":null,"canvas":null,"component":null,"customLink":"ChangeGuru__Billing","emptySpace":null,"field":null,"height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}],"reserved":null},{"layoutItems":[],"reserved":null},{"layoutItems":[],"reserved":null}],"style":"CustomLinks"}],"miniLayout":{"fields":["Name","ParentId","ChangeGuru__SLA__c","ChangeGuru__SLASerialNumber__c","ChangeGuru__SLAExpirationDate__c"],"relatedLists":[]},"multilineLayoutFields":null,"platformActionList":null,"quickActionList":{"quickActionListItems":[{"quickActionName":"FeedItem.TextPost"},{"quickActionName":"FeedItem.ContentPost"},{"quickActionName":"ChangeGuru__NewTask"},{"quickActionName":"ChangeGuru__NewContact"},{"quickActionName":"ChangeGuru__NewCase"},{"quickActionName":"ChangeGuru__LogACall"},{"quickActionName":"ChangeGuru__NewNote"},{"quickActionName":"ChangeGuru__NewOpportunity"},{"quickActionName":"ChangeGuru__NewEvent"},{"quickActionName":"FeedItem.LinkPost"},{"quickActionName":"FeedItem.PollPost"},{"quickActionName":"FeedItem.QuestionPost"}]},"relatedContent":{"relatedContentItems":[{"layoutItem":{"analyticsCloudComponent":null,"behavior":null,"canvas":null,"component":"runtime_sales_social:socialPanel","customLink":null,"emptySpace":null,"field":null,"height":null,"page":null,"reportChartComponent":null,"scontrol":null,"showLabel":null,"showScrollbars":null,"width":null}}]},"relatedLists":[{"customButtons":[],"excludeButtons":[],"fields":["FULL_NAME","CONTACT.TITLE","CONTACT.EMAIL","CONTACT.PHONE1"],"relatedList":"RelatedContactList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["TASK.SUBJECT","TASK.WHO_NAME","TASK.WHAT_NAME","ACTIVITY.TASK","TASK.DUE_DATE","TASK.STATUS","TASK.PRIORITY","CORE.USERS.FULL_NAME"],"relatedList":"RelatedActivityList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["TASK.SUBJECT","TASK.WHO_NAME","TASK.WHAT_NAME","ACTIVITY.TASK","TASK.DUE_DATE","CORE.USERS.FULL_NAME","TASK.LAST_UPDATE"],"relatedList":"RelatedHistoryList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["OPPORTUNITY.NAME","OPPORTUNITY.STAGE_NAME","OPPORTUNITY.AMOUNT","OPPORTUNITY.CLOSE_DATE"],"relatedList":"RelatedOpportunityList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["CASES.CASE_NUMBER","NAME","CASES.SUBJECT","CASES.PRIORITY","CASES.CREATED_DATE_DATE_ONLY","CASES.STATUS","OWNER_NAME"],"relatedList":"RelatedCaseList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":[],"relatedList":"RelatedNoteList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["ACCOUNT.NAME","OPPORTUNITY.NAME","PARTNER.ROLE"],"relatedList":"RelatedPartnerList","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["NAME"],"relatedList":"ChangeGuru__CustomObj__c.ChangeGuru__Account__c","sortField":null,"sortOrder":null},{"customButtons":[],"excludeButtons":[],"fields":["CreatedDate","StepStatus","OriginalActor","Actor","Comments"],"relatedList":"RelatedProcessHistoryList","sortField":null,"sortOrder":null}],"relatedObjects":["ParentId"],"runAssignmentRulesDefault":false,"showEmailCheckbox":true,"showHighlightsPanel":false,"showInteractionLogPanel":false,"showKnowledgeComponent":null,"showRunAssignmentRulesCheckbox":true,"showSolutionSection":null,"showSubmitAndAttachButton":false,"summaryLayout":null,"urls":null},"FullName":"Account-ChangeGuru__Account %28Marketing%29 Layout","EntityDefinitionId":"Account"';
        sc1.callpageredirect();
        
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();
        sc1.SelectedField = 'name';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1a()); //page layout

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents();
        
         Amanda__c am2 = new Amanda__c();
        am2.name = '00-Page Layout';
        am2.ComponentIDs__c = '011,022,033';
        am2.ComponentType__c = 'Page Layout';
        insert am2;
        
        
        Test.stopTest(); 
        sc1.displaychart();     
    }

    //work flow
    public static testMethod void myUnitTest3() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        
        sc1.displaychart();
        
        sc1.SelectedObject = 'ChangeGuru__CustomObj__c';
        sc1.SelectedField = 'name';
        sc1.rerenderpage();

        sc1.workflow = true;

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));
        
        sc1.Jsoncontent = '{"attributes":{"type":"WorkflowRule","url":"/services/data/v34.0/tooling/sobjects/WorkflowRule/01Q280000007mpmEAA"},"Id":"01Q280000007mpmEAA","Name":"testWFRule1","TableEnumOrId":"Account","NamespacePrefix":"ChangeGuru","CreatedDate":"2016-07-20T06:31:14.000+0000","CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-11-15T11:04:27.000+0000","LastModifiedById":"005280000022DtkAAE","Metadata":{"actions":[],"booleanFilter":null,"criteriaItems":[{"field":"Account.Name","operation":"contains","value":"a","valueField":null}],"formula":null,"urls":null,"workflowTimeTriggers":[],"active":false,"description":null,"triggerType":"onCreateOrTriggeringUpdate"},"FullName":"Account.ChangeGuru__testWFRule1"}';
        sc1.callpageredirect();

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1b()); // Workflow

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents();   
      
        Amanda__c am5 = new Amanda__c();
        am5.name = '00-WorkFlow Rule';
        am5.ComponentIDs__c = '011,022,033';
        am5.ComponentType__c = '00-WorkFlow Rule';
        insert am5;
        Test.stopTest(); 
        sc1.displaychart();     
    }

    //validation
    public static testMethod void myUnitTestValidation() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'ChangeGuru__CustomObj__c';
        sc1.SelectedField = 'name';
        sc1.rerenderpage();

        sc1.validation = true;

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        sc1.Jsoncontent = '{"size":1,"Id":"676755","ValidationName":"ValidatePhone","FullName":"Contact.ChangeGuru__billingfield__c","url":"/services/data/v34.0/tooling/sobjects/ValidationRule/03d28000000Zmeur","DeveloperName":"ChangeGuru__CustomObj__c",  "errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}';
        sc1.callpageredirect();

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2()); // Validation

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents(); 
       
        Amanda__c am4 = new Amanda__c();
        am4.name = '00-Validation Rule';
        am4.ComponentIDs__c = '011,022,033';
        am4.ComponentType__c = 'Validation Rule';
        insert am4;
          
        Test.stopTest(); 
         sc1.displaychart(); 
             
    }
    
    //trigger
    public static testMethod void myUnitTest4() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.rerenderpage();

        sc1.classtrigger = true;
        
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        sc1.Jsoncontent = '{"size":2,"Id":"676755","FullName":"Contact.ChangeGuru__billingfield__c","DeveloperName":"Account","url":"/services/data/v34.0/tooling/sobjects/ApexTrigger/01q28000000C0iv","formula":"Account.nnn__c","urls":"fff","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )","errorDisplayField":"abc", "url":"/services/data/v34.0/tooling/sobjects/ApexTrigger/01q2800000049IE","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c", "formula":"Account.nnn__c","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}';
        sc1.callpageredirect();

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();
        sc1.SelectedField = 'name';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3()); // Apex Trigger

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents(); 
        sc1.displaychart();   
        Test.stopTest();      
    }

    //workflow field update
    public static testMethod void myUnitTest5() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        
        sc1.displaychart();
        
        sc1.SelectedObject = 'Account';
        sc1.rerenderpage();

        sc1.fieldupdate = true;
        
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        sc1.Jsoncontent = '{"attributes":{"type":"WorkflowFieldUpdate","url":"/services/data/v34.0/tooling/sobjects/WorkflowFieldUpdate/04Y28000000Qey2EAC"}, "Id":"04Y28000000Qey2EAC", "FullName":"Contact.WorkFlowFieldUpdate42", "Metadata":{"field":"LastName","formula":null,"literalValue":null,"lookupValue":null,"lookupValueType":null,"Name":"WorkFlowFieldUpdate42","protected":false,"reevaluateOnChange":null,"targetObject":null,"urls":null,"description":null,"notifyAssignee":false,"operation":"Literal"}}';
        sc1.callpageredirect();

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();
        sc1.SelectedField = 'name';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3a()); // Work Flow field Update

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents();
        sc1.displaychart(); 
        Test.stopTest();      
    }

    // email template
    public static testMethod void myUnitTest6() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'profileRoles';
        sc1.Returnpage();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        
        sc1.displaychart();
        
        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'name';
        sc1.rerenderpage();

        sc1.email = true;

        sc1.createLicenseRecord();
        sc1.validateLicenseKey();

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');
        //sc1.callpageredirect();

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        sc1.Returnpage();

        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        
        sc1.callApexcomponents();
        sc1.displaychart();
    
        Test.stopTest();      
    }
    
    //approval process
    public static testMethod void myUnitTest7() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'name';
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        sc1.approv = true;

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        sc1.Jsoncontent = '';
        sc1.callpageredirect();

        //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1a());   //// Ask Fakeha
        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');

        Test.startTest();
        new MetadataService();

        // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
         Amanda__c am6 = new Amanda__c();
        am6.name = '00-Approval Process';
        am6.ComponentIDs__c = '011,022,033';
        am6.ComponentType__c = '00-Approval Process';
        insert am6;
         
        Test.stopTest(); 
        sc1.displaychart();     
    }

    //vf pages
    public static testMethod void myUnitTest8() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';

        sc1.displaychart();

        sc1.SelectedField = 'name';
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        sc1.pages = true;

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));
        ImpactAnalysis_Controller.ValidationWrapper vp = new ImpactAnalysis_Controller.ValidationWrapper('Marketing: Product Inquiry Response','00X280000016SgV','Email Template');
        //string content = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';

        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');

        Test.startTest();
        new MetadataService();

        //new MetadataService.ApprovalProcess();
         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
        sc1.displaychart();
         
        Test.stopTest();      
    }

    //formula fields
    public static testMethod void myUnitTest9() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'name';
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        sc1.form = true;

        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3b());
        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');

        Test.startTest();
        new MetadataService();

        //new MetadataService.ApprovalProcess();
         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
        
          
         
        Test.stopTest(); 
        sc1.displaychart();     
    }
    
    //Flow
    public static testMethod void myUnitTest10() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'Name';
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        sc1.flowsAndProcess = true;

        sc1.Jsoncontent = '{"attributes":{"type":"Flow","url":"/services/data/v34.0/tooling/sobjects/Flow/30128000000S65fAAC"},"Id":"30128000000S65fAAC","DefinitionId":"30028000000Pp41AAC","MasterLabel":"processss","VersionNumber":1,"Status":"Active","Description":null,"ProcessType":"Workflow","CreatedDate":"2016-12-23T10:31:45.000+0000","CreatedById":"00528000005e8JzAAI","LastModifiedDate":"2016-12-23T10:32:04.000+0000","LastModifiedById":"00528000005e8JzAAI","Metadata":{"actionCalls":[],"apexPluginCalls":[],"assignments":[{"assignmentItems":[{"assignToReference":"myVariable_waitStartTimeVariable","operator":"Assign","processMetadataValues":[],"value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":"$Flow.CurrentDateTime","numberValue":null,"stringValue":null}}],"connector":{"processMetadataValues":[],"targetReference":"myDecision"},"description":null,"label":"myVariable_waitStartTimeAssignment","locationX":0,"locationY":0,"name":"myVariable_waitStartTimeAssignment","processMetadataValues":[]}],"choices":[],"constants":[],"decisions":[{"defaultConnector":null,"defaultConnectorLabel":"default","description":null,"label":"myDecision","locationX":50,"locationY":0,"name":"myDecision","processMetadataValues":[{"name":"index","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":0.0,"stringValue":null}}],"rules":[{"conditionLogic":"and","conditions":[{"leftValueReference":"myVariable_current.Name","operator":"EqualTo","processMetadataValues":[{"name":"inputDataType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}},{"name":"leftHandSideType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}},{"name":"operatorDataType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}},{"name":"rightHandSideType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}}],"rightValue":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"fakeha"}}],"connector":{"processMetadataValues":[],"targetReference":"myRule_1_A1"},"description":null,"label":"cri","name":"myRule_1","processMetadataValues":[]}]}],"description":null,"dynamicChoiceSets":[],"formulas":[],"interviewLabel":"processss-1_Account","label":"processss","loops":[],"processMetadataValues":[{"name":"ObjectType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"Account"}},{"name":"ObjectVariable","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":"myVariable_current","numberValue":null,"stringValue":null}},{"name":"OldObjectVariable","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":"myVariable_old","numberValue":null,"stringValue":null}},{"name":"TriggerType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"onCreateOnly"}}],"processType":"Workflow","recordCreates":[{"assignRecordIdToReference":null,"connector":null,"description":null,"faultConnector":null,"inputAssignments":[{"field":"Name","processMetadataValues":[{"name":"dataType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}},{"name":"isRequired","value":{"booleanValue":true,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":null}},{"name":"leftHandSideLabel","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"Account Name"}},{"name":"rightHandSideType","value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"String"}}],"value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"fakeha"}}],"inputReference":null,"label":"rec","locationX":100,"locationY":200,"name":"myRule_1_A1","object":"Account","processMetadataValues":[]}],"recordDeletes":[],"recordLookups":[],"recordUpdates":[],"screens":[],"startElementReference":"myVariable_waitStartTimeAssignment","steps":[],"subflows":[],"textTemplates":[],"urls":null,"variables":[{"dataType":"SObject","description":null,"isCollection":false,"isInput":true,"isOutput":true,"name":"myVariable_current","objectType":"Account","processMetadataValues":[],"scale":null,"value":null},{"dataType":"SObject","description":null,"isCollection":false,"isInput":true,"isOutput":false,"name":"myVariable_old","objectType":"Account","processMetadataValues":[],"scale":null,"value":null},{"dataType":"DateTime","description":null,"isCollection":false,"isInput":false,"isOutput":false,"Name":"myVariable_waitStartTimeVariable","objectType":null,"processMetadataValues":[],"scale":null,"value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":"$Flow.CurrentDateTime","numberValue":null,"stringValue":null}}],"waits":[]},"FullName":"processss-1"}';
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));

        sc1.callpageredirect();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3c());
        Account a = new Account();
        a.name= 'Test';
        a.phone = '9412584353';
        insert a;
        System.assertEquals(a.name, 'Test');
        Approval.ProcessSubmitRequest app = new Approval.ProcessSubmitrequest();
            app.setObjectId(a.Id);
        Test.startTest();
        new MetadataService();

         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
        
        
        Test.stopTest(); 
        sc1.displayChart();     
    }
    static testMethod void testmethod7()
    { 
        List<String> formulaList = new List<String>{'abc.abc__c'};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3b());
        Test.startTest();
        GetApexComponents gac = new GetApexComponents('32134', 'account', 'test__c', formulaList, 'formula');
        Database.executeBatch(gac);
        Test.stopTest();
    } */
}