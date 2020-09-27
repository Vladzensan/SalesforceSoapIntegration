@isTest
public with sharing class SoapSensorServiceTest {
    @isTest
    static void testInsertEvents() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.generateSensor('testSensor');
        SensorEventsData data = new SensorEventsData(sensor.Account_Id__c, 'testSensor', new Decimal[]{1.0, 3.0, 4.0});
        SoapSensorService.insertSensorEvents(JSON.serialize(data));
        List<Sensor_Event__c> events = [SELECT Id FROM Sensor_Event__c WHERE Sensor__c= :sensor.Id];

        System.assertEquals(1, events.size());
        Test.stopTest();
    }   
}