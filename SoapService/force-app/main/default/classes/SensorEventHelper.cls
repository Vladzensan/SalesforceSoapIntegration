public with sharing class SensorEventHelper {
    private static final Integer DIMENSIONS_NUM = 3;
    private static final String COORDS_ERROR = 'Wrong number of coordinates in list';
    private static final String ACCOUNT_ERROR = 'Account not present';
    
    public static void insertNewEvents(SensorEventsData sensorsData) {
        checkDataValidity(sensorsData);
        
        Sensor__c relatedSensor = getOrAddSensor(sensorsData.sensorId, sensorsData.accountId);
        List<Sensor_Event__c> events = [SELECT Id FROM Sensor_Event__c WHERE Next_Event__c = null LIMIT 1];
        Sensor_Event__c lastEvent = null;

        if(events.size() > 0) { 
            lastEvent = events[0];
        }
        
        buildEventChain(sensorsData.eventsCoords, relatedSensor, lastEvent);
    }

    private static Sensor__c getOrAddSensor(String sensorName, String accountId) {
        List<Sensor__c> sensorList = [SELECT Id FROM Sensor__c WHERE (Name = :sensorName) AND (Account_Id__c = :accountId) LIMIT 1];

        Sensor__c relatedSensor;

        if(sensorList.size() == 0) {
            checkAccountPresent(accountId);

            relatedSensor = new Sensor__c(Name = sensorName, Account_Id__c = accountId);
            insert relatedSensor;
        } else {
            relatedSensor = sensorList[0];
        }

        return relatedSensor;
    }

    private static List<Sensor_Event__c> buildEventChain(List<Decimal> coords, Sensor__c relatedSensor,  Sensor_Event__c lastEvent) {
        List<Sensor_Event__c> eventChain = getEventList(coords, relatedSensor);
        insert eventChain; // for obtaining Ids and further chain building


        for(Integer i = 0; i < eventChain.size(); i ++) {
            eventChain[i].Previous_Event__c = (i != 0)? eventChain[i - 1].Id : null;
            eventChain[i].Next_Event__c = (i != eventChain.size() -1)? eventChain[i + 1].Id: null;
        }
    
        if(lastEvent != null) {
            lastEvent.Next_Event__c = eventChain[0].Id;
            eventChain[0].Previous_Event__c = lastEvent.Id;

            update lastEvent;
        }

        update eventChain;

        return eventChain;
    }

    private static List<Sensor_Event__c> getEventList(List<Decimal> coords, Sensor__c relatedSensor) {
        List<Sensor_Event__c> eventList = new List<Sensor_Event__c>();

        for(Integer i = 0 ; i < coords.size(); i += DIMENSIONS_NUM) {
            Sensor_Event__c event = new Sensor_event__c(
                X__c = coords[i],
                Y__c = coords[i + 1],
                Z__c = coords[i + 2],
                Sensor__c = relatedSensor.Id
                );
                eventList.add(event);
        }

        return eventList;
    }

    private static void checkAccountPresent(String accountId) {
        List<Account> accs = [SELECT Id FROM Account WHERE Id= :accountId];
        if(accs.size() == 0) {
            throw new IllegalArgumentException(ACCOUNT_ERROR + ': ' + accountId);
        }
    }

    private static void checkDataValidity(SensorEventsData sensorsData) {
        if(sensorsData.eventsCoords.size() == 0 || Math.mod(sensorsData.eventsCoords.size(), DIMENSIONS_NUM) != 0) {
            throw new IllegalArgumentException(COORDS_ERROR);
        }
    }
}
