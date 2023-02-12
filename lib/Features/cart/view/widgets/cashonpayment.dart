// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sv_craft/Features/cart/controllar/cart_summary_con.dart';
// import 'package:sv_craft/Features/cart/controllar/final2_cheakout_con.dart';
// import 'package:sv_craft/Features/cart/controllar/final_checkout_con.dart';
// import 'package:sv_craft/Features/cart/view/pick_date_and_time.dart';
// import 'package:sv_craft/Features/home/controller/home_controller.dart';
// import 'package:sv_craft/Features/home/home_screen.dart';
// import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
// import 'package:sv_craft/Features/profile/view/address_page.dart';
// import 'package:sv_craft/Features/special_day/controllar/special_post_controller.dart';
// import 'package:sv_craft/constant/color.dart';

// class CashCheckoutScreen extends StatefulWidget {
//   const CashCheckoutScreen({Key? key}) : super(key: key);

//   @override
//   State<CashCheckoutScreen> createState() => _CashCheckoutScreenState();
// }

// class _CashCheckoutScreenState extends State<CashCheckoutScreen> {
//   final SpecialPostController special_post_controller =
//       Get.put(SpecialPostController());
//   final GetAddressController _getAddressController =
//       Get.put(GetAddressController());
//   final HomeController _homeController = Get.put(HomeController());
//   final GetCartSummaryController _getCartSummaryController =
//       Get.put(GetCartSummaryController());

//   final Final2cheakout _finalCheckoutControlle = Get.put(Final2cheakout());
//   final focusNodeController = FocusNode();

//   TextEditingController deliveryAddressController = TextEditingController();
//   TextEditingController _greetingsController = TextEditingController();
//   var Address;
//   var CartSummary;
//   @override
//   initState() {
//     super.initState();
//     Future.delayed(const Duration(microseconds: 500), () async {
//       setTokenToVariable();
//     });
//   }

//   Future<void> setTokenToVariable() async {
//     var address =
//         await _getAddressController.getAddress(_homeController.tokenGlobal);
//     if (address != null) {
//       setState(() {
//         Address = address;
//       });
//     }

//     var cartSummary = await _getCartSummaryController
//         .getCartSummary(_homeController.tokenGlobal);
//     if (cartSummary != null) {
//       setState(() {
//         CartSummary = cartSummary;
//       });
//     }
//   }

