import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/controllar/cart_summary_con.dart';
import 'package:sv_craft/Features/cart/controllar/final2_cheakout_con.dart';
import 'package:sv_craft/Features/cart/controllar/final_checkout_con.dart';
import 'package:sv_craft/Features/cart/view/pick_date_and_time.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/view/address_page.dart';
import 'package:sv_craft/Features/special_day/controllar/special_post_controller.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final SpecialPostController special_post_controller =
      Get.put(SpecialPostController());
  final GetAddressController _getAddressController =
      Get.put(GetAddressController());
  final HomeController _homeController = Get.put(HomeController());
  final GetCartSummaryController _getCartSummaryController =
      Get.put(GetCartSummaryController());
  final FinalCheckoutController _finalCheckoutController =
      Get.put(FinalCheckoutController());

  final focusNodeController = FocusNode();

  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController _greetingsController = TextEditingController();
  var Address;
  var CartSummary;
  var location, location2;
  var loc, c_name;
  var val, val2;

  List shots = [];
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
    viewall_experience = locationsss();
    super.initState();
    Future.delayed(const Duration(microseconds: 500), () async {
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
    }

    var cartSummary = await _getCartSummaryController
        .getCartSummary(_homeController.tokenGlobal);
    if (cartSummary != null) {
      setState(() {
        CartSummary = cartSummary;
      });
    }
  }

  bool isNoData = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(

              elevation: 0,
              centerTitle: true,
              title: Text("SV_Kraft".tr),
            ),
            body: Address != null && CartSummary != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Container(
                        // color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'CHECKOUT'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              shadowColor: Colors.grey,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${Address.name}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Appcolor.primaryColor),
                                        ),
                                        const Spacer(),
                                        // TextButton(
                                        //     onPressed: () {
                                        //       // Navigator.push(
                                        //       //     context,
                                        //       //     MaterialPageRoute(
                                        //       //         builder: (context) =>
                                        //       //             AddressScreen(
                                        //       //               from: "checkout",
                                        //       //             )));
                                        //     },
                                        //     child: const Text(
                                        //       'Edit',
                                        //       style: TextStyle(
                                        //           color: Appcolor.primaryColor,
                                        //           fontSize: 16),
                                        //     ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          width: size.width * 0.7,
                                          child: isNoData == null
                                              ? Container()
                                              : Text(
                                                  '${Address!.house}, ${Address!.colony}, ${Address!.city}, ${Address!.area}, ${Address!.address}',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${Address!.phone}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     const Icon(
                                    //       Icons.email_outlined,
                                    //       color: Colors.blue,
                                    //     ),
                                    //     SizedBox(
                                    //       width: 10,
                                    //     ),
                                    //     const Text(
                                    //       'user@gmail.com',
                                    //       style: TextStyle(
                                    //           fontSize: 18,
                                    //           fontWeight: FontWeight.normal,
                                    //           color: Appcolor.primaryColor),
                                    //     ),
                                    //   ],
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
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
                                                              "Enter address"
                                                                  .tr,
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
                                                                value: value[
                                                                            "id"]
                                                                        .toString() +
                                                                    "_" +
                                                                    value[
                                                                        'name'],
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
                                                              child:
                                                                  Container()),
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

                            const SizedBox(
                              height: 30,
                            ),
                            Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: deliveryAddressController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.blue,
                                      ),
                                      labelText: "Delivery Address".tr,
                                      hintText: "Type Delivery Address".tr),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.to(PickDateTime());
                                    },
                                    child: Text("Pic date and time".tr)),
                                const SizedBox(width: 8),
                                Obx(() => Text(
                                      "Date : ".tr +
                                          _finalCheckoutController
                                              .timeAndDate.value
                                              .toString() +
                                          _finalCheckoutController
                                              .timeAndDate.value
                                              .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Card(
                              shadowColor: Colors.grey,
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order Summary'.tr,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Appcolor.primaryColor),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${CartSummary.totalItem.toString()}' +
                                              "Items".tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${CartSummary.totalPrice.toString()} ' +
                                              "kr".tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery Fee'.tr,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${CartSummary.shippingCharge.toString()} ' +
                                              "kr".tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Total".tr,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                        const Spacer(),
                                        // var finalPrice = CartSummary.totalPrice + CartSummary.shippingCharge;
                                        Text(
                                          '${CartSummary.totalPrice + CartSummary.shippingCharge} ' +
                                              "kr".tr,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Appcolor.primaryColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(height: 1, color: Colors.grey),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Card(
                              shadowColor: Colors.grey,
                              elevation: 2,
                              child: TextFormField(
                                controller: _greetingsController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Greetings".tr,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.grey,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.grey,
                                  )),
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter your greetings'.tr;
                                  }
                                  return null;
                                },
                                maxLines: 6,
                              ),
                            ),
                            // Card(
                            //   shadowColor: Colors.grey,
                            //   elevation: 2,
                            //   child: CustomTextField(
                            //     controller: _greetingsController,
                            //     hintText: 'Greetings',
                            //     maxLines: 6,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width * .45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: size.width * .4,
                                        height: size.height / 18,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            var status =
                                                await _finalCheckoutController
                                                    .finalCheckout(
                                                        textToken:
                                                            _homeController
                                                                .tokenGlobal,
                                                        address:
                                                            deliveryAddressController
                                                                    .text +
                                                                loc);

                                            if (status == 200) {
                                              showDialog(
                                                barrierDismissible: false,
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  content: SizedBox(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Congratulations.".tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        Image.asset(
                                                            "images/done checkmark.gif"),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.offAll(() =>
                                                            const HomeScreen());
                                                      },
                                                      child: Text("Done".tr),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              Get.defaultDialog(
                                                  title: "faild upload".tr,
                                                  middleText:
                                                      "purchase some coin".tr,
                                                  backgroundColor:
                                                      Appcolor.primaryColor,
                                                  titleStyle: TextStyle(
                                                      color: Colors.white),
                                                  middleTextStyle: TextStyle(
                                                      color: Colors.white),
                                                  radius: 30,
                                                  actions: [
                                                    Center(
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: Colors
                                                                      .white),
                                                          onPressed: () {
                                                            Get.to(() =>
                                                                HomeScreen());
                                                          },
                                                          child: Text(
                                                            "OK".tr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          )),
                                                    )
                                                  ]);
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Buy with coin".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * .5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: size.width * .4,
                                        height: size.height / 18,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            var status =
                                                await _finalCheckoutController
                                                    .finalCheckout2(
                                              textToken:
                                                  _homeController.tokenGlobal,
                                              address: deliveryAddressController
                                                      .text +
                                                  loc,
                                            );

                                            if (status == 200) {
                                              showDialog(
                                                barrierDismissible: false,
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  content: SizedBox(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Congratulations.".tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        Image.asset(
                                                            "images/done checkmark.gif"),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Get.offAll(() =>
                                                            const HomeScreen());
                                                      },
                                                      child: Text("Done".tr),
                                                    ),
                                                    const SizedBox(width: 10),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              Get.snackbar(
                                                  "Order Failed".tr, "",
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Cash on delivery".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
