import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var token = getToken();
getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth-token');
  print(token);
  return token;
}

class ServicesClass {
  static Map<String, String> headersForAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
