@RestResource(urlMapping = '/addEvents')
global class RestSensorService {

    @HttpPost
    global static void insertSensorEvents() {
        SensorEventsData data = (SensorEventsData) JSON.deserialize(RestContext.request.requestBody.toString(), SensorEventsData.class);
        SensorEventHelper.insertNewEvents(data);
    }
}
