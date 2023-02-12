import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/bookmarks/controller/add_to_bookmarks_con.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_add_product.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/grocery/view/see_all_products.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/constant/api_link.dart';

import 'grocery_count.dart';

class GroceryDetails extends StatefulWidget {
  final String Id;
  const GroceryDetails({super.key, required this.Id});

  @override
  State<GroceryDetails> createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
  final AddtoBookmarksController _addtoBookmarksController =
      Get.put(AddtoBookmarksController());
  final BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  final HomeController _homeController = Get.put(HomeController());
  final BookmarkProductAddController _bookmarkProductAddController =
      Get.put(BookmarkProductAddController());
  final TextEditingController _categoryController = TextEditingController();
  // Variable
  Future viewgrocery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(Appurl.grocerydetails + widget.Id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_grocery;

  @override
  void initState() {
    viewall_grocery = viewgrocery();

    print(widget.Id);
    print("details " + widget.Id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 135, 235, 157),
        appBar: AppBar(
          centerTitle: true,
          title: Text("filter product".tr),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 10,
                  child: Text(""),
                ),
                FutureBuilder(
                  future: viewall_grocery,
                  builder: (_, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      snapshot.data[index]["title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(SeeAllProductsScreen(
                                          title: snapshot.data[index]["title"],
                                          id: snapshot.data[index]["id"]
                                              .toString(),
                                        ));
                                      },
                                      child: Text(
                                        "View All".tr,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors
                                              .transparent, // Step 2 SEE HERE
                                          shadows: [
                                            Shadow(
                                                offset: Offset(0, -6),
                                                color: Colors.black)
                                          ], // Step 3 SEE HERE
                                          decoration: TextDecoration.underline,

                                          decorationColor:
                                              Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .78,
                                child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1,
                                            mainAxisExtent:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .4,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        snapshot.data[index]["lists"].length,
                                    itemBuilder: (context, index2) {
                                      return Card(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .06,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          _bookmarkCategoryController
                                                                      .BookmarkCategory
                                                                      .length >
                                                                  0
                                                              ? Get.dialog(
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        'Add To Bookmarks.'
                                                                            .tr),
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * .2,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .6,
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              itemCount: _bookmarkCategoryController.BookmarkCategory.length,
                                                                              itemBuilder: (context, ind) {
                                                                                return Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(0),
                                                                                    boxShadow: const [
                                                                                      BoxShadow(
                                                                                        color: Colors.black12, //color of shadow
                                                                                        spreadRadius: 1, //spread radius
                                                                                        blurRadius: 0, // blur radius
                                                                                        offset: Offset(0, 0), // changes position of shadow
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  width: MediaQuery.of(context).size.width * .4,
                                                                                  height: 40,
                                                                                  child: InkWell(
                                                                                    onTap: () async {
                                                                                      var status = await _bookmarkProductAddController.addBookmarkProduct(_homeController.tokenGlobal, _bookmarkCategoryController.BookmarkCategory[ind].id, snapshot.data[index]["id"].toString());
                                                                                      if (status == 200) {
                                                                                        setState(() {});
                                                                                        Get.back();
                                                                                        Get.snackbar('Success'.tr, 'Product Added To Bookmark'.tr);
                                                                                        print("objectss" + _bookmarkCategoryController.BookmarkCategory[ind].id);
                                                                                      }
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        const Icon(Icons.list),
                                                                                        const SizedBox(width: 20),
                                                                                        Text(
                                                                                          _bookmarkCategoryController.BookmarkCategory[ind].name,
                                                                                          style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                                          textAlign: TextAlign.center,
                                                                                        ),
                                                                                        const Spacer(),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    // actions: [],
                                                                  ),
                                                                  barrierDismissible:
                                                                      false,
                                                                )
                                                              : Get.dialog(
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        'Add Bookmarks Category'
                                                                            .tr),
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        TextFormField(
                                                                          controller:
                                                                              _categoryController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                'Category Name'.tr,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Text('Cancel'.tr),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              var statusCode = await _bookmarkCategoryController.addBookmarkCategory(_homeController.tokenGlobal, _categoryController.text);

                                                                              if (statusCode == 200) {
                                                                                _categoryController.clear();
                                                                                // Get.back();
                                                                                setState(() {});
                                                                                Get.off(GroceryProduct());
                                                                                Get.snackbar('Success'.tr, 'Category Added'.tr);
                                                                              } else {
                                                                                Get.back();
                                                                                Get.snackbar('Error'.tr, 'Category Not Added'.tr);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text('Add'.tr),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  barrierDismissible:
                                                                      false,
                                                                );

                                                          // var message =
                                                          //     await _addtoBookmarksController
                                                          //         .addToBookmarks(
                                                          //             userId,
                                                          //             data[index].id,
                                                          //             "grocery",
                                                          //             tokenp);

                                                          // if (message != null) {
                                                          //   Get.snackbar(
                                                          //       "Product Added to Bookmarks",
                                                          //       message);
                                                          // } else {
                                                          //   print("Not Added");
                                                          // }
                                                        },
                                                        icon: Icon(Icons
                                                            .favorite_border_outlined)),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .18,
                                                    ),
                                                    Text(snapshot.data[index]
                                                            ["lists"][index2]
                                                            ["market_price"]
                                                        .toString()),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .01),
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .20,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .4,
                                                  child: InkWell(
                                                      onTap: () {
                                                        // Get.to(() => Detailss(
                                                        //       Id: snapshot.data[index]["id"]
                                                        //           .toString(),
                                                        //       productId: snapshot.data[index]
                                                        //               ["product_id"]
                                                        //           .toString(),
                                                        //     ));
                                                      },
                                                      child: Center(
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  Appurl.baseURL +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                              [
                                                                              "lists"]
                                                                              [
                                                                              index2]
                                                                              [
                                                                              "image"]
                                                                          .toString(),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 140,
                                                                  height: 140,
                                                                ),
                                                              ),
                                                            ),
                                                            snapshot.data[index]["lists"]
                                                                            [
                                                                            index2]
                                                                        [
                                                                        "off_price"] ==
                                                                    0
                                                                ? SizedBox()
                                                                : Positioned(
                                                                    top: 0,
                                                                    right: 0,
                                                                    child:
                                                                        Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          .08,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .12,
                                                                      color: Colors
                                                                          .yellowAccent,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          snapshot.data[index]["lists"][index2]["ar_off_price"].toString() +
                                                                              "% off",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.red),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    // Get.to(() => Detailss(
                                                    //       Id: snapshot.data[index]["id"]
                                                    //           .toString(),
                                                    //       productId: snapshot.data[index]
                                                    //               ["product_id"]
                                                    //           .toString(),
                                                    //     ));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .03),
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(snapshot
                                                              .data[index]
                                                                  ["lists"]
                                                                  [index2]
                                                                  ["name"]
                                                              .toString()),
                                                          Text(
                                                            snapshot.data[index]
                                                                        [
                                                                        "lists"]
                                                                        [index2]
                                                                        [
                                                                        "pricee"]
                                                                    .toString() +
                                                                "kr".tr,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          // snapshot != null
                                                          //     ? GroceryCount(
                                                          //         index:
                                                          //             index,
                                                          //         // userId: userId,
                                                          //         productId: snapshot.data[index]
                                                          //                 [
                                                          //                 "lists"]
                                                          //             [
                                                          //             index2]["id"],
                                                          //         price: snapshot.data[index]["lists"]
                                                          //                 [
                                                          //                 index2]
                                                          //             [
                                                          //             "price"],
                                                          //       )
                                                          //     : const Center(
                                                          //         child: Center(
                                                          //             child: SpinKitFadingCircle(
                                                          //         color: Colors
                                                          //             .black,
                                                          //       ))),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return Text("No productt found");
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
