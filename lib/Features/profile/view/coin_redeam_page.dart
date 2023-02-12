import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../../../services/services.dart';

class CoinRedeamPage extends StatefulWidget {
  CoinRedeamPage({super.key});

  @override
  State<CoinRedeamPage> createState() => _CoinRedeamPageState();
}

class _CoinRedeamPageState extends State<CoinRedeamPage> {
  var username = "";
  var coin = "0";
  List paymentList = [
    {
      "name": "Phone Payment",
      "date": "10 Oct 4:25pm",
      "icon": Icon(
        Icons.phone_android,
        size: 35,
        color: Colors.white,
      ),
      "payment": "100 coin",
    },
    {
      "name": "Card Payment",
      "date": "15 Sep 1:25pm",
      "icon": Icon(Icons.card_giftcard_outlined, size: 35, color: Colors.white),
      "payment": "150 coin",
    },
    {
      "name": "Saving Accaount",
      "date": "30 Oct 6:25am",
      "icon": Icon(Icons.wallet_outlined, size: 35, color: Colors.white),
      "payment": "50 coin",
    },
    {
      "name": "Trancfer Card Payment",
      "date": "20 Nov 8:35pm",
      "icon": Icon(Icons.card_membership, size: 35, color: Colors.white),
      "payment": "35 coin",
    },
    {
      "name": "Saving Accaount",
      "date": "18 Aug 12:07am",
      "icon": Icon(Icons.wallet, size: 35, color: Colors.white),
      "payment": "45 coin",
    },
    {
      "name": "Phone Payment",
      "date": "3 Jul 9:55pm",
      "icon": Icon(Icons.phone_android, size: 35, color: Colors.white),
      "payment": "500 coin",
    },
    {
      "name": "Trancfer Car Payment",
      "date": "10 Oct 10:15pm",
      "icon": Icon(Icons.card_giftcard, size: 35, color: Colors.white),
      "payment": "800 coin",
    },
    {
      "name": "Phone Payment",
      "date": "10 Dec 5:12am",
      "icon": Icon(Icons.phone_android_outlined, size: 35, color: Colors.white),
      "payment": "1050 coin",
    },
  ];
  Future vie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(Appurl.coinreedem), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["data"];
      var userData2 = jsonDecode(response.body);
      setState(() {
        username = userData2["username"];
        coin = userData2["total_coin"].toString();
      });
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  // Map<String, dynamic>? searchedData;

  // getSpecialSearchProducts() async {
  //   var response = await http.get(
  //       Uri.parse("http://sportszoneff.com/api/rewards/"),
  //       headers: ServicesClass.headersForAuth);

  //   searchedData = Map<String, dynamic>.from(jsonDecode(response.body));

  //   print(' DATA ======================== $searchedData');
  // }
  // Map<String, dynamic>? coin;
  // getWeatherData() async {
  //   String CoinApi = "http://sportszoneff.com/api/rewards";
  //   var weatherresponse = await http.get(Uri.parse(CoinApi));

  //   print("rresult is${weatherresponse.body}");

  //   setState(() {
  //     coin = Map<String, dynamic>.from(json.decode(weatherresponse.body));
  //   });
  // }

