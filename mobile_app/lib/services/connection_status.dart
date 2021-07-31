import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class ConnectionStatus extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool isConnected = false;
  bool isConnectedFirstTime = false;
  bool connecting = true;

  ConnectionStatus() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      connecting = false;
      return _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isConnected = true;
        isConnectedFirstTime = true;
        notifyListeners();
        break;
      default:
        isConnected = false;
        notifyListeners();
        break;
    }
  }

  void refresh() {
    isConnected = false;
    isConnectedFirstTime = false;
    connecting = true;
    initConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }
}
