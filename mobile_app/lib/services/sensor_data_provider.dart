import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import '../models/data_model/sensors_data.dart';
import '../models/data_model/device.dart';
import 'package:http/http.dart' as http;
import 'global_data.dart';


enum SensorDataStatus { GETTING_CONNECTED_DEVICES, HAVE_DEVICES }

class SensorDataProvider with ChangeNotifier {
  http.Client _httpClient = http.Client();
  late http.Request _httpRequest ;
  late http.StreamedResponse _response;
  List<StreamSubscription<String>> _subscription = [];
  SensorDataStatus sensorDataStatus = SensorDataStatus.GETTING_CONNECTED_DEVICES;
  List<Device> devices = [];
  List<List<SensorsData>> sensorsData = [];
  final dayDate = DateTime.now();

  SensorDataProvider() {
    getDevices();
  }

  Future<bool> getDevices() async {
    final response = await http.get(Uri.parse('$baseUrl/devices'), headers: {
      "Content-Type": "application/json",
      "Authorization": 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      logger.d(jsonData);
      for (var dataDevice in jsonData) {
        if(dataDevice is Map<String, dynamic>){
          final Device d = Device(dataDevice["deviceId"], dataDevice["babyName"]);
          devices.add(d);
          sensorsData.add([]);
          sseRequest(d.deviceId!);
        }
      }
      sensorDataStatus = SensorDataStatus.HAVE_DEVICES;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addDevice(Device device) async {
    print('try add device');
    final response = await http.post(
      Uri.parse('$baseUrl/device'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + token,
      },
      body: jsonEncode(device.toJson()),
    );
    if (response.statusCode == 200) {
      print('add device to list');
      devices.add(device);
      sensorsData.add([]);
      notifyListeners();
    } else {
      print ('error in add device');
    }
    return true;
  }

  sseRequest(int deviceId) async {
    _httpRequest = http.Request("GET", Uri.parse('${baseUrl}/device/$deviceId/subscription'));
    _httpRequest.headers["Accept"] = "text/event-stream";
    _httpRequest.headers["Cache-Control"] = "no-cache";
    try{
      _response = await _httpClient.send(_httpRequest);
      final subscription =  utf8.decoder.bind(_response.stream).listen((data) {
        onSensorsData(data, deviceId);
      });
      subscription.onError((err){
        print(err);
      });
       subscription.onDone(() {
        sseRequest(deviceId);
      });
       int deviceIndex = _checkSseExistence(deviceId);
       if( deviceIndex != -1){
         _subscription[deviceIndex].cancel();
         _subscription[deviceIndex] = subscription;
       }else{
         _subscription.add(subscription);
       }

    }catch(e){
      print("SensorDataProvider: $e");
    }
  }

  int  _checkSseExistence(int deviceId){
    int deviceIndex = devices.indexWhere((d) => d.deviceId == deviceId);
    if(deviceIndex != -1){
      try{
        final s = _subscription[deviceIndex];
        return deviceIndex;
      }on RangeError catch (e){
        return -1;
      }
    }

    return -1;
  }

  void onSensorsData(String data, int deviceId) {
    if(data != "data:") {
      int deviceIndex = devices.indexWhere((device) => device.deviceId == deviceId);
      if(deviceIndex != -1){
        try{
          final jsonData = jsonDecode(data);
          sensorsData[deviceIndex].add(SensorsData.fromJson(jsonData));
          notifyListeners();
        }catch(e){
          print("onSensorData json error");
        }
      }
    }
  }

  @override
  void dispose() {
    for(var s in _subscription){
      s.cancel();
    }
    super.dispose();
  }
}
