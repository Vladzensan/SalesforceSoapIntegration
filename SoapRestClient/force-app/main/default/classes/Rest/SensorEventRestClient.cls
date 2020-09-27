public with sharing class SensorEventRestClient {

    public static HttpResponse sendStandardRestRequest(SensorEvent event) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();  
        request.setEndpoint('callout:SoapService/services/data/v49.0/sobjects/Sensor_Event__c');  
        request.setMethod('POST');    
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');

        request.setBody(JSON.serialize(event).replaceAll('End', '__c')); 
        
        HttpResponse response = http.send(request);
        return response;
    }

    public static HttpResponse sendCustomRestRequest(SensorEventsData data) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();  

            request.setEndpoint('callout:SoapService/services/apexrest/addEvents');  
            request.setMethod('POST');    
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setBody(JSON.serialize(data));    
    
            HttpResponse response = http.send(request);

            return response;
        
    }
}
