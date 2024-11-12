@isTest
global with sharing class MockHttpResponseGenerator3b implements HttpCalloutMock { // Formula Field
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String ProfId = userInfo.getProfileId();
        res.setBody('{"size":2,"totalSize":2,"done":true,"queryLocator":null,"entityTypeName":"CustomField","records":[{"attributes":{"type":"CustomField","url":"/services/data/v34.0/tooling/sobjects/CustomField/00N28000009vkYqEAI"},"Id":"00N28000009vkYqEAI","FullName":"Account.ChangeGuru__formulatesting__c"}]}');
        res.setStatusCode(200);
        return res;
    }
}