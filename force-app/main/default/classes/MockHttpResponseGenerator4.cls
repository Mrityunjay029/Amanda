@isTest
////////////////////DELETE/////////////////////////////////////
global with sharing class MockHttpResponseGenerator4 implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('test', 'test');
        // Create a fake response
        HttpResponse res = new HttpResponse();
        return res;
    }
}