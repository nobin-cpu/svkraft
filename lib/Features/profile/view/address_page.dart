import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/view/checkout_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/profile/controller/address_controller.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/view/my_address_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:http/http.dart' as http;

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key, this.from}) : super(key: key);
  final String? from;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressController _saveAddressController = Get.put(AddressController());
  final HomeController _homeController = Get.put(HomeController());
  final GetAddressController _getAddressController =
      Get.put(GetAddressController());
  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');
  var phone;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _colonyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  var otpUser;

  final _codeController = TextEditingController();
  var location, location2;
  var loc, c_name;
  var val, val2;

  List shots = [];
  var Address;
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
  initState() {
    super.initState();
    viewall_experience = locationsss();
    Future.delayed(Duration(microseconds: 100), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var address =
        await _getAddressController.getAddress(_homeController.tokenGlobal);
    if (address != null) {
      setState(() {
        Address = address;
      });

      setState(() {
        _fullNameController.text = Address.name ?? " ";
        _phoneNumberController.text = Address.phone ?? " ";
        _houseController.text = Address.house ?? " ";
        _colonyController.text = Address.colony ?? " ";
        _cityController.text = Address.city ?? " ";
        _areaController.text = Address.area ?? " ";
        _addressController.text = Address.address ?? " ";
      });
    }
  }

  // Future<void> setValueToController() async {
  //   setState(() {
  //     _fullNameController!.text = Address.name;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                    "Delivery Information".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Fill all the field to continue!".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            // child: Card(
                            //   child:

                            //    TextFormField(
                            //     controller: _fullNameController,
                            //     // initialValue: Address.name,
                            //     decoration: InputDecoration(
                            //       // labelText: 'Username',
                            //       hintText: "Enter first name and last name".tr,
                            //       prefixIcon: Icon(Icons.person_outline),
                            //       border: InputBorder.none,
                            //     ),

                            //     validator: (value) {
                            //       if (value == null || value.trim().isEmpty) {
                            //         return 'This field is required'.tr;
                            //       }
                            //       if (value.trim().length < 4) {
                            //         return 'At least 4 characters'.tr;
                            //       }
                            //       // Return null if the entered username is valid
                            //       return null;
                            //     },
                            //     //onChanged: (value) => _userName = value,
                            //   ),
                            // ),
                          ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Text(
                          //   "Phone Number".tr,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 12,
                          //     color: Colors.grey.withOpacity(0.8),
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Colors.white.withOpacity(0.1),
                          //           spreadRadius: 1,
                          //           blurRadius: 1,
                          //           offset: const Offset(0, 1),
                          //         ),
                          //       ],
                          //     ),
                          //     child: Container(
                          //       height: size.height / 15,
                          //       width: size.width,
                          //       decoration: BoxDecoration(
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.white.withOpacity(0.1),
                          //             spreadRadius: 1,
                          //             blurRadius: 1,
                          //             offset: const Offset(0, 1),
                          //           ),
                          //         ],
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(left: 8.0),
                          //         child: InternationalPhoneNumberInput(
                          //           onInputChanged: (PhoneNumber number) {
                          //             phone = number.phoneNumber;
                          //             print(number.phoneNumber);
                          //             // setState(() {
                          //             //   phone = number.phoneNumber;
                          //             // });
                          //           },
                          //           onInputValidated: (bool value) {
                          //             print(value);
                          //           },
                          //           selectorConfig: const SelectorConfig(
                          //             selectorType:
                          //                 PhoneInputSelectorType.BOTTOM_SHEET,
                          //           ),
                          //           ignoreBlank: false,
                          //           autoValidateMode: AutovalidateMode.disabled,
                          //           selectorTextStyle:
                          //               const TextStyle(color: Colors.black),
                          //           initialValue: number,
                          //           textFieldController: _phoneNumberController,
                          //           formatInput: false,
                          //           keyboardType:
                          //               const TextInputType.numberWithOptions(
                          //             signed: true,
                          //             decimal: true,
                          //           ),
                          //           // validator: (v) => v!.isEmpty
                          //           //     ? "Field Can't be Empty"
                          //           //     : null,
                          //           validator: (value) {
                          //             if (value == null ||
                          //                 value.trim().isEmpty) {
                          //               return 'This field is required'.tr;
                          //             }
                          //             if (value.trim().length < 9) {
                          //               return 'Number must be at least 11 characters in length'
                          //                   .tr;
                          //             }
                          //             // Return null if the entered username is valid
                          //             return null;
                          //           },
                          //           inputBorder: InputBorder.none,
                          //           onSaved: (PhoneNumber number) {
                          //             print('On Saved: $number');
                          //           },
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Text(
                          //   "Building no/ House no".tr,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 12,
                          //     color: Colors.grey.withOpacity(0.8),
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       new BoxShadow(
                          //         color: Colors.white,
                          //         blurRadius: 20.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Card(
                          //     child: TextFormField(
                          //       controller: _houseController,
                          //       decoration: InputDecoration(
                          //         //labelText: 'Username',
                          //         hintText: "Please enter".tr,
                          //         prefixIcon: Icon(Icons.person_outline),
                          //         border: InputBorder.none,
                          //       ),

                          //       validator: (value) {
                          //         if (value == null || value.trim().isEmpty) {
                          //           return 'This field is required'.tr;
                          //         }

                          //         // Return null if the entered username is valid
                          //         return null;
                          //       },
                          //       //onChanged: (value) => _userName = value,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Text(
                          //   "Colony/ Locality".tr,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 12,
                          //     color: Colors.grey.withOpacity(0.8),
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       new BoxShadow(
                          //         color: Colors.white,
                          //         blurRadius: 20.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Card(
                          //     child: TextFormField(
                          //       controller: _colonyController,
                          //       decoration: InputDecoration(
                          //         //labelText: 'Username',
                          //         hintText: "Please enter".tr,
                          //         prefixIcon: Icon(Icons.person_outline),
                          //         border: InputBorder.none,
                          //       ),

                          //       validator: (value) {
                          //         if (value == null || value.trim().isEmpty) {
                          //           return 'This field is required'.tr;
                          //         }

                          //         // Return null if the entered username is valid
                          //         return null;
                          //       },
                          //       //onChanged: (value) => _userName = value,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Text(
                          //   "City".tr,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 12,
                          //     color: Colors.grey.withOpacity(0.8),
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       new BoxShadow(
                          //         color: Colors.white,
                          //         blurRadius: 20.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Card(
                          //     child: TextFormField(
                          //       controller: _cityController,
                          //       decoration: InputDecoration(
                          //         //labelText: 'Username',
                          //         hintText: "Please enter".tr,
                          //         prefixIcon: Icon(Icons.person_outline),
                          //         border: InputBorder.none,
                          //       ),

                          //       validator: (value) {
                          //         if (value == null || value.trim().isEmpty) {
                          //           return 'This field is required'.tr;
                          //         }

                          //         // Return null if the entered username is valid
                          //         return null;
                          //       },
                          //       //onChanged: (value) => _userName = value,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          // Text(
                          //   "Area".tr,
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 12,
                          //     color: Colors.grey.withOpacity(0.8),
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       new BoxShadow(
                          //         color: Colors.white,
                          //         blurRadius: 20.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Card(
                          //     child: TextFormField(
                          //       controller: _areaController,
                          //       decoration: InputDecoration(
                          //         //labelText: 'Username',
                          //         hintText: "Please enter".tr,
                          //         prefixIcon: Icon(Icons.person_outline),
                          //         border: InputBorder.none,
                          //       ),

                          //       validator: (value) {
                          //         if (value == null || value.trim().isEmpty) {
                          //           return 'This field is required'.tr;
                          //         }

                          //         // Return null if the entered username is valid
                          //         return null;
                          //       },
                          //       //onChanged: (value) => _userName = value,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 25,
                          // ),

                          Text(
                            "Address".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     boxShadow: [
                          //       new BoxShadow(
                          //         color: Colors.white,
                          //         blurRadius: 20.0,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Card(
                          //     child: TextFormField(
                          //       controller: _addressController,
                          //       decoration: InputDecoration(
                          //         //labelText: 'Username',
                          //         hintText:
                          //             "Example: House#123, Street#123, Block#123"
                          //                 .tr,
                          //         prefixIcon: Icon(Icons.person_outline),
                          //         border: InputBorder.none,
                          //       ),

                          //       validator: (value) {
                          //         if (value == null || value.trim().isEmpty) {
                          //           return 'This field is required'.tr;
                          //         }

                          //         // Return null if the entered username is valid
                          //         return null;
                          //       },
                          //       //onChanged: (value) => _userName = value,
                          //     ),
                          //   ),
                          // ),

                          FutureBuilder(
                              future: viewall_experience!,
                              builder: (context, snapshot) {
                                shots = (snapshot.data ?? []) as List;
                                return snapshot.hasData
                                    ? shots != null
                                        ? Container(
                                            child: new DropdownButton<String>(
                                              value: loc,
                                              isExpanded:
                                                  true, //Add this property

                                              hint: loc == null
                                                  ? Text("Enter address".tr,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Appcolor
                                                              .primaryColor))
                                                  : Text(c_name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Appcolor
                                                              .primaryColor)),
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
                                                          style: TextStyle(
                                                              color: Appcolor
                                                                  .primaryColor),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  loc = value;
                                                  val = loc!.split('_');
                                                  print(val[0] + " NEw value");
                                                  print(
                                                      val[1] + " class value");
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: size.width * 1,
                    height: size.height / 18,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var statusCode =
                              await _saveAddressController.saveAddress(
                            _fullNameController.text,
                            _phoneNumberController.text,
                            _houseController.text,
                            _colonyController.text,
                            _cityController.text,
                            _areaController.text,
                            location.toString(),
                            _homeController.tokenGlobal,
                          );
                          if (statusCode == 200) {
                            // Get.snackbar(
                            //     backgroundColor: Colors.green,
                            //     colorText: Colors.white,
                            //     "Address saved".tr,
                            //     "Succsessfully saved".tr);
                            Get.to(CheckoutScreen());
                            //Navigate to checkout page
                            if (widget.from == "address") {
                              Get.offAll(() => MyAddressScreen());
                            } else if (widget.from == "checkout") {
                              Get.offAll(() => CheckoutScreen());
                            }
                          } else {
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                "Address not saved".tr,
                                "");
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Save".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
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
