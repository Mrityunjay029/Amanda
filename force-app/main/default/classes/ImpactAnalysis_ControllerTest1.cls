@isTest
public class ImpactAnalysis_ControllerTest1  {
  
    private class WebServiceMockImpl implements WebServiceMock 
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
   /* public static testMethod void myUnitTest4() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.rerenderpage();

        sc1.createLicenseRecord();

        sc1.validateLicenseKey();
        sc1.classtrigger = true;

        SC1.flowsAndProcess = true; // for flows and approval process

        sc1.SelectedField = 'name';
        sc1.Jsoncontent = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));
        ImpactAnalysis_Controller.ValidationWrapper vp = new ImpactAnalysis_Controller.ValidationWrapper('Marketing: Product Inquiry Response','00X280000016SgV','Email Template');
        string content = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';
         Test.startTest();
         sc1.callpageredirect();
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         sc1.callApexcomponents();
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator8());
         Test.stopTest();      
    }*/
    
    public static testMethod void myUnitTest2() {

        ImpactAnalysis_Controller sc1 = new ImpactAnalysis_Controller();
        sc1.choices = 'FieldsValues';
        sc1.Returnpage();
        sc1.SelectedObject = 'Account';
        sc1.SelectedField = 'Id';
        sc1.rerenderpage();
        sc1.createLicenseRecord();
        sc1.LicenseKey = UserInfo.getOrganizationId().subString(0,15).subString(UserInfo.getOrganizationId().subString(0,15).length()-5,UserInfo.getOrganizationId().subString(0,15).length())+''+UserInfo.getOrganizationId().subString(0,5)+''+soundex.tosoundex(UserINFO.getOrganizationName())+''+'0';
        sc1.validateLicenseKey();

        sc1.flowsAndProcess = true;

         sc1.Jsoncontent = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));
        ImpactAnalysis_Controller.ValidationWrapper vp = new ImpactAnalysis_Controller.ValidationWrapper('Marketing: Product Inquiry Response','00X280000016SgV','Email Template');
        //pd.type1 = 'Apex Class';
        //pd.entity = 'Test';
        string content = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';

        sc1.callpageredirect();
        //sc1.CreateJsonData(content);

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

        //new MetadataService.ApprovalProcess();
         // Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());

        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();

        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
        sc1.callApexcomponents();
         
         //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3d());
         Test.stopTest();      
    }
    
     /* public static testMethod void myUnitTest1() {

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

         sc1.Jsoncontent = '{"attributes":{"type":"Formula Field"},"Id":"00N28000009vkYqEAI","Name":"nnn","CreatedBy":"Shweta Garg","LastModifedBy":"Shweta Garg","LatModifiedByDate":"2016-02-04"}';
        ImpactAnalysis_Controller.pdfWrapper pd = new ImpactAnalysis_Controller.pdfWrapper('test','00N28000009vkYqEAI');//,'test12','test123',string.valueof(date.today()));
        ImpactAnalysis_Controller.ValidationWrapper vp = new ImpactAnalysis_Controller.ValidationWrapper('Marketing: Product Inquiry Response','00X280000016SgV','Email Template');

        sc1.callpageredirect();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1a());
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
         
         //Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator8());
         Test.stopTest();      
    } */

}