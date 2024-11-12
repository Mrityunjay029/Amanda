@IsTest
Public class GetApexComponentsTest{

    /*static testMethod void testmethod1()
    { 
        List<String> formulaList = new List<String>{'abc'};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator4());
        Test.startTest();
        GetApexComponents gac = new GetApexComponents('32134', 'account', 'id', formulaList, 'workflow');
        Database.executeBatch(gac);
        Test.stopTest();
    } //Pass

    static testMethod void testmethod1a()
    { 
        List<String> formulaList = new List<String>{'abc'};
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator4());
        Test.startTest();
        GetApexComponents gac = new GetApexComponents('32134', 'ChangeGuru__CustomObj__c', 'Name', formulaList, 'workflow');
        Database.executeBatch(gac);
        Test.stopTest();
    } //Pass

    static testMethod void testmethod2()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'ChangeGuru__billingfield__c', formulaList, 'validation');
        Database.executeBatch(gac);
        Test.stopTest();
    } //Pass

    static testMethod void testmethod2b()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'name', formulaList, 'validation');
        Database.executeBatch(gac);
        Test.stopTest();
    } //Pass

    static testMethod void testmethod2a()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3());
        GetApexComponents gac = new GetApexComponents('32134', 'ChangeGuru__CustomObj__c', 'Name', formulaList, 'validation');
        Database.executeBatch(gac);
        Test.stopTest();
    } //custom object

    static testMethod void testmethod2c()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3());
        GetApexComponents gac = new GetApexComponents('32134', 'ChangeGuru__CustomObj__c', 'ChangeGuru__Account__c', formulaList, 'validation');
        Database.executeBatch(gac);
        Test.stopTest();
    }*/ //custom object
    
    /*static testMethod void testmethod3()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2());
        GetApexComponents gac = new GetApexComponents(UserInfo.getSessionId(), 'Account', 'ChangeGuru__nnn__c', formulaList, 'formula');
        Database.executeBatch(gac);
        Test.stopTest();
    }*/ // fail for formula

    /*static testMethod void testmethod4()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator6());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'email', formulaList, 'Page Layout');
        Database.executeBatch(gac);
        Test.stopTest();
    } // pass for page layout

    static testMethod void testmethod4a()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator6());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'ChangeGuru__billingfield__c', formulaList, 'Page Layout');
        Database.executeBatch(gac);
        Test.stopTest();
    } // pass for page layout

    static testMethod void testmethod5()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1a());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'email', formulaList, 'apexclassntrigger');
        Database.executeBatch(gac);
        Test.stopTest();
    } //Pass for Apex class stdrd field

    static testMethod void testmethod5b()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator1a());
        GetApexComponents gac = new GetApexComponents('32134', 'ChangeGuru__CustomObj__c', 'Name', formulaList, 'apexclassntrigger');
        Database.executeBatch(gac);
        Test.stopTest();
    }//pass for Apex class custom object

    static testMethod void testmethod6()
    { 
        List<String> formulaList = new List<String>{'abc'};
    
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator3a());
        GetApexComponents gac = new GetApexComponents('32134', 'Contact', 'name', formulaList, 'apexclassntrigger');
        Database.executeBatch(gac);
        Test.stopTest();
    }*/ //Pass for Apex Trigger
    
    
}