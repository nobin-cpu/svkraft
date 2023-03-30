import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signup_otp.dart';

import '../../../constant/api_link.dart';

Future<RegisterResponse> register(
    String phone, username, email, password) async {
  var deviceId = await OneSignal.shared.getDeviceState();
  var userId = deviceId!.userId;
  Map data = {
    'city_name': email,
    'phone': phone,
    'password': password,
    'username': username,
    'device_token': userId,
    // 'id':city_id
  };

  String body = json.encode(data);
  var url = Appurl.baseURL + 'api/register';
  http.Response response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  var res = jsonDecode(response.body);
  if (res['success'] == true) {
    Get.offAll(() => OtpToHomeScreen(
          number: phone,
        ));
    print(phone);
    // final token = (jsonDecode(response.body) as JSON)['data']['token'];
    // final userId = (jsonDecode(response.body) as JSON)['data']['user']['id'];
    print("resgister::::${res['phone']}");

    var tokens = res['token'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('auth-token', res['token']);
    await prefs.setInt('user-id', res['id']);
    print("Check REsgister");

    // return response.statusCode.toString();
    return RegisterResponse(token: tokens, errorMessage: null);
  } else {
    //print('failed');
    return RegisterResponse(
      token: null,
      errorMessage:
          (jsonDecode(response.body) as Map<String, dynamic>)['message']
              .toString(),
    );
  }
}

class RegisterResponse {
  final String? token;
  final String? errorMessage;

  RegisterResponse({required this.token, required this.errorMessage});
}
