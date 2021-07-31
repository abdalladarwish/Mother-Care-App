import 'package:logger/logger.dart';
final baseUrl = 'http://192.168.43.112:8080';

String token = '';

String _loggedUsername = '';

set username(String username){
  _loggedUsername = username;
}

String get username => _loggedUsername;

var logger = Logger();
