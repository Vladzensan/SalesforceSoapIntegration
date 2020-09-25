public class SensorEventsData {
    public Id accountId {get; set;}
    public String sensorId {get; set;}
    public List<Decimal> eventsCoords {get; set;}     
    
    public SensorEventsData(Id accountId, Id sensorId, List<Decimal> eventsCoords) {
        this.accountId = accountId;
        this.sensorId = sensorId;
        this.eventsCoords = eventsCoords;
    }
}
