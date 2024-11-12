@isTest
global with sharing class MockHttpResponseGenerator5 implements HttpCalloutMock {
    ///////// DELETE /////////////
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('test', 'test');
        // Create a fake response
        HttpResponse res = new HttpResponse();
        return res;
    }
}