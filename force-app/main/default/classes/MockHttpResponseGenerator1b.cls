@isTest
global with sharing class MockHttpResponseGenerator1b implements HttpCalloutMock { // WorkFlowRule
    
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        string userName = userInfo.getName();
        
        res.setBody(' {"attributes":{"type":"WorkflowRule","url":"/services/data/v34.0/tooling/sobjects/WorkflowRule/01Q280000007mpmEAA"},"Id":"01Q280000007mpmEAA","Name":"testWFRule1","TableEnumOrId":"Account","NamespacePrefix":"ChangeGuru","CreatedDate":"2016-07-20T06:31:14.000+0000","CreatedById":"005280000022DtkAAE","LastModifiedDate":"2016-11-15T11:04:27.000+0000","LastModifiedById":"005280000022DtkAAE","Metadata":{"actions":[],"booleanFilter":null,"criteriaItems":[{"field":"Account.Name","operation":"contains","value":"a","valueField":null}],"formula":null,"urls":null,"workflowTimeTriggers":[],"active":false,"description":null,"triggerType":"onCreateOrTriggeringUpdate"},"FullName":"Account.ChangeGuru__testWFRule1"}');
        res.setStatusCode(200);
        return res;
    }
}