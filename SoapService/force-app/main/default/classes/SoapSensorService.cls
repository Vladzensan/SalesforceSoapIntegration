global with sharing class SoapSensorService {
    webservice static void insertSensorEvents(String sensorsData) {
        SensorEventsData sensorData = (SensorEventsData) JSON.deserialize(sensorsData, SensorEventsData.class);
        
    }
}
