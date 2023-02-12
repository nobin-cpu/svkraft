import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/model/sub_item_model.dart';
import 'package:sv_craft/Features/market_place/controller/dproduct_details_controller.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/main.dart';
import 'package:sv_craft/services/services.dart';

import '../../chat/view/chat_screen.dart';
import '../../home/controller/home_controller.dart';
import '../../profile/controller/get_profile_con.dart';
import '../messaging/UserChat_screen.dart';
import 'package:http/http.dart' as http;

class MarketProductDetails extends StatefulWidget {
  const MarketProductDetails({
    Key? key,
     this.id,
    this.from,
  }) : super(key: key);
  final int? id;
  final String? from;

  @override
  State<MarketProductDetails> createState() => _MarketProductDetailsState();
}

class _MarketProductDetailsState extends State<MarketProductDetails> {
  HomeController _homeController = Get.put(HomeController());
  GetProfileController getProfileController = Get.put(GetProfileController());

  final List<String> imagesList = [];
  String userMarkeID = '';
  var phone = ''.obs;
  var marketUserName = "";
  var prodID = "";
  bool isPreview = false;
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    setTokenToVariable();

    super.initState();
  }

  Future<void> setTokenToVariable() async {
    var profile =
        await getProfileController.getProfile(_homeController.tokenGlobal);
    if (profile != null) {
      print("profile::::::${widget.id}");
      productDetailsController.getMarketPlaceModel(token, widget.id.toString());
    }
  }

  final List<String> imgList = [
    'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg?auto=compress&cs=tinysrgb&w=600'
  ];

  // var userData;

  // Future fetchUser() async {
  //   var response =
  //       await http.get(Uri.parse('http://gigsoft.net/api/product/0'));
  //   setState(() {
  //     var decode = jsonDecode(response.body);

  //     userData = decode['data'];
  //     // print(userData);
  //   });
  // }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //  fetchUser();
  // }

  // bool isproductdLoading = false;
  // bool isproductByIdLoading = false;
  // bool isClicked = false;
  // // var subItemModel;
  // List productData = [];
  // void getProductbyId(String id) async {
  //   setState(() {
  //     isproductdLoading = true;
  //   });
  //   var url = Appurl.baseURL + "api/product/v2/find/$id";
  //   try {
  //     http.Response response =
  //         await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

  //     if (response.statusCode == 200) {
  //       final list = jsonDecode(response.body);
  //       productData = list['data'] as List;
  //     } else {
  //       print('Product not found');
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         "Error",
  //         e.toString());
  //   }
  //   setState(() {
  //     isproductByIdLoading = false;
  //     isClicked = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        color: Colors.white,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blue,
                            child: Container(
                                child: CarouselSlider(
                              options: CarouselOptions(
                                  disableCenter: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9),
                              items: imgList
                                  .map((item) => Container(
                                        child: Image.network(
                                          item.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  .toList(),
                            )),
                          ),
                        ],
                      ),
                      // const Positioned(
                      //     bottom: 20,
                      //     left: 16,
                      //     child: Text(
                      //       "The Forza horizon 4",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold, fontSize: 22),
                      //     )),
                      // ignore: prefer_const_constructors
                      // Positioned(
                      //     bottom: 30,
                      //     right: 10,
                      //     child: Row(
                      //       children: const [
                      //         Icon(
                      //           Icons.favorite,
                      //           color: Colors.red,
                      //           size: 50,
                      //         ),
                      //         SizedBox(width: 10),
                      //         Icon(
                      //           Icons.share_outlined,
                      //           color: Colors.blue,
                      //           size: 50,
                      //         ),
                      //       ],
                      //     )),
                    ],
                  ),