  Future? vi;
  @override
  void initState() {
    vi = vie();

    // getSpecialSearchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Redeeam Coin".tr,
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: vi,
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 153, 54),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        username,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.star_border_rounded,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            coin + "  Coin".tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .010,
                                ),
                                Center(
                                  child: Text(
                                    "  Coin".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .010,
                                ),
                                Center(
                                    child: Container(
                                  height: size.height * .015,
                                  width: size.width * .70,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 240, 224),
                                      borderRadius: BorderRadius.circular(12)),
                                )),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {},
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.star_border),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order id:".tr),
                                    Text(
                                      snapshot.data[index]["order_code"],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                subtitle: Text(snapshot.data[index]["date"],
                                    style: TextStyle(color: Colors.black)),
                                trailing: Text(
                                  "Earned coins: ".tr +
                                      snapshot.data[index]["earn_coint"]
                                          .toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                    );
                  } else {
                    return Text("No productt found");
                  }
                },
              ),
              // Expanded(
              //     flex: 4,
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: Color.fromARGB(255, 245, 153, 54),
              //             borderRadius: BorderRadius.circular(12)),
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     "data",
              //                     style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Icon(
              //                         Icons.star_border_rounded,
              //                         color: Colors.white,
              //                       ),
              //                       Text(
              //                         "10" + "  Coin",
              //                         style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.normal),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: size.height * .010,
              //             ),
              //             Center(
              //               child: Text(
              //                 "Coins",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.normal),
              //               ),
              //             ),
              //             SizedBox(
              //               height: size.height * .010,
              //             ),
              //             Center(
              //                 child: Container(
              //               height: size.height * .015,
              //               width: size.width * .70,
              //               decoration: BoxDecoration(
              //                   color: Color.fromARGB(255, 255, 240, 224),
              //                   borderRadius: BorderRadius.circular(12)),
              //             )),
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Center(
              //                 child: Text(
              //                   "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.normal),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     )),
              // Expanded(
              //   flex: 7,
              //   child: SingleChildScrollView(
              //     primary: true,
              //     scrollDirection: Axis.vertical,
              //     child: Column(
              //       children: [
              //         // FutureBuilder(
              //         //   future: vi,
              //         //   builder: (_, AsyncSnapshot<dynamic> snapshot) {
              //         //     if (snapshot.connectionState ==
              //         //         ConnectionState.waiting) {
              //         //       return Center(
              //         //         child: CircularProgressIndicator(),
              //         //       );
              //         //     } else if (snapshot.hasData) {
              //         //       return Container(
              //         //         child: ListView.builder(
              //         //             itemCount: snapshot.data.length,
              //         //             shrinkWrap: true,
              //         //             physics: NeverScrollableScrollPhysics(),
              //         //             itemBuilder: (context, index) {
              //         //               return SizedBox(
              //         //                 height: size.height * .4,
              //         //                 width: double.infinity,
              //         //                 child: Padding(
              //         //                   padding: const EdgeInsets.all(8.0),
              //         //                   child: Card(
              //         //                     elevation: 12,
              //         //                     child: Container(
              //         //                       height: size.height * .30,
              //         //                       width: double.infinity,
              //         //                       decoration: BoxDecoration(
              //         //                           color: Color.fromARGB(
              //         //                               255, 255, 255, 255),
              //         //                           borderRadius:
              //         //                               BorderRadius.circular(12)),
              //         //                       child: Column(
              //         //                         children: [
              //         //                           Padding(
              //         //                             padding:
              //         //                                 const EdgeInsets.all(12.0),
              //         //                             child: Row(
              //         //                               children: [
              //         //                                 Icon(
              //         //                                   Icons
              //         //                                       .star_outline_rounded,
              //         //                                   color: Colors.black,
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .02,
              //         //                                 ),
              //         //                                 Text(
              //         //                                   "Earned Coin",
              //         //                                   style: TextStyle(
              //         //                                       color: Colors.black,
              //         //                                       fontSize: 16,
              //         //                                       fontWeight:
              //         //                                           FontWeight.bold),
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .40,
              //         //                                 ),
              //         //                                 InkWell(
              //         //                                   onTap: () {},
              //         //                                   child: Text(
              //         //                                     "See All",
              //         //                                     style: TextStyle(
              //         //                                         color: Colors.black,
              //         //                                         fontSize: 20,
              //         //                                         fontWeight:
              //         //                                             FontWeight
              //         //                                                 .bold),
              //         //                                   ),
              //         //                                 ),
              //         //                               ],
              //         //                             ),
              //         //                           ),
              //         //                           Divider(
              //         //                             color: Colors.grey,
              //         //                           ),
              //         //                           Padding(
              //         //                             padding:
              //         //                                 const EdgeInsets.all(12.0),
              //         //                             child: Row(
              //         //                               children: [
              //         //                                 CircleAvatar(
              //         //                                   radius: 25,
              //         //                                   backgroundColor:
              //         //                                       Color.fromARGB(
              //         //                                           255, 0, 97, 10),
              //         //                                   // child: Center(
              //         //                                   //   child:
              //         //                                   //   Text(
              //         //                                   //     "earn\nback",
              //         //                                   //     style: TextStyle(
              //         //                                   //         color:
              //         //                                   //             Colors.white,
              //         //                                   //         fontSize: 14,
              //         //                                   //         fontWeight:
              //         //                                   //             FontWeight
              //         //                                   //                 .bold),
              //         //                                   //   ),
              //         //                                   // ),
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .02,
              //         //                                 ),
              //         //                                 Column(
              //         //                                   crossAxisAlignment:
              //         //                                       CrossAxisAlignment
              //         //                                           .start,
              //         //                                   children: [
              //         //                                     Text(
              //         //                                       snapshot.data[index]
              //         //                                               ["order_code"]
              //         //                                           .toString(),
              //         //                                       style: TextStyle(
              //         //                                           color:
              //         //                                               Colors.black,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                     Text(
              //         //                                       "Redeeam Coin",
              //         //                                       style: TextStyle(
              //         //                                           color:
              //         //                                               Colors.black,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                     Text(
              //         //                                       "00" + "  Coin",
              //         //                                       style: TextStyle(
              //         //                                           color: Colors
              //         //                                               .redAccent,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                   ],
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .25,
              //         //                                 ),
              //         //                                 InkWell(
              //         //                                   onTap: () {},
              //         //                                   child: Container(
              //         //                                     height:
              //         //                                         size.height * .05,
              //         //                                     width: size.width * .22,
              //         //                                     decoration: BoxDecoration(
              //         //                                         color:
              //         //                                             Color.fromARGB(
              //         //                                                 255,
              //         //                                                 198,
              //         //                                                 192,
              //         //                                                 192),
              //         //                                         borderRadius:
              //         //                                             BorderRadius
              //         //                                                 .circular(
              //         //                                                     20)),
              //         //                                     child: Center(
              //         //                                       child: Text(
              //         //                                         "See All",
              //         //                                         style: TextStyle(
              //         //                                             color: Colors
              //         //                                                 .black,
              //         //                                             fontSize: 20,
              //         //                                             fontWeight:
              //         //                                                 FontWeight
              //         //                                                     .w400),
              //         //                                       ),
              //         //                                     ),
              //         //                                   ),
              //         //                                 ),
              //         //                               ],
              //         //                             ),
              //         //                           ),
              //         //                           SizedBox(
              //         //                             height: size.height * .01,
              //         //                           ),
              //         //                           Padding(
              //         //                             padding:
              //         //                                 const EdgeInsets.all(12.0),
              //         //                             child: Row(
              //         //                               children: [
              //         //                                 CircleAvatar(
              //         //                                   radius: 25,
              //         //                                   backgroundColor:
              //         //                                       Color.fromARGB(
              //         //                                           255, 0, 97, 10),
              //         //                                   child: Center(
              //         //                                     child: Text(
              //         //                                       "cash\nback",
              //         //                                       style: TextStyle(
              //         //                                           color:
              //         //                                               Colors.white,
              //         //                                           fontSize: 14,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .bold),
              //         //                                     ),
              //         //                                   ),
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .02,
              //         //                                 ),
              //         //                                 Column(
              //         //                                   crossAxisAlignment:
              //         //                                       CrossAxisAlignment
              //         //                                           .start,
              //         //                                   children: [
              //         //                                     Text(
              //         //                                       "Redeeam Coin",
              //         //                                       style: TextStyle(
              //         //                                           color:
              //         //                                               Colors.black,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                     Text(
              //         //                                       "Redeeam Coin",
              //         //                                       style: TextStyle(
              //         //                                           color:
              //         //                                               Colors.black,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                     Text(
              //         //                                       "00" + "  Coin",
              //         //                                       style: TextStyle(
              //         //                                           color: Colors
              //         //                                               .redAccent,
              //         //                                           fontSize: 16,
              //         //                                           fontWeight:
              //         //                                               FontWeight
              //         //                                                   .normal),
              //         //                                     ),
              //         //                                   ],
              //         //                                 ),
              //         //                                 SizedBox(
              //         //                                   width: size.width * .25,
              //         //                                 ),
              //         //                                 InkWell(
              //         //                                   onTap: () {},
              //         //                                   child: Container(
              //         //                                     height:
              //         //                                         size.height * .05,
              //         //                                     width: size.width * .22,
              //         //                                     decoration: BoxDecoration(
              //         //                                         color:
              //         //                                             Color.fromARGB(
              //         //                                                 255,
              //         //                                                 198,
              //         //                                                 192,
              //         //                                                 192),
              //         //                                         borderRadius:
              //         //                                             BorderRadius
              //         //                                                 .circular(
              //         //                                                     20)),
              //         //                                     child: Center(
              //         //                                       child: Text(
              //         //                                         "See All",
              //         //                                         style: TextStyle(
              //         //                                             color: Colors
              //         //                                                 .black,
              //         //                                             fontSize: 20,
              //         //                                             fontWeight:
              //         //                                                 FontWeight
              //         //                                                     .w400),
              //         //                                       ),
              //         //                                     ),
              //         //                                   ),
              //         //                                 ),
              //         //                               ],
              //         //                             ),
              //         //                           ),
              //         //                         ],
              //         //                       ),
              //         //                     ),
              //         //                   ),
              //         //                 ),
              //         //               );
              //         //             }),
              //         //       );
              //         //     } else {
              //         //       return Text("No productt found");
              //         //     }
              //         //   },
              //         // ),

              //         // SizedBox(
              //         //   height: size.height * .4,
              //         //   width: double.infinity,
              //         //   child: Padding(
              //         //     padding: const EdgeInsets.all(8.0),
              //         //     child: Card(
              //         //       elevation: 12,
              //         //       child: Container(
              //         //         height: size.height * .30,
              //         //         width: double.infinity,
              //         //         decoration: BoxDecoration(
              //         //             color: Color.fromARGB(255, 255, 255, 255),
              //         //             borderRadius: BorderRadius.circular(12)),
              //         //         child: Column(
              //         //           children: [
              //         //             Padding(
              //         //               padding: const EdgeInsets.all(12.0),
              //         //               child: Row(
              //         //                 children: [
              //         //                   Icon(
              //         //                     Icons.star_outline_rounded,
              //         //                     color: Colors.black,
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .02,
              //         //                   ),
              //         //                   Text(
              //         //                     "Redeeam Coin",
              //         //                     style: TextStyle(
              //         //                         color: Colors.black,
              //         //                         fontSize: 16,
              //         //                         fontWeight: FontWeight.bold),
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .40,
              //         //                   ),
              //         //                   InkWell(
              //         //                     onTap: () {},
              //         //                     child: Text(
              //         //                       "See All",
              //         //                       style: TextStyle(
              //         //                           color: Colors.black,
              //         //                           fontSize: 20,
              //         //                           fontWeight: FontWeight.bold),
              //         //                     ),
              //         //                   ),
              //         //                 ],
              //         //               ),
              //         //             ),
              //         //             Divider(
              //         //               color: Colors.grey,
              //         //             ),
              //         //             Padding(
              //         //               padding: const EdgeInsets.all(12.0),
              //         //               child: Row(
              //         //                 children: [
              //         //                   CircleAvatar(
              //         //                     radius: 25,
              //         //                     backgroundColor:
              //         //                         Color.fromARGB(255, 0, 97, 10),
              //         //                     child: Center(
              //         //                       child: Text(
              //         //                         "cash\nback",
              //         //                         style: TextStyle(
              //         //                             color: Colors.white,
              //         //                             fontSize: 14,
              //         //                             fontWeight: FontWeight.bold),
              //         //                       ),
              //         //                     ),
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .02,
              //         //                   ),
              //         //                   Column(
              //         //                     crossAxisAlignment:
              //         //                         CrossAxisAlignment.start,
              //         //                     children: [
              //         //                       Text(
              //         //                         "Redeeam Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.black,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                       Text(
              //         //                         "Redeeam Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.black,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                       Text(
              //         //                         "00" + "  Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.redAccent,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                     ],
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .25,
              //         //                   ),
              //         //                   InkWell(
              //         //                     onTap: () {},
              //         //                     child: Container(
              //         //                       height: size.height * .05,
              //         //                       width: size.width * .22,
              //         //                       decoration: BoxDecoration(
              //         //                           color: Color.fromARGB(
              //         //                               255, 198, 192, 192),
              //         //                           borderRadius:
              //         //                               BorderRadius.circular(20)),
              //         //                       child: Center(
              //         //                         child: Text(
              //         //                           "See All",
              //         //                           style: TextStyle(
              //         //                               color: Colors.black,
              //         //                               fontSize: 20,
              //         //                               fontWeight: FontWeight.w400),
              //         //                         ),
              //         //                       ),
              //         //                     ),
              //         //                   ),
              //         //                 ],
              //         //               ),
              //         //             ),
              //         //             SizedBox(
              //         //               height: size.height * .01,
              //         //             ),
              //         //             Padding(
              //         //               padding: const EdgeInsets.all(12.0),
              //         //               child: Row(
              //         //                 children: [
              //         //                   CircleAvatar(
              //         //                     radius: 25,
              //         //                     backgroundColor:
              //         //                         Color.fromARGB(255, 0, 97, 10),
              //         //                     child: Center(
              //         //                       child: Text(
              //         //                         "cash\nback",
              //         //                         style: TextStyle(
              //         //                             color: Colors.white,
              //         //                             fontSize: 14,
              //         //                             fontWeight: FontWeight.bold),
              //         //                       ),
              //         //                     ),
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .02,
              //         //                   ),
              //         //                   Column(
              //         //                     crossAxisAlignment:
              //         //                         CrossAxisAlignment.start,
              //         //                     children: [
              //         //                       Text(
              //         //                         "Redeeam Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.black,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                       Text(
              //         //                         "Redeeam Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.black,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                       Text(
              //         //                         "00" + "  Coin",
              //         //                         style: TextStyle(
              //         //                             color: Colors.redAccent,
              //         //                             fontSize: 16,
              //         //                             fontWeight: FontWeight.normal),
              //         //                       ),
              //         //                     ],
              //         //                   ),
              //         //                   SizedBox(
              //         //                     width: size.width * .25,
              //         //                   ),
              //         //                   InkWell(
              //         //                     onTap: () {},
              //         //                     child: Container(
              //         //                       height: size.height * .05,
              //         //                       width: size.width * .22,
              //         //                       decoration: BoxDecoration(
              //         //                           color: Color.fromARGB(
              //         //                               255, 198, 192, 192),
              //         //                           borderRadius:
              //         //                               BorderRadius.circular(20)),
              //         //                       child: Center(
              //         //                         child: Text(
              //         //                           "See All",
              //         //                           style: TextStyle(
              //         //                               color: Colors.black,
              //         //                               fontSize: 20,
              //         //                               fontWeight: FontWeight.w400),
              //         //                         ),
              //         //                       ),
              //         //                     ),
              //         //                   ),
              //         //                 ],
              //         //               ),
              //         //             ),
              //         //           ],
              //         //         ),
              //         //       ),
              //         //     ),
              //         //   ),
              //         // ),

              //         ListView.builder(
              //           itemCount: paymentList.length,
              //           primary: false,
              //           shrinkWrap: true,
              //           itemBuilder: ((context, index) {
              //             return Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     width: double.infinity,
              //                     height: size.height * .12,
              //                     decoration: BoxDecoration(
              //                         color: Color.fromARGB(255, 255, 255, 255),
              //                         borderRadius: BorderRadius.circular(12)),
              //                     child: Card(
              //                       color: Color.fromARGB(255, 255, 255, 255),
              //                       elevation: 12,
              //                       shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(12)),
              //                       child: Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 Padding(
              //                                   padding: const EdgeInsets.all(5),
              //                                   child: Container(
              //                                     height: size.height * .10,
              //                                     width: size.width * .10,
              //                                     decoration: BoxDecoration(
              //                                         color: Color.fromARGB(
              //                                             255, 128, 171, 130),
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 20)),
              //                                     child: paymentList[index]
              //                                         ["icon"],
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                             // SizedBox(
              //                             //   width: size.width * 0.05,
              //                             // ),
              //                             Padding(
              //                               padding:
              //                                   const EdgeInsets.only(top: 10),
              //                               child: Row(
              //                                 children: [
              //                                   Column(
              //                                     children: [
              //                                       Text(
              //                                         "${paymentList[index]["name"]}",
              //                                         style: TextStyle(
              //                                             color: Colors.black,
              //                                             fontSize: 20,
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                       ),
              //                                       Text(
              //                                         "${paymentList[index]["date"]}",
              //                                         style: TextStyle(
              //                                             color: Colors.black,
              //                                             fontSize: 14,
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                       ),
              //                                     ],
              //                                   )
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               width: size.width * 0.05,
              //                             ),
              //                             Padding(
              //                               padding:
              //                                   const EdgeInsets.only(right: 10),
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceAround,
              //                                 children: [
              //                                   Image(
              //                                     image:
              //                                         AssetImage("images/c.png"),
              //                                     height: 20,
              //                                     width: 20,
              //                                   ),
              //                                   Padding(
              //                                     padding: const EdgeInsets.only(
              //                                         top: 20.0, left: 2),
              //                                     child: Column(
              //                                       children: [
              //                                         Text(
              //                                           "${paymentList[index]["payment"]}",
              //                                           style: TextStyle(
              //                                               color: Colors.black,
              //                                               fontSize: 20,
              //                                               fontWeight:
              //                                                   FontWeight.bold),
              //                                         ),
              //                                         SizedBox(
              //                                           width: size.width * 0.05,
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   )
              //                                 ],
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           }),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
