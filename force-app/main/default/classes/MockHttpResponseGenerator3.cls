@isTest
global with sharing class MockHttpResponseGenerator3 implements HttpCalloutMock { // Apex Trigger
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');

        System.assert(contentType == 'application/json');

        res.setBody(' {"size":2,"Id":"676755","FullName":"Contact.ChangeGuru__billingfield__c","DeveloperName":"Account","url":"/services/data/v34.0/tooling/sobjects/ApexTrigger/01q28000000C0iv","formula":"Account.nnn__c","urls":"fff","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )","errorDisplayField":"abc", "url":"/services/data/v34.0/tooling/sobjects/ApexTrigger/01q2800000049IE","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c", "formula":"Account.nnn__c","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}');
        res.setStatusCode(200);
        return res;
    }
}