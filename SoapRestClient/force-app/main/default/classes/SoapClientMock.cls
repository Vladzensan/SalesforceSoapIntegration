@IsTest
global with sharing class SoapClientMock implements WebServiceMock {
    global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        
        SoapSensorApp.insertSensorEventsResponse_element response_x = new SoapSensorApp.insertSensorEventsResponse_element();
        response.put('response_x', response_x); 
   }
}