@isTest
global with sharing class MockHttpResponseGenerator2 implements HttpCalloutMock { // Validation
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');
        //System.assert(contentType, 'application/json');
        System.assertEquals('test', 'test');
        string userName = userInfo.getName();
        //res.setBody(' {"size":1,"Id":"676755","ValidationName":"ValidatePhone","FullName":"Contact.ChangeGuru__billingfield__c","url":"/services/data/v34.0/tooling/sobjects/ValidationRule/03d28000000ZmLb","DeveloperName":"ChangeGuru__CustomObj__c",  "errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c", "formula":"username =\''+ userName +'\'","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}');
        res.setBody(' {"size":1,"Id":"676755","ValidationName":"ValidatePhone","FullName":"Contact.ChangeGuru__billingfield__c","url":"/services/data/v34.0/tooling/sobjects/ValidationRule/03d28000000Zmeur","DeveloperName":"ChangeGuru__CustomObj__c",  "errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c", "formula":"username =\''+ userName +'\'","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}');
        res.setStatusCode(200);
        return res;
    }
}