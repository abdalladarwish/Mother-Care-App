import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'global_data.dart';
import 'global_data.dart' as global;

enum LoginStatus { ENTERING_INFO, LOGGING_IN }

class LoginProvider with ChangeNotifier {
  LoginStatus loginStatus = LoginStatus.ENTERING_INFO;
  final loginFromKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool passwordInCorrect = false;
  bool serverError = false;
  Future<bool> login() async {
    loginStatus = LoginStatus.LOGGING_IN;
    notifyListeners();
    var auth = "mothercare-webapp:6969";
    var bytes = utf8.encode(auth);
    var authBase64Str = base64.encode(bytes);
    final response = await http.post(
      Uri.parse('${baseUrl}/oauth/token'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": 'Basic ' + authBase64Str,
      },
      body: {
        "username": username,
        "password": password,
        "grant_type": "password",
        "scope": "read write",
      },
    );
    var responseJson = jsonDecode(response.body);
    if(responseJson["access_token"] != null){
      token = responseJson["access_token"];
      global.username = username;
      return true;
    } else{
      passwordInCorrect = true;
      loginFromKey.currentState?.validate();
      loginStatus = LoginStatus.ENTERING_INFO;
      notifyListeners();
      return false;
    }
  }
}
