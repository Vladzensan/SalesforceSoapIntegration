public with sharing class SensorEventSoapClient {
    
    //SensorEventSoapClient.sendSoapRequest('sensorName', 'AV12200g00M3Xn5Ag3', new Decimal[]{1,2,2,3,4,5});
    
    public static void sendSoapRequest(String sensorName, String accountId, Decimal[] coords) {
        SensorEventsData sensorData = new SensorEventsData(accountId, sensorName, coords);

        SoapSensorApp.SoapSensorService service = new SoapSensorApp.SoapSensorService();
        service.endpoint_x = 'callout:SoapService/services/Soap/class/SoapSensorService';
        service.SessionHeader = new SoapSensorApp.SessionHeader_element();
        service.SessionHeader.sessionId = '{!$Credential.OAuthToken}';

        service.insertSensorEvents(JSON.serialize(sensorData));

    }
}