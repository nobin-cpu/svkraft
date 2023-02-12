import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:http/http.dart' as http;

class OtpToHomeScreen extends StatefulWidget {
  final String number;
  OtpToHomeScreen({Key? key, required this.number}) : super(key: key);

  @override
  State<OtpToHomeScreen> createState() => _OtpToHomeScreenState();
}

class _OtpToHomeScreenState extends State<OtpToHomeScreen> {
  OtpFieldController otpcontrol = OtpFieldController();
  var pin = "";
  Future withdraw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      // 'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.otpverify),
    );
    request.fields.addAll({
      'otp': pin,
      'phone': widget.number,
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print("massge sent");
          saveprefs(data["token"]);
          // chat.clear();
          Get.to(HomeScreen());
          setState(() {});
        } else {
          print("Fail! ");
          print(response.body.toString());
          // Fluttertoast.showToast(
          //     msg: "Error Occured",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          return response.body;
        }
      });
    });
  }

  saveprefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', token);
  }

//location
  Future? sms;
  Future? sendsmss;

  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _phoneNumberController = TextEditingController();
    var phone;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  Text(
                    widget.number,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const Text(
                    "OTP Authentication",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "An authentication code has been sent to\n(+00) 999 999 999",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  OTPTextField(
                    controller: otpcontrol,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 25,
                    style: TextStyle(fontSize: 30),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (verificationCode) {
                      setState(() {
                        pin = verificationCode;
                      });
                    },
                  ),
                  SizedBox(
                    height: size.height * .08,
                  ),
                  BottomButtonColumn(
                    onTap: () {
                      withdraw();
                      print(otpcontrol.toString());
                      print(widget.number);
                      // Get.toNamed("/bottombar");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomeScreen()),
                      // );
                    },
                    buttonText: "CONTINUE1",
                    buttonIcon: Icons.arrow_right_alt_sharp,
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't get OTP?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Resend",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          // );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
