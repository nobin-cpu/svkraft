import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/chat/view/chat_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/bookmark_con.dart';
import 'package:sv_craft/Features/market_place/view/chatbox.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';
import 'package:sv_craft/app/constant/api_constant.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'chat.dart';

import 'sellerprofile.dart';
import 'package:share_plus/share_plus.dart';

class Detailss extends StatefulWidget {
  final String Id;
  final String productId;
  const Detailss({super.key, required this.Id, required this.productId});

  @override
  State<Detailss> createState() => _DetailssState();
}

class _DetailssState extends State<Detailss> {
  final GetProfileController getProfileController =
      Get.put(GetProfileController());
  BookmarkController _bookmarkController = Get.put(BookmarkController());
  final HomeController _homeController = Get.put(HomeController());
  Future viewOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(Appurl.detailspage + widget.Id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future viewrelatedProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(
        Uri.parse(Appurl.relatedproduct + widget.productId),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['result'];
      // Get.back;

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_related;
  Future? viewall_experience;
  @override
  void initState() {
    viewall_related = viewrelatedProduct();
    viewall_experience = viewOffers();
    print(widget.Id);
    print("details " + widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder(
            future: viewall_experience,
            builder: (_, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        children: <Widget>[
                          Positioned(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .5,
                              child: CarouselSlider.builder(
                                itemCount: snapshot.data[0]['image'].length,
                                options: CarouselOptions(
                                  // enableInfiniteScroll: true,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlay: snapshot.data[0]['image'].length > 1
                                      ? true
                                      : false,
                                  aspectRatio: 16 / 10,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  viewportFraction: 1.0,
                                ),
                                itemBuilder: (context, index, realIdx) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            ApiConstant.media_base_url +
                                                snapshot.data[0]['image'][index]
                                                        ["file_path"]
                                                    .toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                              right: 7,
                              bottom: 0,
                              child: Row(
                                children: [
                                  Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: IconButton(
                                        onPressed: () async {
                                          if (snapshot.data[0]['bookmark'] ==
                                              true) {
                                            var status =
                                                await _bookmarkController
                                                    .removeBookmarkProduct(
                                                        _homeController
                                                            .tokenGlobal,
                                                        snapshot.data[0]
                                                            ["product_id"]);

                                            if (status == 200) {
                                              snapshot.data[0]['bookmark'] =
                                                  false;
                                              print("bookmark removed");
                                              setState(() {});
                                            }
                                          } else {
                                            var status =
                                                await _bookmarkController
                                                    .addBookmarkProduct(
                                                        _homeController
                                                            .tokenGlobal,
                                                        snapshot.data[0]
                                                            ["product_id"]);

                                            if (status == 200) {
                                              print(
                                                  snapshot.data[0]['bookmark']);
                                              print("bookmark added");
                                              snapshot.data[0]['bookmark'] =
                                                  true;
                                              setState(() {});
                                            }
                                          }
                                        },
                                        icon: snapshot.data[0]['bookmark'] ==
                                                true
                                            ? Icon(
                                                Icons.favorite,
                                                color: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                size: 25,
                                              )
                                            : Icon(
                                                Icons.favorite_border_outlined,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                size: 25,
                                              ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(23)),
                                    child: IconButton(
                                        onPressed: () {
                                          Share.share(
                                              'https://play.google.com/store/apps/details?id=com.svkraft.com');
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                  ),
                                ],
                              )),

                          //Container
                          //Container
                        ], //<Widget>[]
                      ), //Stack
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 15),
                      child: Row(
                        children: [
                          Text("Posted 20 nov. 16:04",
                              style: TextStyle(
                                fontSize: 10,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Dhaka",
                            style: TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            snapshot.data[0]['product_name'].toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            "${snapshot.data[0]['price'].toString()} " +
                                "kr".tr,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Text(
                            "Location".tr,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${snapshot.data[0]['location'].toString()}".tr,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * .93,
                          height: 55,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              )),
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 52, 161, 79),
                              ),
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mail_outline),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Chat".tr,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                            onPressed: () {
                              // Get.to(() =>
                              // WebViewExample(
                              //       id1:
                              //           '${getProfileController.userProfileModel.value.data!.id}',
                              //       id2: '${snapshot.data[0]["seller_id"]}',
                              //     ));
                              Get.to(Chatbox(
                                userId: snapshot.data[0]["seller_id"] != null
                                    ? snapshot.data[0]["seller_id"]
                                    : 0,
                                image: Appurl.baseURL +
                                            snapshot.data[0]["seller_image"] !=
                                        null
                                    ? Appurl.baseURL +
                                        snapshot.data[0]["seller_image"]
                                    : "0",
                                name: snapshot.data[0]["seller_name"] != null
                                    ? snapshot.data[0]["seller_name"].toString()
                                    : "0",
                                email: snapshot.data[0]["seller_email"] != null
                                    ? snapshot.data[0]["seller_email"]
                                        .toString()
                                    : "0",
                                phone: snapshot.data[0]["seller_phone"] != null
                                    ? snapshot.data[0]["seller_phone"]
                                        .toString()
                                    : "0",
                              ));
                            },
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .93,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // FlutterPhoneDirectCaller.callNumber(
                            //     "+8801402585605");
                            // launchUrl('tel/')
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                left: 85,
                                top: 12,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.phone, color: Colors.black),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch(
                                      "tel://${snapshot.data[0]["seller_phone"]}");
                                },
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Telephone  number".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            )),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 20),
                      child: Row(
                        children: [
                          Text(
                            "Seller details".tr,
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => Sellerdetils(
                                    sellerId:
                                        snapshot.data[0]["seller_id"] != null
                                            ? snapshot.data[0]["seller_id"]
                                                .toString()
                                            : "0",
                                    sellerImage:
                                        snapshot.data[0]["seller_image"] != null
                                            ? snapshot.data[0]["seller_image"]
                                            : "",
                                    sellerName:
                                        snapshot.data[0]["seller_name"] != null
                                            ? snapshot.data[0]["seller_name"]
                                            : "",
                                    sellerNumber:
                                        snapshot.data[0]["seller_phone"] != null
                                            ? snapshot.data[0]["seller_phone"]
                                            : "",
                                    email:
                                        snapshot.data[0]["seller_email"] != null
                                            ? snapshot.data[0]["seller_email"]
                                            : "",
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 1),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(23)),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .05),
                                            child: Text(
                                              "${snapshot.data[0]["seller_name"].toString()}"
                                                  .tr,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15),
                                              child: Text("User since 2018".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "1 active",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.black,
                              ))),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 15, bottom: 15),
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //         "images/blue.png",
                    //         height: MediaQuery.of(context).size.height * .06,
                    //         width: MediaQuery.of(context).size.width * .07,
                    //       ),
                    //       Text(
                    //         "sellers telegram",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "details".tr,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    snapshot.data[0]["category_name"] != "Vehicle"
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "${snapshot.data[0]["description"].toString()}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Trygg affar",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/fuels.png",
                                          height: 60,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Fuel type".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                  "${snapshot.data[0]["fuel"].toString()}"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .11,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/gear.png",
                                          height: 57,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Gear type".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "${snapshot.data[0]["gearbox"].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Image.asset(
                                            "images/meter.png",
                                            height: 60,
                                            width: 40,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Milage".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "${snapshot.data[0]["milage"].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .11,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                            "images/cala.png",
                                            height: 57,
                                            width: 50,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Model".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "${snapshot.data[0]["model"].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Image.asset(
                                            "images/brand.png",
                                            height: 50,
                                            width: 40,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Brand".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(0),
                                              child: Text(
                                                "${snapshot.data[0]['brand'].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "images/spee.png",
                                          height: 57,
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text("Speed".tr),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                "${snapshot.data[0]["speeds"].toString()}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          1.80,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.13,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(Scaffold(
                                                appBar: AppBar(),
                                                body: Container(
                                                    height: 100,
                                                    width: double.infinity,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    child: Center(
                                                      child: Text(
                                                        "text",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ))));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                    backgroundColor:
                                                        Colors.white,
                                                    enableDrag: true,
                                                    isScrollControlled: true,
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .1,
                                                          width:
                                                              double.infinity,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/spee.png",
                                                                        height:
                                                                            57,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text("Speed".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data[0]["speeds"].toString()}",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/gear.png",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Text("Gear type".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data[0]["gearbox"].toString()}",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: MediaQuery.of(context).size.width * .01),
                                                                        child: Image
                                                                            .asset(
                                                                          "images/cc.jpeg",
                                                                          height:
                                                                              MediaQuery.of(context).size.height * .09,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .1,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .02,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Text("C.c".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data[0]["c_c"].toString()}",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .01,
                                                                  ),
                                                                  snapshot.data[0]
                                                                              [
                                                                              "brand"] !=
                                                                          null
                                                                      ? Row(
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .019),
                                                                              child: Image.asset(
                                                                                "images/brand.png",
                                                                                height: 50,
                                                                                width: 40,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: MediaQuery.of(context).size.width * .05,
                                                                            ),
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(0),
                                                                                  child: Text("Brand".tr),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.all(0),
                                                                                  child: Text(
                                                                                    "${snapshot.data[0]["brand"].toString()}",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .20,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/fuels.png",
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Text("Fuel type".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.bottomLeft,
                                                                              child: Text("${snapshot.data[0]["fuel"].toString()}"),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/meter.png",
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            40,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text("Milage".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data[0]["milage"].toString()}",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        "images/cala.png",
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Text("Model".tr),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child:
                                                                                Text(
                                                                              "${snapshot.data[0]["model"].toString()}",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                  // Row(
                                                                  //   children: [
                                                                  //     Image
                                                                  //         .asset(
                                                                  //       "images/cala.png",
                                                                  //       height:
                                                                  //           50,
                                                                  //       width:
                                                                  //           50,
                                                                  //     ),
                                                                  //     Column(
                                                                  //       mainAxisAlignment:
                                                                  //           MainAxisAlignment.start,
                                                                  //       crossAxisAlignment:
                                                                  //           CrossAxisAlignment.start,
                                                                  //       children: [
                                                                  //         Padding(
                                                                  //           padding:
                                                                  //               EdgeInsets.all(0),
                                                                  //           child:
                                                                  //               Text("Model".tr),
                                                                  //         ),
                                                                  //         Padding(
                                                                  //           padding:
                                                                  //               EdgeInsets.all(0),
                                                                  //           child:
                                                                  //               Text(
                                                                  //             "${snapshot.data[0]["model"].toString()}",
                                                                  //             style: TextStyle(fontWeight: FontWeight.bold),
                                                                  //           ),
                                                                  //         ),
                                                                  //       ],
                                                                  //     )
                                                                  //   ],
                                                                  // ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ));
                                              },
                                              child: Text(
                                                "All specs",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "About this car",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${snapshot.data[0]["description"].toString()}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Trygg affar",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                    FutureBuilder(
                      future: viewall_related,
                      builder: (_, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          return Container(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Detailss(
                                                  Id: snapshot.data[index]
                                                          ["product_id"]
                                                      .toString(),
                                                  productId: snapshot
                                                      .data[index]["product_id"]
                                                      .toString(),
                                                )));
                                    print("this is id  " +
                                        snapshot.data[index]["id"].toString() +
                                        "this is product_id  " +
                                        snapshot.data[index]["product_id"]
                                            .toString());
                                  },
                                  leading: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .05),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .4,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .13,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            Appurl.baseURL +
                                                snapshot.data[index]["image"],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ),
                                  title: Text(snapshot.data[index]
                                          ["product_name"]
                                      .toString()),
                                  subtitle: Text(
                                      snapshot.data[index]["price"].toString() +
                                          "kr".tr),
                                );
                              },
                            ),
                          );
                        } else {
                          return Text("No productt found");
                        }
                      },
                    ),
                  ],
                  //Center
                );
              } else {
                return Text("No productt found");
              }
            },
          ),
        ],
      )),
    ));
  }
}
