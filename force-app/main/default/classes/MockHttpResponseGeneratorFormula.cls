@isTest
global class MockHttpResponseGeneratorFormula implements HttpCalloutMock {    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String ProfId = userInfo.getProfileId();
        res.setBody('{"size":1,"totalSize":1,"done":true,"queryLocator":null,"entityTypeName":"CustomField","records":[{"attributes":{"type":"CustomField","url":"/services/data/v34.0/tooling/sobjects/CustomField/00N28000009vkYqEAI"},"Id":"00N28000009vkYqEAI","FullName":"ChangeGuru__CustomObj__c.formula_field__c"}]}');
        res.setStatusCode(200);
        return res;
    }
}