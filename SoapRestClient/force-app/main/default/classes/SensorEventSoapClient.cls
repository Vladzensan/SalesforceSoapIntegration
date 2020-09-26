public with sharing class SensorEventSoapClient {
    
    public static void sendSoapRequest(String sensorName, String accountId, Decimal[] coords) {
        SensorEventsData sensorData = new SensorEventsData(accountId, sensorName, coords);

        SoapSensorApp.SoapSensorService service = new SoapSensorApp.SoapSensorService();
        //configs go here
        service.insertSensorEvents(JSON.serialize(sensorData));

    }
}