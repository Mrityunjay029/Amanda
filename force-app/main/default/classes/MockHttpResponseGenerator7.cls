@isTest
global class MockHttpResponseGenerator7 implements HttpCalloutMock {
    ///////////// DELETE /////////////
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setbody('{"attributes":{"type":"Flow","url":"/services/data/v34.0/tooling/sobjects/Flow/30128000000UXfWAAW"},"Id":"30128000000UXfWAAW","DefinitionId":"30028000000TgoPAAS","MasterLabel":"New Flow","VersionNumber":1,"Status":"Active","Description":"New Flow","ProcessType":"Flow","CreatedDate":"2016-11-17T10:58:12.000+0000","CreatedById":"005280000022DtkAAE","LastModifiedDate":"2017-02-14T05:16:21.000+0000","LastModifiedById":"005280000022DtkAAE","Metadata":{"actionCalls":[],"apexPluginCalls":[],"assignments":[],"choices":[],"constants":[],"decisions":[],"description":"New Flow","dynamicChoiceSets":[],"formulas":[],"interviewLabel":null,"label":"New Flow","loops":[],"processMetadataValues":[],"processType":"Flow","recordCreates":[{"assignRecordIdToReference":null,"connector":null,"description":null,"faultConnector":null,"inputAssignments":[{"field":"AccountNumber","processMetadataValues":[],"value":{"booleanValue":null,"dateTimeValue":null,"dateValue":null,"elementReference":null,"numberValue":null,"stringValue":"1234"}}],"inputReference":null,"label":"Record Create","locationX":10,"locationY":10,"name":"RecordCreate","object":"Account","processMetadataValues":[]}],"recordDeletes":[],"recordLookups":[],"recordUpdates":[],"screens":[],"startElementReference":"RecordCreate","steps":[],"subflows":[],"textTemplates":[],"urls":null,"variables":[],"waits":[]},"FullName":"NewFlow-1"}');
        return res;
    }
}