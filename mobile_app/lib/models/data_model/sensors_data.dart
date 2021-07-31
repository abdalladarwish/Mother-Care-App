class SensorsData{
  Map<String, SensorRead> data= {};
  late String positionRead;
  SensorsData.fromJson(Map<String, dynamic> jsonData){
    final tempRead = TempRead.fromJson(jsonData['tempRead']);
    final spo2Read = SPO2Read.fromJson(jsonData['spo2Read']);
    final heartRateRead = HeartRateRead.fromJson(jsonData['heartRateRead']);
    data['tempRead'] = tempRead;
    data['spo2Read'] = spo2Read;
    data['heartRateRead'] = heartRateRead;
    positionRead = jsonData['positionRead'];
  }
}
abstract class SensorRead {
  late DateTime time;
  late double value;
}

class TempRead implements SensorRead{
  TempRead.fromJson(Map<String, dynamic> jsonData){
    value = jsonData['value'];
    time = DateTime.parse(jsonData['time']);
  }

  late DateTime time;
  late double value;
}

class SPO2Read implements SensorRead{
  late double value;
  late DateTime time;
  SPO2Read.fromJson(Map<String, dynamic> jsonData){
    value = jsonData['value'];
    time = DateTime.parse(jsonData['time']);
  }
}

class HeartRateRead implements SensorRead{
  late double value;
  late DateTime time;
  HeartRateRead.fromJson(Map<String, dynamic> jsonData){
    value = jsonData['value'];
    time = DateTime.parse(jsonData['time']);
  }
}

class PositionRead implements SensorRead{
  late double value;
  late DateTime time;
  PositionRead.fromJson(Map<String, dynamic> jsonData){
    value = jsonData['value'];
    time = DateTime.parse(jsonData['time']);
  }
}



