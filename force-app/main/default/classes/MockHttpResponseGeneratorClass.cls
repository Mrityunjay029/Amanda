@isTest
global class MockHttpResponseGeneratorClass implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');

        System.assert(contentType == 'application/json');

        res.setBody(' {"size":2,"Id":"676755","FullName":"Contact.ChangeGuru__billingfield__c","DeveloperName":"Account__c","url":"/services/data/v34.0/tooling/sobjects/ApexClass/01p28000006Jj3e","formula":"Account.nnn__c","urls":"fff","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )","errorDisplayField":"abc", "url":"/services/data/v34.0/tooling/sobjects/ApexClass/01p28000006qvS5","errorConditionFormula":"YEAR(SLAExpirationDate__c) <> YEAR( TODAY() )", "CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-01-29T11:43:46.000+0000", "LastModifiedById":"005280000022DtkAAE","TableEnumOrId":"Account","field":"nnn__c", "formula":"Account.nnn__c","urls":"fff","EntityDefinitionId":"Account","Name":"ttt", "errorDisplayField":"abc", "MasterLabel":"firstflow"}');
        res.setStatusCode(200);
        return res;
    }
}