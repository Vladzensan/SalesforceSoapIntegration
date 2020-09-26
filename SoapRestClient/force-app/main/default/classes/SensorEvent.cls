public with sharing class SensorEvent {
    private String SensorEnd {get;set;}
    private Decimal xEnd {get;set;}
    private Decimal yEnd {get;set;}
    private Decimal zEnd {get;set;}
    
    public SensorEvent(String sensorId, Decimal x, Decimal y, Decimal z) {
        this.SensorEnd = sensorId;
        this.xEnd = x;
        this.yEnd = y;
        this.zEnd = z;
    }
}
