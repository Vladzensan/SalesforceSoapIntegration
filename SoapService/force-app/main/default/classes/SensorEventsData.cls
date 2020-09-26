public class SensorEventsData {
    public String accountId {get; set;}
    public String sensorId {get; set;}
    public List<Decimal> eventsCoords {get; set;}     
    
    public SensorEventsData(String accountId, String sensorId, List<Decimal> eventsCoords) {
        this.accountId = accountId;
        this.sensorId = sensorId;
        this.eventsCoords = eventsCoords;
    }
}
