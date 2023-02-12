import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signup_otp.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../controllar/signup_controllar.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var location, location2;
  var loc, c_name;
  var val, val2;
  List shots = [];
  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');
  var phone;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var otpUser;
  bool _isloading = false;
  bool _poploading = false;
  bool _ischecked = true;
  bool _isbuttonactive = true;
  bool _isObscure = true;

  final _codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future loginUser(String phone, BuildContext context) async {
    /* FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await register(
          phone.trim(),
          _userNameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (Exception exception) {
        Get.snackbar("Resgister Error", exception.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Container(
                color: Colors.white,
                child: AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text("Code Sent to\n $phone"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      !_poploading
                          ? ElevatedButton(
                              child: const Text("Confirm"),
                              // textColor: Colors.black,
                              // color: Colors.yellow,
                              onPressed: () async {
                                // setState(() {
                                //   _poploading = true;
                                // });
                                // String comingSms = (await AltSmsAutofill().listenForSms)!;
                                // String aStr =
                                //     comingSms.replaceAll(new RegExp(r'[^0-9]'), '');
                                // String otp = aStr.substring(0, 6);

                                // final code = otp;
                                // print(comingSms);

                                final code = _codeController.text.trim();
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: code);

                                UserCredential result = await _auth
                                    .signInWithCredential(credential);

                                if (result.user != null) {
                                  var registerResponse = await register(
                                    phone.trim(),
                                    _userNameController.text.trim(),
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                                  print("res${registerResponse.token}");

                                  if (registerResponse.token != null) {
                                    // setState(() {
                                    //   _poploading = false;
                                    // });

                                    Get.offAll(HomeScreen());
                                  } else if (registerResponse.errorMessage !=
                                      null) {
                                    Navigator.of(context).pop();
                                    Get.snackbar(
                                      "Error",
                                      registerResponse.errorMessage!,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black38,
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              },
                            )
                          : ShimmerEffect.gridviewShimerLoader(),
                    ],
                  ),
                  // actions: <Widget>[

                  // ],
                ),
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Time Out');
      },
    );*/
    var registerResponse = await register(
      phone.trim(),
      _userNameController.text.trim(),
      location.toString(),
      // _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    print("res${registerResponse.token}");

    if (registerResponse.token != null) {
      // setState(() {
      //   _poploading = false;
      // });

      // Get.offAll(() => HomeScreen());
      // Get.offAll(() => OtpToHomeScreen(number: '',));
    } else if (registerResponse.errorMessage != null) {
      Navigator.of(context).pop();
      Get.snackbar(
        "Error",
        registerResponse.errorMessage!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black38,
        colorText: Colors.white,
      );
    }
  }

  Future locationsss() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(Appurl.locationinsignup),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["data"];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_experience;
  @override
  void initState() {
    viewall_experience = locationsss();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String countryname;
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "Getting Started".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account to continue!".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  //fffffffffffffffffffffffffff
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03),
                            child: Text(
                              "Phone Number".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      //  InternationalPhoneNumberInput(
                                      //   keyboardType: TextInputType.text,
                                      //   onInputChanged: (PhoneNumber number) {
                                      //     phone = number.phoneNumber;
                                      //     print(number.phoneNumber);
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
                                      //   initialValue: number,
                                      //   textFieldController: _phoneNumberController,
                                      //   formatInput: false,

                                      //   // validator: (v) => v!.isEmpty
                                      //   //     ? "Field Can't be Empty"
                                      //   //     : null,
                                      //   validator: (value) {
                                      //     if (value == null ||
                                      //         value.trim().isEmpty) {
                                      //       return 'This field is required'.tr;
                                      //     }
                                      //     if (value.trim().length < 9) {
                                      //       return 'Number must be at least 11 characters in length';
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
                                    controller: _phoneNumberController,
                                    decoration: InputDecoration(
                                      hintText: "Phone Number".tr,
                                      hintStyle: TextStyle(color: Colors.black),
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text("+964"),
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Image.asset(
                                          'images/iraq.webp',
                                          width: 30,
                                          height: 15,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),

                                    // validator: (value) {
                                    //   if (value == null ||
                                    //       value.trim().isEmpty) {
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
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03),
                            child: Text(
                              "Username".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: size.height / 12,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 20.0,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _userNameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: .5,
                                        color: Color.fromARGB(
                                            255, 0, 0, 0)), //<-- SEE HERE
                                  ),
                                  //labelText: 'Username',
                                  hintText: "Username".tr,
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: InputBorder.none,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required'.tr;
                                  }
                                  if (value.trim().length < 4) {
                                    return 'Username must be at least 4 characters in length';
                                  }
                                  // Return null if the entered username is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03),
                            child: Text(
                              "Address".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  border: Border.all()),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FutureBuilder(
                                    future: viewall_experience!,
                                    builder: (context, snapshot) {
                                      shots = (snapshot.data ?? []) as List;
                                      return snapshot.hasData
                                          ? shots != null
                                              ? Container(
                                                  child: new DropdownButton<
                                                      String>(
                                                    value: loc,
                                                    isExpanded:
                                                        true, //Add this property

                                                    hint: loc == null
                                                        ? Text(
                                                            "Enter address".tr,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey))
                                                        : Text(c_name!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .grey)),
                                                    items: shots
                                                        .map<
                                                            DropdownMenuItem<
                                                                String>>((value) =>
                                                            new DropdownMenuItem<
                                                                String>(
                                                              value: value["id"]
                                                                      .toString() +
                                                                  "_" +
                                                                  value['name'],
                                                              child: new Text(
                                                                value['name'],
                                                              ),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        loc = value;
                                                        val = loc!.split('_');
                                                        print(val[0] +
                                                            " NEw value");
                                                        print(val[1] +
                                                            " class value");
                                                        c_name = val[1];
                                                        location = val[1];
                                                        viewall_experience =
                                                            locationsss();
                                                      });
                                                      // print(_mySelection);
                                                      print(location);
                                                    },
                                                    underline:
                                                        DropdownButtonHideUnderline(
                                                            child: Container()),
                                                  ),
                                                )
                                              : SpinKitThreeInOut(
                                                  color: Colors.white,
                                                  size: 10,
                                                )
                                          : Container();
                                    }),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03),
                            child: Text(
                              "Password".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 20.0,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: .5,
                                        color: Color.fromARGB(
                                            255, 0, 0, 0)), //<-- SEE HERE
                                  ),
                                  hintText: '* * * * * *',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
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
                                  if (value == null || value.trim().isEmpty) {
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
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(_ischecked
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                onPressed: () {
                                  setState(() {
                                    _ischecked = !_ischecked;
                                    _isbuttonactive = !_isbuttonactive;
                                  });
                                  print(_ischecked);
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "By creating account, you are agree to our"
                                        .tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                  ),
                                  InkWell(
                                    child: Text("Term and Conditions".tr),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  !_isloading
                      ? Container(
                          alignment: Alignment.center,
                          width: size.width * 1,
                          height: size.height / 18,
                          decoration: BoxDecoration(
                            color: _isbuttonactive
                                ? Color.fromARGB(255, 0, 32, 106)
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: _isbuttonactive
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isloading = true;
                                      });
                                      await loginUser(
                                              "+964" +
                                                  _phoneNumberController.text,
                                              context)
                                          .then((value) {
                                        setState(() {
                                          _isloading = false;
                                        });
                                      });

                                      /* Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          _isloading = false;
                                        });
                                      });*/
                                    }
                                  }
                                : () => null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width * 0.27),
                                Text(
                                  "Sign up".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                const SizedBox(width: 30),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromARGB(255, 0, 32, 106),
                                  size: 28.0,
                                  //weight: IconWeight.bold
                                ),
                              ],
                            ),
                          ),
                        )
                      // ? BottomButtonColumn(
                      //     onTap: _isbuttonactive
                      //         ? () async {
                      //             if (_formKey.currentState!.validate()) {
                      //               setState(() {
                      //                 _isloading = true;
                      //               });
                      //               await loginUser(phone, context);

                      //               Future.delayed(Duration(seconds: 2), () {
                      //                 setState(() {
                      //                   _isloading = false;
                      //                 });
                      //               });
                      //             }
                      //           }
                      //         : () => null,
                      //     buttonText: _isbuttonactive
                      //         ? "SIGN UP"
                      //         : "CHECK CONDITION BOX",
                      //     buttonIcon: Icons.login_outlined,
                      //   )
                      : const Center(
                          child: SpinKitThreeBounce(
                          color: Colors.black,
                          size: 24,
                        )),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "SIGN IN".tr,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/signin');
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
