global with sharing class SoapSensorService {
    webservice static void insertSensorEvents(String sensorsData) {
        SensorEventsData sensorEventsData = (SensorEventsData) JSON.deserialize(sensorsData, SensorEventsData.class);
        SensorEventHelper.insertNewEvents(sensorEventsData);
        
    }
}
