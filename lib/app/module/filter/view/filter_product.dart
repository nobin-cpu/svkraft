import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/chat/view/chat_screen.dart';
import 'package:sv_craft/Features/market_place/view/details.dart';
import 'package:sv_craft/Features/market_place/view/telephone.dart';
import 'package:sv_craft/Features/seller_profile/view/profile.dart';
import 'package:sv_craft/app/module/filter/controller/filter_product_con.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Features/chat/view/recent_chats.dart';
import '../../../../Features/home/home_screen.dart';
import '../../../../Features/market_place/view/bookmarked_product.dart';
import '../../../../Features/market_place/view/market_place.dart';
import '../../../../Features/market_place/view/market_product_details.dart';
import '../../../../Features/market_place/widgets/filter_box_widgets.dart';
import '../../../../Features/profile/controller/get_profile_con.dart';
import '../../../../Features/profile/view/profile_screen.dart';
import '../../../../Features/seller_profile/models/seller_profile_model.dart';
import '../../../../Features/seller_profile/view/conto.dart';
import '../../../../constant/color.dart';
import 'dart:developer' as devlog;

class FilterProducts extends StatefulWidget {
  @override
  State<FilterProducts> createState() => _FilterProductsState();
}

class _FilterProductsState extends State<FilterProducts> {
  final filterProductCon = Get.put(FilterProductController());
  final GetProfileController getProfileController =
      Get.put(GetProfileController());

  var _selectedIndex = 2;
  PageController? _pageController;
  SellerProfile? sellerProfile;
  // List productsItems = [];
  // bool itmesLoading = false;
  // int selectIndex = 0;
  List productsItems = [];
  bool itmesLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(MarketPlace());
            },
            icon: Icon(Icons.arrow_back_outlined)),
        title: Text("filter product".tr),
        centerTitle: true,
      ),
      body: Obx(
        () => filterProductCon.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : filterProductCon.realdata.isEmpty
                ? Center(
                    child: Text(
                      "Opps!! No Data Found",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(8),
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: filterProductCon.realdata.length,
                        itemBuilder: (
                          _,
                          itemIndex,
                        ) {
                          // devlog.log(productsItems[itemIndex].toString());

                          return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(Detailss(
                                      Id: filterProductCon
                                          .realdata[itemIndex].productId
                                          .toString(),
                                      productId: filterProductCon
                                          .realdata[itemIndex].productId
                                          .toString()));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .17,
                                  width: double.infinity,
                                  color: Color.fromARGB(255, 254, 254, 254),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .13,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  Appurl.baseURL +
                                                      filterProductCon
                                                          .realdata[itemIndex]
                                                          .image
                                                          .toString(),
                                                ))),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 4, left: 5)),
                                              Text(
                                                filterProductCon
                                                    .realdata[itemIndex]
                                                    .productName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2, left: 5)),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 0),
                                                child: Row(
                                                  children: [
                                                    Card(
                                                      child: Text(
                                                        "Fortag",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      color: Colors.black12,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Id:${filterProductCon.realdata[itemIndex].productId}",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4),
                                                child: Text(
                                                  filterProductCon
                                                          .realdata[itemIndex]
                                                          .model
                                                          .toString() +
                                                      "  " +
                                                      filterProductCon
                                                          .realdata[itemIndex]
                                                          .gearbox
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Row(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Text(
                                                        "price".tr +
                                                            filterProductCon
                                                                .realdata[
                                                                    itemIndex]
                                                                .price
                                                                .toString() +
                                                            " kr",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                          // return  Card(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Navigator.push(
                          //       //   context,
                          //       //   MaterialPageRoute(
                          //       //       builder: (context) => MarketProductDetails(
                          //       //         id: productsItems[itemIndex]['id'],
                          //       //       )),
                          //       // );
                          //     },
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(4.0),
                          //       child: Stack(
                          //         children: [
                          //           Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Image.network(
                          //                 Appurl.baseURL +
                          //                     filterProductCon.realdata[itemIndex].image.toString(),
                          //                 height: 140,
                          //                 width: 160,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //               const SizedBox(height: 6),
                          //               Padding(
                          //                 padding: const EdgeInsets.symmetric(horizontal: 6),
                          //                 child: Row(
                          //                   mainAxisAlignment: MainAxisAlignment.center,
                          //                   children: [
                          //                     Text('${filterProductCon.realdata[itemIndex].price} Kr',
                          //                         style: const TextStyle(
                          //                             color: Colors.black,
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.normal)),
                          //                     const SizedBox(
                          //                       width: 5,
                          //                     ),
                          //                     SizedBox(
                          //                       width: MediaQuery.of(context).size.width * .2,
                          //                       child: Text(
                          //                         filterProductCon.realdata[itemIndex].productName.toString(),
                          //                         softWrap: false,
                          //                         style: const TextStyle(
                          //                             color: Colors.black,
                          //                             fontWeight: FontWeight.normal,
                          //                             fontSize: 16.0),
                          //                         overflow: TextOverflow.ellipsis,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           // Positioned(
                          //           //     right: 10,
                          //           //     top: 0,
                          //           //     child: IconButton(
                          //           //       onPressed: () async {
                          //           //         var status =
                          //           //         await _bookmarkController.addBookmarkProduct(
                          //           //             _homeController.tokenGlobal,
                          //           //             productsItems[itemIndex]['id']);
                          //           //
                          //           //         if (status == 200) {
                          //           //           Get.snackbar(
                          //           //               backgroundColor: Colors.green,
                          //           //               colorText: Colors.white,
                          //           //               'Success',
                          //           //               'Product Added To Bookmark');
                          //           //           productsItems[itemIndex]['bookmark'] = true;
                          //           //         }
                          //           //         //  getDataFromProductID(
                          //           //         //     _categoryData[selectIndex].id.toString());
                          //           //         setState(() {});
                          //           //       },
                          //           //       icon: productsItems[itemIndex]['bookmark']
                          //           //           ? const Icon(
                          //           //         FontAwesome.book_bookmark,
                          //           //         color: Colors.blue,
                          //           //         size: 25,
                          //           //       )
                          //           //           : const Icon(
                          //           //         FontAwesome.bookmark,
                          //           //         color: Colors.black,
                          //           //         size: 25,
                          //           //       ),
                          //           //     )),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }),
                  ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Appcolor.primaryColor,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController?.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);

          if (_selectedIndex == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (_selectedIndex == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RecentChats()),
            );
          } else if (_selectedIndex == 2) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileScreen()),
            // );

          } else if (_selectedIndex == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookmarkedProductScreen()),
            );
          } else if (_selectedIndex == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                        from: "market",
                      )),
            );
          }
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.chat),
              title: const Text('Chat'),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: const Icon(Icons.filter_alt),
              title: Text(
                "filter product".tr,
                overflow: TextOverflow.ellipsis,
              ),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: const Icon(Icons.favorite),
              title: Text('Bookmarks'.tr),
              activeColor: Colors.white),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Colors.white),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
