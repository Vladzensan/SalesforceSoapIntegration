@isTest
public with sharing class SensorEventHelperTest {
    @isTest 
    static void testWrongCoords() {
        Boolean isCorrect = false;
        Test.startTest();
        Account a = TestDataFactory.generateAccount('accName');
        try {
            SensorEventHelper.insertNewEvents(new SensorEventsData(a.Id, 'sensorName', new Decimal[]{1.0, 3.0}));
        } catch (IllegalArgumentException e) {
            isCorrect = true;
        }

        System.assert(isCorrect);

        Test.stopTest();
    }

    @isTest 
    static void testExistentSensor() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.generateSensor('testSensor');
        SensorEventHelper.insertNewEvents(new SensorEventsData(sensor.Account_Id__c, 'testSensor', new Decimal[]{1.0, 3.0, 4.0}));
        List<Sensor_Event__c> events = [SELECT Id FROM Sensor_Event__c WHERE Sensor__c= :sensor.Id];

        System.assertEquals(1, events.size());
        Test.stopTest();
    }

    @isTest
    static void testNoSuchAccount() {
        Boolean isCorrect = false;
        try {
            SensorEventHelper.insertNewEvents(new SensorEventsData('noSuchAccount', 'sensorName', new Decimal[]{1.0, 3.0}));
        } catch (IllegalArgumentException e) {
            isCorrect = true;
        }

        System.assert(isCorrect);
    }

    @isTest
    static void testInsertMultipleEvents() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.generateSensor('testSensor');
        Decimal[] coords = new Decimal[]{1.0, 3.0, 4.0, 5.0, 6.0, 7.0};
        SensorEventHelper.insertNewEvents(new SensorEventsData(sensor.Account_Id__c, 'testSensor', coords));
        List<Sensor_Event__c> events = [SELECT Id FROM Sensor_Event__c WHERE Sensor__c= :sensor.Id];

        System.assertEquals(coords.size() / 3, events.size());
        Test.stopTest();
    }

    @isTest 
    static void testExistentEventChain() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.generateSensor('testSensor');
        List<Sensor_Event__c> chain = TestDataFactory.generateEventChain(sensor.Id, 5);

        Decimal[] coords = new Decimal[]{1.0, 2.0, 3.0};
        SensorEventHelper.insertNewEvents(new SensorEventsData(sensor.Account_Id__c, 'testSensor', coords));

        List<Sensor_Event__c> updatedChain = [SELECT X__c, Y__c, Z__c FROM sensor_Event__c WHERE Previous_Event__c = :chain[4].Id];

        System.assertEquals(1, updatedChain.size());
        System.assertEquals(1.0, updatedChain[0].X__c);
        System.assertEquals(2.0, updatedChain[0].Y__c);
        System.assertEquals(3.0, updatedChain[0].Z__c);

        Test.stopTest();

    }
}
