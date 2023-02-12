import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/style.dart';
import 'package:sv_craft/common/bottom_button.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OtpSendScreen extends StatefulWidget {
  OtpSendScreen({Key? key}) : super(key: key);

  @override
  State<OtpSendScreen> createState() => _OtpSendScreenState();
}

class _OtpSendScreenState extends State<OtpSendScreen> {
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
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  Text(
                    "XYZ",
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

                  //OTP input
                  //     Form(
                  //   key: _loginFormKey,
                  //   child: OTPTextField(
                  //     length: 4,
                  //     width: MediaQuery.of(context).size.width,
                  //     fieldWidth: 80,
                  //     style: TextStyle(
                  //         fontSize: 17
                  //     ),
                  //     textFieldAlignment: MainAxisAlignment.spaceAround,
                  //     fieldStyle: FieldStyle.underline,
                  //     onCompleted: (pin) {
                  //       print("Completed: " + pin);
                  //     },
                  //   ),
                  // ),
                  OTPTextField(
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 70,
                    style: TextStyle(fontSize: 30),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),
                  SizedBox(
                    height: size.height * .08,
                  ),
                  BottomButtonColumn(
                    onTap: () {
                      Get.toNamed("/bottombar");
                    },
                    buttonText: "CONTINUE",
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
                          //       builder: (context) => SignupScreen()),
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
