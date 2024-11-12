@isTest
global with sharing class MockHttpResponseGenerator3a implements HttpCalloutMock { // Work Flow Field Update
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');

        System.assert(contentType == 'application/json');

        res.setBody(' {"size":1,"totalSize":1,"done":true,"queryLocator":null,"entityTypeName":"WorkflowFieldUpdate","records":[{"attributes":{"type":"WorkflowFieldUpdate","url":"/services/data/v34.0/tooling/sobjects/WorkflowFieldUpdate/04Y28000000Qey2EAC"},"Id":"04Y28000000Qey2EAC","FullName":"Contact.WorkFlowFieldUpdate42","Metadata":{"field":"LastName","formula":null,"literalValue":null,"lookupValue":null,"lookupValueType":null,"name":"WorkFlowFieldUpdate42","protected":false,"reevaluateOnChange":null,"targetObject":null,"urls":null,"description":null,"notifyAssignee":false,"operation":"Literal"}},nChange":null,"targetObject":null,"urls":null,"description":null,"notifyAssignee":false,"operation":"Null"}}]}');
        res.setStatusCode(200);
        return res;
    }
}