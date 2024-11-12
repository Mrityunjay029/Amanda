@isTest
global class MockHttpResponseGenerator8 implements HttpCalloutMock {
    /////////// DELETE ////////////////
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        return res;
    }
}