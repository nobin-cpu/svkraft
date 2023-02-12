// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:sv_craft/Features/market_place/controller/dproduct_details_controller.dart';
// import 'package:sv_craft/Features/market_place/model/product_details.dart';
// import 'package:sv_craft/constant/api_link.dart';

// class SellerProductDetails extends StatefulWidget {
//   const SellerProductDetails({
//     Key? key,
//     required this.id,
//     required this.token,
//   }) : super(key: key);
//   final int id;
//   final String token;

//   @override
//   State<SellerProductDetails> createState() => _SellerProductDetailsState();
// }

// class _SellerProductDetailsState extends State<SellerProductDetails> {
//   final ProductDetailsController _productDetailsController =
//       Get.put(ProductDetailsController());

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: const Color.fromARGB(255, 32, 32, 32),
//       body: SingleChildScrollView(
//         child: FutureBuilder<ProductDetailsData?>(
//             future: _productDetailsController.getProductDetails(
//                 widget.token, widget.id),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(
//                     child: Center(
//                         child: const SpinKitFadingCircle(
//                   color: Colors.black,
//                 )));
//               } else {
//                 if (snapshot.data == null) {
//                   return const Center(
//                       child: Center(
//                           child: const SpinKitFadingCircle(
//                     color: Colors.black,
//                   )));
//                 } else {
//                   final data = snapshot.data;
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Image.network(
//                           '${Appurl.baseURL}${data!.image[0].filePath}',
//                           fit: BoxFit.cover,
//                           height: size.height * 0.5,
//                           width: size.width,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           //height: size.height * 0.5,
//                           width: size.width,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(data.productName,
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.normal)),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               // Text(data.description,
//                               //     style: const TextStyle(
//                               //         color: Colors.white60,
//                               //         fontSize: 18,
//                               //         fontWeight: FontWeight.normal)),
//                               Html(
//                                 data: data.description,
//                                 style: {
//                                   "html": Style(
//                                     color: Colors.white,
//                                   ),
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Text('Price : ${data.price} kr',
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.normal)),
//                               const SizedBox(
//                                 height: 70,
//                               ),
//                               // Row(
//                               //   mainAxisAlignment: MainAxisAlignment.center,
//                               //   children: [
//                               //     InkWell(
//                               //       onTap: () {
//                               //         //Navigate to SellerProfile with material route
//                               //         Navigator.push(
//                               //             context,
//                               //             MaterialPageRoute(
//                               //                 builder: (context) =>
//                               //                     SellerProfile()));
//                               //       },
//                               //       child: Container(
//                               //         alignment: Alignment.center,
//                               //         decoration: BoxDecoration(
//                               //           color: Appcolor.buttonColor,
//                               //           borderRadius: BorderRadius.circular(8),
//                               //           boxShadow: const [
//                               //             BoxShadow(
//                               //               color: Colors
//                               //                   .black12, //color of shadow
//                               //               spreadRadius: 2, //spread radius
//                               //               blurRadius: 5, // blur radius
//                               //               offset: Offset(0,
//                               //                   2), // changes position of shadow
//                               //               //first paramerter of offset is left-right
//                               //               //second parameter is top to down
//                               //             )
//                               //           ],
//                               //         ),
//                               //         width: 180,
//                               //         height: 45,
//                               //         child: Row(
//                               //           mainAxisAlignment:
//                               //               MainAxisAlignment.center,
//                               //           children: const [
//                               //             Text(
//                               //               'Show Profile',
//                               //               style: TextStyle(
//                               //                   color: Appcolor.textColor,
//                               //                   fontSize: 18),
//                               //               textAlign: TextAlign.center,
//                               //             ),
//                               //           ],
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 }
//               }
//             }),
//       ),
//     ));
//   }
// }