///////end stack slider for image
                  ///
                  ///
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text("48,800 kr"),
                  //       const SizedBox(height: 10),
                  //       GestureDetector(
                  //         onTap: () {
                  //           getProfileController.userProfileModel.value.data!.id
                  //                       .toString() ==
                  //                   userMarkeID
                  //               ? Get.snackbar(
                  //                   backgroundColor: Colors.red,
                  //                   colorText: Colors.white,
                  //                   "Message response",
                  //                   "You can't chat with you")
                  //               : Get.to(ChatScreen(
                  //                   name: marketUserName,
                  //                   receiverUid: userMarkeID,
                  //                   // productId: prodID,
                  //                   // userName: userName,
                  //                 ));
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Container(
                  //             height: 45,
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //               color: Colors.blue,
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: const [
                  //                 Icon(
                  //                   Icons.chat,
                  //                   color: Colors.white,
                  //                 ),
                  //                 SizedBox(width: 6),
                  //                 Text(
                  //                   'Chat',
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontWeight: FontWeight.w500,
                  //                       fontSize: 16),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(height: 10),
                  //       const Text(
                  //         "Profile",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18),
                  //       ),
                  //       const SizedBox(height: 10),
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const CircleAvatar(
                  //             radius: 35,
                  //             backgroundImage: NetworkImage(
                  //                 "https://images.pexels.com/photos/13861/IMG_3496bfree.jpg?auto=compress&cs=tinysrgb&w=600"),
                  //           ),
                  //           const SizedBox(width: 10),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: const [
                  //               Text(
                  //                 "Mangus Persone",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 18),
                  //               ),
                  //               Text("pg blokkersd 2014"),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 10),
                  //       Padding(
                  //         padding: const EdgeInsets.all(16),
                  //         child: GridView.builder(
                  //             itemCount: 12,
                  //             shrinkWrap: true,
                  //             primary: false,
                  //             physics: BouncingScrollPhysics(),
                  //             gridDelegate:
                  //                 const SliverGridDelegateWithFixedCrossAxisCount(
                  //                     crossAxisCount: 2,
                  //                     mainAxisSpacing: 5,
                  //                     mainAxisExtent: 50),
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return SizedBox(
                  //                 height: 100,
                  //                 child: Row(
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     const Icon(Icons.gas_meter_outlined,
                  //                         size: 25),
                  //                     const SizedBox(width: 8),
                  //                     Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         SizedBox(
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.26,
                  //                           child: const Text(
                  //                             "Virualh sj ",
                  //                             maxLines: 1,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                                 color: Colors.black54,
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.bold),
                  //                           ),
                  //                         ),
                  //                         const SizedBox(height: 2),
                  //                         SizedBox(
                  //                           width: MediaQuery.of(context)
                  //                                   .size
                  //                                   .width *
                  //                               0.23,
                  //                           child: const Text(
                  //                             "Manuell jhasf ashf hh",
                  //                             maxLines: 1,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: TextStyle(
                  //                                 color: Colors.black,
                  //                                 fontSize: 11,
                  //                                 fontWeight: FontWeight.w500),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //             }),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Inlagd i tisdags 21;00',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "örenbro",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ))
                                ],
                              ),
                              Text(
                                'Volkswagen T-Roc TSI 190\nDSG 4M GT/Varmare/Drag',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '269,000 kr',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '269,000 kr ex moms',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.13,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mail_outline_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Mejla",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.11,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.phone_in_talk,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Visa telefonnr.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              Text(
                                "Säljes av",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Möller Bll örebro Beg",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Företag",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              Image(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                height: 30,
                                width: 50,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kategori",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.search_sharp,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                "Bilar",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              Text(
                                "Fakta",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: 6,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5,
                                          mainAxisExtent: 50),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      height: 100,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.gas_meter_outlined,
                                              size: 40),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                child: Text(
                                                  "Växellåda",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                child: Text(
                                                  "Manuell",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.13,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Visa all fakta",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .030,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .030,
                              ),
                              Text(
                                "Infor Kopets",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .030,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kontrollerad pa 122punkter.\nlas mer om Das Welt Auto",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Annons",
                                                    style: TextStyle(
                                                        background: Paint()
                                                          ..color =
                                                              Colors.blue),
                                                    // color: Colors.black,
                                                    // fontSize: 20,
                                                    // fontWeight: FontWeight.bold),
                                                  ),
                                                  Image(
                                                    image: NetworkImage(
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                                    height: 30,
                                                    width: 50,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .030,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kontrollerad pa 122punkter.\nlas mer om Das Welt Auto",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Bilar",
                                                    style: TextStyle(
                                                        background: Paint()
                                                          ..color =
                                                              Colors.blue),
                                                    // color: Colors.black,
                                                    // fontSize: 20,
                                                    // fontWeight: FontWeight.bold),
                                                  ),
                                                  Image(
                                                    image: NetworkImage(
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                                    height: 30,
                                                    width: 50,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .040,
                              ),
                              Text(
                                "Untrustning",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        minLeadingWidth: 1,
                                        horizontalTitleGap: 2,
                                        leading: Icon(Icons.check,
                                            color: Colors.green),
                                        title: Text("V8 4.6L 300hk",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600)),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.13,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Visa all utrusting",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              Text(
                                "Beskrivning",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .010,
                              ),
                              Text(
                                "Nedsatt Faran: 195 000kr,\nOBS! endast 7292 mil 18 blank svart Bullit",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Trygg affar",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kontrollerad pa 122punkter.\nlas mer om Das Welt Auto",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Image(
                                            image: NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                            height: 30,
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 1.80,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Kontrollerad pa 122punkter.\nlas mer om Das Welt Auto",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Image(
                                            image: NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                            height: 30,
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 1.80,
                                height:
                                    MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "KC BIL & Truck",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6JVW240Mq5PP7KiYg_MGDyMKF_L4ytPhMQ&usqp=CAU'),
                                          height: 30,
                                          width: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .020,
                              ),
                              Text(
                                "Kontrollerad pa 122punkter.\nlas mer om Das Welt Auto",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Icon(Icons.house_outlined),
                                          Text(
                                            "KC BIL & Truck",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .010,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Icon(Icons.insert_link_outlined),
                                          Text(
                                            "http://wwe.orrbys.se",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .010,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(
                                            "Kryptongatan 2",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.80,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Kop online hos DNB",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    Text(
                                      "Mer fran bilskiftet",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ListView.builder(
                                          itemCount: 4,
                                          shrinkWrap: true,
                                          primary: false,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                              minLeadingWidth: 1,
                                              horizontalTitleGap: 2,
                                              title: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .08,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRty-5enW7Ai328L_BkIFJaaORZorcmbMMTQ&usqp=CAU'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .020,
                                                        ),
                                                        Text("V8 4.6L 300hk",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .67,
                                                      child: Text("295,000 kr",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .010,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.80,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Kop online hos DNB",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.roller_shades_outlined),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .020,
                                            ),
                                            Text(
                                              "Anmal annans",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    Text(
                                      "Hjalp och tips",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    Text(
                                      "kundservice",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    Text(
                                      "Tips och inspiration",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .020,
                                    ),
                                    Text(
                                      "kundsaerhet",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .020),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height:
                                      MediaQuery.of(context).size.width * 0.10,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Mejla",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height:
                                      MediaQuery.of(context).size.width * 0.10,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "visa telefonnr",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .030,
                          ),
                        ],
                      )),
                ],
              ),
            )),

        // bottomNavigationBar: widget.from == null
        //     ? BottomAppBar(
        //         elevation: 0,
        //         child: Container(
        //           height: 60,
        //           decoration: const BoxDecoration(
        //               color: Colors.white,
        //               borderRadius:
        //                   BorderRadius.vertical(top: Radius.circular(0.0))),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: <Widget>[
        //               Expanded(
        //                 child: GestureDetector(
        //                   onTap: () async {
        //                     var url = Uri.parse("tel:$phone");
        //                     await launchUrl(url);
        //                   },
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       alignment: Alignment.center,
        //                       decoration: BoxDecoration(
        //                         color: Appcolor.primaryColor,
        //                         borderRadius: BorderRadius.circular(8),
        //                         boxShadow: const [
        //                           BoxShadow(
        //                             color: Colors.black12, //color of shadow
        //                             spreadRadius: 2, //spread radius
        //                             blurRadius: 5, // blur radius
        //                             offset: Offset(
        //                                 0, 2), // changes position of shadow
        //                           )
        //                         ],
        //                       ),
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: const [
        //                           Icon(
        //                             Icons.call,
        //                             color: Colors.white,
        //                           ),
        //                           SizedBox(width: 6),
        //                           Text(
        //                             'Call',
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontWeight: FontWeight.w500,
        //                                 fontSize: 16),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),

        //               Expanded(
        //                   child:

        //                   GestureDetector(
        //                 onTap: () {
        //                   getProfileController.userProfileModel.value.data!.id
        //                               .toString() ==
        //                           userMarkeID
        //                       ? Get.snackbar(
        //                           backgroundColor: Colors.red,
        //                           colorText: Colors.white,
        //                           "Message response",
        //                           "You can't chat with you")
        //                       : Get.to(ChatScreen(
        //                           name: marketUserName,
        //                           receiverUid: userMarkeID,
        //                           // productId: prodID,
        //                           // userName: userName,
        //                         ));
        //                 },
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Container(
        //                     alignment: Alignment.center,
        //                     decoration: BoxDecoration(
        //                       color: Colors.blue,
        //                       borderRadius: BorderRadius.circular(8),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           color: Colors.blue, //color of shadow
        //                           spreadRadius: 2, //spread radius
        //                           blurRadius: 5, // blur radius
        //                           offset: Offset(
        //                               0, 2), // changes position of shadow
        //                         )
        //                       ],
        //                     ),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: const [
        //                         Icon(
        //                           Icons.chat,
        //                           color: Colors.white,
        //                         ),
        //                         SizedBox(width: 6),
        //                         Text(
        //                           'Chat',
        //                           style: TextStyle(
        //                               color: Colors.white,
        //                               fontWeight: FontWeight.w500,
        //                               fontSize: 16),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               )),

        //               Expanded(
        //                 child: GestureDetector(
        //                   onTap: () {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => SellerProfile(
        //                           sellerId: (userMarkeID.toString()),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Container(
        //                       alignment: Alignment.center,
        //                       decoration: BoxDecoration(
        //                         color: Appcolor.buttonColor,
        //                         borderRadius: BorderRadius.circular(8),
        //                         boxShadow: const [
        //                           BoxShadow(
        //                             color: Colors.black12, //color of shadow
        //                             spreadRadius: 2, //spread radius
        //                             blurRadius: 5, // blur radius
        //                             offset: Offset(
        //                                 0, 2), // changes position of shadow
        //                           )
        //                         ],
        //                       ),
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: const [
        //                           Icon(
        //                             Icons.account_circle,
        //                             color: Colors.black,
        //                           ),
        //                           SizedBox(width: 6),
        //                           Text(
        //                             'Profile',
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontWeight: FontWeight.w500,
        //                                 fontSize: 16),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               //add as many tabs as you want here
        //             ],
        //           ),
        //         ),
        //       )
        //     : const SizedBox(
        //         height: 0,
        //       ),
      ),
    );
  }

  String imagePath = "";
  Image previewedImage(Size size) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      height: size.height * 0.4,
      width: size.width * 0.8,
    );
  }

  //chanage
}
