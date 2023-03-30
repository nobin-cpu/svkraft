import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';

import '../controllar/signin_controllar.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninController _signinController = Get.put(SigninController());
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("YES"),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                    TextButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: SafeArea(
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
                      // Icon(
                      //   Icons.location_on_outlined,
                      //   size: 30,
                      //   color: Colors.black,
                      // ),
                      // Text(
                      //   "XYZ",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        "Let’s Sign You In".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome back, you’ve been missed!".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      //fffffffffffffffffffffffffff
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone Number".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: size.height / 12,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromARGB(255, 0, 0,
                                          0), //                   <--- border color
                                      width: .5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        // InternationalPhoneNumberInput(
                                        //   keyboardType: TextInputType.text,
                                        //   onInputChanged: (PhoneNumber number) {
                                        //     _signinController.phone =
                                        //         number.phoneNumber;
                                        //     // print(number.phoneNumber);
                                        //     // setState(() {
                                        //     //   phone = number.phoneNumber;
                                        //     // });
                                        //   },
                                        //   onInputValidated: (bool value) {
                                        //     print(value);
                                        //   },
                                        //   selectorConfig: const SelectorConfig(
                                        //     selectorType:
                                        //         PhoneInputSelectorType.BOTTOM_SHEET,
                                        //   ),
                                        //   ignoreBlank: false,
                                        //   autoValidateMode: AutovalidateMode.disabled,
                                        //   selectorTextStyle:
                                        //       const TextStyle(color: Colors.black),
                                        //   initialValue: _signinController.number,
                                        //   textFieldController: phoneNumberController,
                                        //   formatInput: false,

                                        //   // validator: (v) => v!.isEmpty
                                        //   //     ? "Field Can't be Empty"
                                        //   //     : null,
                                        //   validator: (value) {
                                        //     if (value == null || value.trim().isEmpty) {
                                        //       return 'This field is required'.tr;
                                        //     }
                                        //     if (value.trim().length < 9) {
                                        //       return 'Number must be at least 11 characters in length'
                                        //           .tr;
                                        //     }
                                        //     // Return null if the entered username is valid
                                        //     return null;
                                        //   },
                                        //   inputBorder: InputBorder.none,
                                        //   onSaved: (PhoneNumber number) {
                                        //     print('On Saved: $number');
                                        //   },
                                        // ),

                                        TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone Number".tr,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        prefix: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text("+964"),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Image.asset(
                                            'images/iraq.webp',
                                            width: 30,
                                            height: 10,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //  Container(
                                        //   child: Row(
                                        //     children: [
                                        //       Container(
                                        //         width: 37,
                                        //         height: MediaQuery.of(context)
                                        //                 .size
                                        //                 .height *
                                        //             .04,
                                        //         child: Image.asset(
                                        //           "images/iraq.webp",
                                        //           fit: BoxFit.cover,
                                        //         ),
                                        //       ),
                                        //       SizedBox(
                                        //         width: 10,
                                        //       ),
                                        //       Text("+964"),
                                        //     ],
                                        //   ),
                                        // ),
                                      ),
                                      controller: phoneNumberController,

                                      // validator: (value) {
                                      //   if (value == null || value.trim().isEmpty) {
                                      //     return 'This field is required'.tr;
                                      //   }
                                      //   if (value.trim().length < 9) {
                                      //     return 'Number must be at least 11 characters in length'
                                      //         .tr;
                                      //   }
                                      //   // Return null if the entered username is valid
                                      //   return null;
                                      // },

                                      //onChanged: (value) => _userName = value,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "password".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Container(
                                  child: TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            width: .5,
                                            color: Color.fromARGB(
                                                255, 0, 0, 0)), //<-- SEE HERE
                                      ),
                                      hintText: '* * * * * *',
                                      hintStyle: TextStyle(color: Colors.black),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                          print(_isObscure);
                                        },
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    obscureText: _isObscure,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required'.tr;
                                      }
                                      if (value.trim().length < 8) {
                                        return 'Password must be at least 8 characters in length';
                                      }
                                      // Return null if the entered password is valid
                                      return null;
                                    },
                                    //onChanged: (value) => _userName = value,
                                  ),
                                ),
                              ),

                              /// Password
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .1,
                      ),

                      !_isloading
                          ? BottomButtonColumn(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isloading = true;
                                  });
                                  var loginResponse =
                                      await _signinController.login(
                                    "+964" + phoneNumberController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                  if (loginResponse.token != null) {
                                    setState(() {
                                      _isloading = false;
                                    });
                                    Get.offAll(() => const HomeScreen());
                                  } else if (loginResponse.errorMessage !=
                                      null) {
                                    setState(() {
                                      _isloading = false;
                                    });
                                    Get.snackbar(
                                      "Error",
                                      loginResponse.errorMessage!,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black38,
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              },
                              buttonText: "SIGN IN".tr,
                              buttonIcon: Icons.login_outlined,
                            )
                          : const Center(
                              child: SpinKitThreeBounce(
                              color: Colors.black,
                              size: 24,
                            )),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Sign up".tr,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed('/signup');
                              // Get.to(OtpToHomeScreen());
                            },
                          ),
                        ],
                      ),
                      InkWell(
                        child: Center(
                          child: Text(
                            "Forget Password?".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Get.toNamed('/forgatepass');
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
