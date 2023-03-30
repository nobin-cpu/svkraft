import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constant/api_link.dart';

class Cartcontrollerofnav extends GetxController {
  var count = 0.obs;
  @override
  void onInit() {
    carts();
    super.onInit();
  }

  Future carts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(Appurl.cartitem), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData10 = jsonDecode(response.body)['count'];
      count.value = userData10;
      return userData10;
    } else {
      print("post have no Data${response.body}");
    }
  }
}
