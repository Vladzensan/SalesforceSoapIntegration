public class TestDataFactory {
    public static Sensor__c generateSensor(String sensorName) {
        Account a = generateAccount('accName');

        Sensor__c sensor = new Sensor__c(Account_Id__c=a.id, Name=sensorName);
        insert sensor;

        return sensor;
    }

    public static Account generateAccount(String accName) {
        Account a = new Account(Name=accName);
        insert a;

        return a;
    }

    public static List<Sensor_Event__c> generateEventChain(Id sensorId, Integer chainLength) {
        List<Sensor_Event__c> events = new List<Sensor_Event__c>();

        for(Integer i = 0; i < chainLength; i++) {
            Sensor_Event__c event = new Sensor_Event__c(Sensor__c = sensorId, X__c = 1.0, Y__c = 1.0, Z__c = 1.0);
            events.add(event);
        }

        insert events;

        for(Integer i = 0; i < chainLength; i++) {
            events[i].Previous_Event__c = (i != 0)? events[i - 1].Id : null;
            events[i].Next_Event__c = (i != events.size() -1)? events[i + 1].Id: null;
        }

        update events;

        return events;
    }
}
