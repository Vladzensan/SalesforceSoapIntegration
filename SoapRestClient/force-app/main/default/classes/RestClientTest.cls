@IsTest 
public with sharing class RestClientTest {
    
    private static final String SENSOR_ID = 'sensId';
    private static final Integer X = 10;
    private static final Integer Y = 25;
    private static final Integer Z = 30;
    private static final Integer HTTP_OK = 200;
    
    @IsTest public static void testStandardRestRequest() {
        Test.setMock(HttpCalloutMock.class, new RestClientMock()); 
        HttpResponse response = SensorEventRestClient.sendStandardRestRequest(new SensorEvent(SENSOR_ID, X, Y, Z));
        System.assertEquals(HTTP_OK, response.getStatusCode());
    }
}