//   bool isNoData = false;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               centerTitle: true,
//               title: Text("cash on"),
//             ),
//             body: Address != null && CartSummary != null
//                 ? SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 10),
//                       child: Container(
//                         // color: Colors.white,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'CHECKOUT'.tr,
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Card(
//                               shadowColor: Colors.grey,
//                               elevation: 2,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.person,
//                                           color: Colors.blue,
//                                         ),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text(
//                                           '${Address.name}',
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                         const Spacer(),
//                                         // TextButton(
//                                         //     onPressed: () {
//                                         //       // Navigator.push(
//                                         //       //     context,
//                                         //       //     MaterialPageRoute(
//                                         //       //         builder: (context) =>
//                                         //       //             AddressScreen(
//                                         //       //               from: "checkout",
//                                         //       //             )));
//                                         //     },
//                                         //     child: const Text(
//                                         //       'Edit',
//                                         //       style: TextStyle(
//                                         //           color: Appcolor.primaryColor,
//                                         //           fontSize: 16),
//                                         //     ))
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.location_on,
//                                           color: Colors.blue,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Container(
//                                           width: size.width * 0.7,
//                                           child: isNoData == null
//                                               ? Container()
//                                               : Text(
//                                                   '${Address!.house}, ${Address!.colony}, ${Address!.city}, ${Address!.area}, ${Address!.address}',
//                                                   style: const TextStyle(
//                                                       fontSize: 16),
//                                                 ),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.phone,
//                                           color: Colors.blue,
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           '${Address!.phone}',
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                       ],
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 15,
//                                     // ),
//                                     // Row(
//                                     //   children: [
//                                     //     const Icon(
//                                     //       Icons.email_outlined,
//                                     //       color: Colors.blue,
//                                     //     ),
//                                     //     SizedBox(
//                                     //       width: 10,
//                                     //     ),
//                                     //     const Text(
//                                     //       'user@gmail.com',
//                                     //       style: TextStyle(
//                                     //           fontSize: 18,
//                                     //           fontWeight: FontWeight.normal,
//                                     //           color: Appcolor.primaryColor),
//                                     //     ),
//                                     //   ],
//                                     // ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             Card(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 child: TextField(
//                                   controller: deliveryAddressController,
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: null,
//                                   minLines: 3,
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       prefixIcon: Icon(
//                                         Icons.location_on,
//                                         color: Colors.blue,
//                                       ),
//                                       labelText: "Delivery Address".tr,
//                                       hintText: "Type Delivery Address".tr),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       Get.to(PickDateTime());
//                                     },
//                                     child: Text("Pic date and time".tr)),
//                                 const SizedBox(width: 8),
//                                 Obx(() => Text(
//                                       "Date : ".tr +
//                                           _finalCheckoutControlle
//                                               .timeAndDate.value
//                                               .toString(),
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     ))
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Card(
//                               shadowColor: Colors.grey,
//                               elevation: 2,
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Order Summary'.tr,
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                           color: Appcolor.primaryColor),
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '${CartSummary.totalItem.toString()}' +
//                                               "Items".tr,
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                         const Spacer(),
//                                         Text(
//                                           '${CartSummary.totalPrice.toString()} ' +
//                                               "kr".tr,
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Delivery Fee'.tr,
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                         const Spacer(),
//                                         Text(
//                                           '${CartSummary.shippingCharge.toString()} ' +
//                                               "kr".tr,
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 15,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Total".tr,
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                         const Spacer(),
//                                         // var finalPrice = CartSummary.totalPrice + CartSummary.shippingCharge;
//                                         Text(
//                                           '${CartSummary.totalPrice + CartSummary.shippingCharge} ' +
//                                               "kr".tr,
//                                           style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.normal,
//                                               color: Appcolor.primaryColor),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Container(height: 1, color: Colors.grey),
//                                     const SizedBox(height: 10),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             Card(
//                               shadowColor: Colors.grey,
//                               elevation: 2,
//                               child: TextFormField(
//                                 controller: _greetingsController,
//                                 keyboardType: TextInputType.text,
//                                 decoration: InputDecoration(
//                                   hintText: "Greetings".tr,
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.grey,
//                                   )),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                     color: Colors.grey,
//                                   )),
//                                 ),
//                                 validator: (val) {
//                                   if (val == null || val.isEmpty) {
//                                     return 'Enter your greetings'.tr;
//                                   }
//                                   return null;
//                                 },
//                                 maxLines: 6,
//                               ),
//                             ),
//                             // Card(
//                             //   shadowColor: Colors.grey,
//                             //   elevation: 2,
//                             //   child: CustomTextField(
//                             //     controller: _greetingsController,
//                             //     hintText: 'Greetings',
//                             //     maxLines: 6,
//                             //   ),
//                             // ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   alignment: Alignment.center,
//                                   width: size.width * .6,
//                                   height: size.height / 18,
//                                   decoration: BoxDecoration(
//                                     color: Colors.yellow,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () async {
//                                       var status = await _finalCheckoutControlle
//                                           .finalCheckout2(
//                                         textToken: _homeController.tokenGlobal,
//                                         address: deliveryAddressController.text,
//                                       );

//                                       if (status == 200) {
//                                         showDialog(
//                                           barrierDismissible: false,
//                                           barrierColor: Colors.transparent,
//                                           context: context,
//                                           builder: (ctx) => AlertDialog(
//                                             shape: const RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(32.0))),
//                                             contentPadding:
//                                                 const EdgeInsets.only(
//                                                     top: 10.0),
//                                             content: SizedBox(
//                                               child: Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Text(
//                                                     "Congratulations.".tr,
//                                                     style: TextStyle(
//                                                         color: Colors.green,
//                                                         fontSize: 16),
//                                                   ),
//                                                   const SizedBox(height: 6),
//                                                   Image.asset(
//                                                       "images/done checkmark.gif"),
//                                                 ],
//                                               ),
//                                             ),
//                                             actions: <Widget>[
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   Get.offAll(
//                                                       () => const HomeScreen());
//                                                 },
//                                                 child: Text("Done".tr),
//                                               ),
//                                               const SizedBox(width: 10),
//                                             ],
//                                           ),
//                                         );
//                                       } else {
//                                         Get.snackbar("Order Failed".tr, "",
//                                             snackPosition: SnackPosition.TOP,
//                                             backgroundColor: Colors.red,
//                                             colorText: Colors.white);
//                                       }
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "PLACE ORDER".tr,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 20,
//                                               color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   )));
//   }
// }
