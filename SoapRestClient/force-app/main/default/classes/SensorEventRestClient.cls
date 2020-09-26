public with sharing class SensorEventRestClient {

    public static HttpResponse sendStandardRestRequest(SensorEvent event) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();  
        request.setEndpoint('https://cunning-koala-cajz4h-dev-ed.lightning.force.com/services/data/v49.0/sobjects/Sensor_Event__c');  
        request.setMethod('POST');    
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');

        request.setBody(JSON.serialize(event).replaceAll('End', '__c')); 
        
        HttpResponse response = http.send(request);
        return response;
    }
}
