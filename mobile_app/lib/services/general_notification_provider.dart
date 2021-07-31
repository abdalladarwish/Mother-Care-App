import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'notification_service.dart';
import 'sensor_data_provider.dart';
import 'global_data.dart';

class GeneralNotificationProvider with ChangeNotifier {
  http.Client _httpClient = http.Client();
  late http.Request _httpRequest ;
  http.StreamedResponse? _response;
  StreamSubscription<String>? _subscription;
  NotificationService _notificationService = NotificationService();
  bool isDeviceConnected = false;
  late SensorDataProvider _sensorDataProvider;
  GeneralNotificationProvider(SensorDataProvider sensorDataProvider) {
    _httpRequest = http.Request("GET", Uri.parse('${baseUrl}/notifier/${username}'));
    _httpRequest.headers["Accept"] = "text/event-stream";
    _httpRequest.headers["Cache-Control"] = "no-cache";
    _sendRequest();
    _sensorDataProvider = sensorDataProvider;
  }

  _sendRequest() async {
    _subscription?.cancel();
    try{
      _response = await _httpClient.send(_httpRequest);
      _subscription =  utf8.decoder.bind(_response!.stream).listen((data) {
        _onDate(data);
      });
      _subscription?.onError((err){
        print(err);
      });
      _subscription?.onDone(() {
        _sendRequest();
      });
    }catch(e){
      print("GeneralNotificationProvider: $e");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  _onDate(String data){
    switch(data){
      case "connected":
        _notificationService.showNotification(title:"Device Connected", body: "You can check baby signals");
        isDeviceConnected = true;
        // TODO device id
        _sensorDataProvider.sseRequest(_sensorDataProvider.devices.last.deviceId!);
        notifyListeners();
        break;
      case "disconnected":
        _notificationService.showNotification(title: "De  vice Disconnected", body: "");
        isDeviceConnected = false;
        notifyListeners();
        break;
      default:
        print(data);
    }
  }
}
