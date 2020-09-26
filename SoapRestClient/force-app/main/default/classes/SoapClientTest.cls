@IsTest
public with sharing class SoapClientTest {
    
    private static String ACCOUNT_ID = 'accId';
    private static String SENSOR_NAME = 'sensorName';
    private static Decimal[] COORDS = new Decimal[]{1,3,3,7,4,8};

    @IsTest
    public static void testInserEventsRequest() {
        try {
            Test.setMock(WebServiceMock.class, new SoapClientMock()); 

            SensorEventSoapClient.sendSoapRequest(SENSOR_NAME, ACCOUNT_ID, COORDS);
        } catch(System.Exception e) {
            System.assert(false, e.getMessage());
        }
    }  
}