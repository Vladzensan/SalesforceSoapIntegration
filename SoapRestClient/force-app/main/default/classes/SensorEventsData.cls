public class SensorEventsData {
    public String sensorId {get; set;}
    public String accountId {get; set;}
    public Decimal[] line {get; set;}
    
    public SensorEventsData(String accountId, String sensorId, Decimal[] line) {
        this.accountId = accountId;
        this.sensorId = sensorId;
        this.line = line;
    }
}