import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/data_model/user.dart';
import 'package:http/http.dart' as http;
import 'global_data.dart';

enum SignUpStatus { REGISTERING_BASIC_USER_DETAILS, REGISTERING_BABY_DETAILS, SIGNING_UP }

class SignUpProvider with ChangeNotifier {
  User _user = User();
  bool userNameValidated = false;
  SignUpStatus signUpStatus = SignUpStatus.REGISTERING_BABY_DETAILS;
  final basicDetailsFromKey = GlobalKey<FormState>();

  User get user => _user;

  Future<bool> signUp() async {
    signUpStatus = SignUpStatus.SIGNING_UP;
    notifyListeners();
    // send data to server
    final response = await http.post(
      Uri.parse('${baseUrl}/new/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson())
    );
    if(response.statusCode != 200){
      userNameValidated = false;
      basicDetailsFromKey.currentState?.validate();
      signUpStatus = SignUpStatus.REGISTERING_BASIC_USER_DETAILS;
      notifyListeners();
      return false;
    }else {
      return true;
    }
  }
}
