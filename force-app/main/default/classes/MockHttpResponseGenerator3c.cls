@isTest
global with sharing class MockHttpResponseGenerator3c implements HttpCalloutMock { // Flow start
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        string userName = userInfo.getName();
        
        res.setBody('{"size":3,"totalSize":3,"done":true,"queryLocator":null,"entityTypeName":"Flow","records":[{"attributes":{"type":"Flow","url":"/services/data/v34.0/tooling/sobjects/Flow/30128000000S65fAAC"},"Id":"30128000000S65fAAC","ProcessType":"Workflow","VersionNumber":1,"Status":"Active"},{"attributes":{"type":"Flow","url":"/services/data/v34.0/tooling/sobjects/Flow/30128000000SBCvAAO"},"ProcessType":"Flow","VersionNumber":1,"Status":"Active"},{"attributes":{"type":"Flow","url":"/services/data/v34.0/tooling/sobjects/Flow/30128000000SHnnAAG"},"object":"Account","field":"Name","ProcessType":"Workflow","VersionNumber":1,"Status":"Active", "FullName":"processss-1"}]}');
        return res;
    }
}