import 'dart:async';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:sv_craft/Features/grocery/view/widgets/cat.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../../../../constant/api_link.dart';
import '../../../../constant/color.dart';
import '../../../../services/services.dart';
import '../../../bookmarks/controller/add_to_bookmarks_con.dart';
import '../../../home/controller/home_controller.dart';
import '../../../market_place/controller/all_product_controller.dart';
import '../../controllar/all_product_controller.dart';
import '../../controllar/bookmark_add_product.dart';
import '../../controllar/bookmark_category_con.dart';
import '../../controllar/searched_product_con.dart';
import '../../model/all_product_model.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:http/http.dart' as http;

import '../../model/sub_item_model.dart';
import '../see_all_products.dart';
import 'catagoryDetails.dart';
import 'grocery_count.dart';

class CategoriFilter extends StatefulWidget {
  @override
  State<CategoriFilter> createState() => _CategoriFilterState();
}

class _CategoriFilterState extends State<CategoriFilter> {
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final GroceryAllProductController _groceryAllProductController =
      Get.put(GroceryAllProductController());
  final GrocerySearchController _grocerySearchController =
      Get.put(GrocerySearchController());
  final AddtoBookmarksController _addtoBookmarksController =
      Get.put(AddtoBookmarksController());
  final BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  final HomeController _homeController = Get.put(HomeController());
  final BookmarkProductAddController _bookmarkProductAddController =
      Get.put(BookmarkProductAddController());
  final TextEditingController _categoryController = TextEditingController();
  // Variable
  var tokenp;
  late int userId;
  bool _isSearched = false;
  var searchedData;
  var _selectedIndex = 0;
  PageController? _pageController;

  bool isLoading = false;
  int? _productIndex;

  final TextEditingController _searchController = TextEditingController();

  bool _searchBoolean = false;
  final List<int> _searchIndexList = [];
  var product = 0;

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (String name) async {
        Future.delayed(const Duration(seconds: 1), () async {
          final searchProduct = await _grocerySearchController
              .getGrocerySearchProduct(tokenp, name);
          print(name);

          if (searchProduct != null) {
            setState(() {
              _isSearched = true;
              searchedData = searchProduct;
              // print('searchProduct = ${searchedData[0].name}');
            });
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Appcolor.textColor,
          fontSize: 20,
        ),
      ),
    );
  }

  //Access confirmation dialog
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late GroceryAllProduct groceryAllProduct;
  bool haveaccess = true;
  bool accessreq = false;
  bool accessgrant = false;
  @override
  void initState() {
    // subItemModel.data!.clear();
    super.initState();
    getGroceryProducts();

    haveaccess
        ? print('have access')
        : accessreq
            ? Timer(const Duration(seconds: 1), () {
                _showaccessbegged();
              })
            : accessgrant
                ? print("Access granted")
                : Timer(const Duration(seconds: 1), () {
                    _showMyDialog();
                  });
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
    Future.delayed(const Duration(seconds: 2), () async {
      const Center(
          child: Center(
              child: SpinKitFadingCircle(
        color: Colors.black,
      )));
    });
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      getProductbyId(groceryAllProduct.data[0].id.toString());

      selectIndex = 0;
      setState(() {});
    });
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();

    setState(() {
      tokenp = token;
    });

    final userid = await _allProductController.getUserId();

    setState(() {
      userId = userid;
    });

    // Get bookmarks category name
    var bookmarkCategory = await _bookmarkCategoryController
        .getBookmarkCategory(_homeController.tokenGlobal);
    if (bookmarkCategory != null) {
      setState(() {
        _bookmarkCategoryController.BookmarkCategory = bookmarkCategory;
      });
    }
    // setState(() {
    //   BookmarkCategory = bookmarkCategory;
    //   print("Print from ui ${BookmarkCategory[0].length}");
    // });
  }

  int selectIndex = 0;
  @override
  void dispose() {
    subItemModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 164, 221, 166),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios)),
          title: Text("All Category".tr),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .010,
                ),
                Center(
                  child: Text(
                    "All Category".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .010,
                ),
                Column(
                  children: [
                    isLoading
                        ? Center(child: Text('Loading.....'))
                        : categorisUiDesing(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .010,
                ),
              ]),
        ),
      ),
    );
  }

  SizedBox categorisUiDesing() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: groceryAllProduct.data.length,
          shrinkWrap: true,
          primary: false,
          // scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                selectIndex = index;
                getProductbyId(groceryAllProduct.data[index].id.toString());
                setState(() {
                  // Get.to(Scaffold(
                  //   backgroundColor: const Color.fromARGB(255, 135, 235, 157),
                  //   appBar: AppBar(
                  //       centerTitle: true,
                  //       title: Text(
                  //         groceryAllProduct.data[index].name,
                  //       ),
                  //       leading: IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             Get.back();
                  //           });
                  //         },
                  //         icon: Icon(Icons.arrow_back),
                  //       )),
                  //   body: Container(
                  //     child: ListView.builder(
                  //         itemCount: subItemModel.data!.length,
                  //         shrinkWrap: true,
                  //         primary: false,
                  //         itemBuilder: (context, subIndex) {
                  //           var productItem = subItemModel.data![subIndex];
                  //           return Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                       productItem.title,
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                     GestureDetector(
                  //                       onTap: () {
                  //                         Get.to(SeeAllProductsScreen(
                  //                           title: productItem.title,
                  //                           id: productItem.id.toString(),
                  //                         ));
                  //                       },
                  //                       child: Text(
                  //                         "View all",
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height:
                  //                     MediaQuery.of(context).size.height * 0.50,
                  //                 child: ListView.builder(
                  //                     scrollDirection: Axis.horizontal,
                  //                     itemCount: productItem.lists.length,
                  //                     physics: const BouncingScrollPhysics(),
                  //                     primary: false,
                  //                     shrinkWrap: true,
                  //                     itemBuilder: (context, subProductIndex) {
                  //                       var subProduct =
                  //                           productItem.lists[subProductIndex];
                  //                       return Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             horizontal: 8),
                  //                         child: Container(
                  //                           width: 180,
                  //                           //color: Colors.green,
                  //                           alignment: Alignment.center,
                  //                           decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             borderRadius:
                  //                                 BorderRadius.circular(10),
                  //                             boxShadow: const [
                  //                               BoxShadow(
                  //                                 color: Colors
                  //                                     .black12, //color of shadow
                  //                                 spreadRadius:
                  //                                     2, //spread radius
                  //                                 blurRadius: 5, // blur radius
                  //                                 offset: Offset(0,
                  //                                     2), // changes position of shadow
                  //                                 //first paramerter of offset is left-right
                  //                                 //second parameter is top to down
                  //                               )
                  //                             ],
                  //                           ),

                  //                           child: Column(
                  //                             mainAxisSize: MainAxisSize.min,
                  //                             children: [
                  //                               Row(
                  //                                 children: [
                  //                                   IconButton(
                  //                                     onPressed: () {
                  //                                       _bookmarkCategoryController
                  //                                                   .BookmarkCategory
                  //                                                   .length >
                  //                                               0
                  //                                           ? Get.dialog(
                  //                                               AlertDialog(
                  //                                                 title: const Text(
                  //                                                     'Add To Bookmarks.'),
                  //                                                 content:
                  //                                                     Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   children: [
                  //                                                     SizedBox(
                  //                                                       height:
                  //                                                           MediaQuery.of(context).size.height *
                  //                                                               .2,
                  //                                                       width: MediaQuery.of(context).size.width *
                  //                                                           .6,
                  //                                                       child: ListView.builder(
                  //                                                           shrinkWrap: true,
                  //                                                           itemCount: _bookmarkCategoryController.BookmarkCategory.length,
                  //                                                           itemBuilder: (context, ind) {
                  //                                                             return Container(
                  //                                                               padding: const EdgeInsets.symmetric(horizontal: 20),
                  //                                                               // margin: const EdgeInsets.symmetric(horizontal: 20),
                  //                                                               alignment: Alignment.center,
                  //                                                               decoration: BoxDecoration(
                  //                                                                 color: Colors.white,
                  //                                                                 borderRadius: BorderRadius.circular(0),
                  //                                                                 boxShadow: const [
                  //                                                                   BoxShadow(
                  //                                                                     color: Colors.black12, //color of shadow
                  //                                                                     spreadRadius: 1, //spread radius
                  //                                                                     blurRadius: 0, // blur radius
                  //                                                                     offset: Offset(0, 0), // changes position of shadow
                  //                                                                   )
                  //                                                                 ],
                  //                                                               ),
                  //                                                               width: MediaQuery.of(context).size.width * .4,
                  //                                                               height: 40,
                  //                                                               child: InkWell(
                  //                                                                 onTap: () async {
                  //                                                                   var status = await _bookmarkProductAddController.addBookmarkProduct(_homeController.tokenGlobal, _bookmarkCategoryController.BookmarkCategory[ind].id, subProduct.id);
                  //                                                                   if (status == 200) {
                  //                                                                     setState(() {});
                  //                                                                     Get.back();
                  //                                                                     Get.snackbar('Success', 'Product Added To Bookmark');
                  //                                                                   }
                  //                                                                 },
                  //                                                                 child: Row(
                  //                                                                   children: [
                  //                                                                     const Icon(Icons.list),
                  //                                                                     const SizedBox(width: 20),
                  //                                                                     Text(
                  //                                                                       _bookmarkCategoryController.BookmarkCategory[ind].name,
                  //                                                                       style: const TextStyle(color: Colors.black, fontSize: 15),
                  //                                                                       textAlign: TextAlign.center,
                  //                                                                     ),
                  //                                                                     const Spacer(),
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               ),
                  //                                                             );
                  //                                                           }),
                  //                                                     )
                  //                                                   ],
                  //                                                 ),
                  //                                                 // actions: [],
                  //                                               ),
                  //                                               barrierDismissible:
                  //                                                   false,
                  //                                             )
                  //                                           : Get.dialog(
                  //                                               AlertDialog(
                  //                                                 title: const Text(
                  //                                                     'Add Bookmarks Category'),
                  //                                                 content:
                  //                                                     Column(
                  //                                                   mainAxisSize:
                  //                                                       MainAxisSize
                  //                                                           .min,
                  //                                                   children: [
                  //                                                     TextFormField(
                  //                                                       controller:
                  //                                                           _categoryController,
                  //                                                       decoration:
                  //                                                           const InputDecoration(
                  //                                                         hintText:
                  //                                                             'Category Name',
                  //                                                       ),
                  //                                                     ),
                  //                                                   ],
                  //                                                 ),
                  //                                                 actions: [
                  //                                                   Row(
                  //                                                     mainAxisAlignment:
                  //                                                         MainAxisAlignment
                  //                                                             .spaceBetween,
                  //                                                     children: [
                  //                                                       TextButton(
                  //                                                         onPressed:
                  //                                                             () {
                  //                                                           Get.back();
                  //                                                         },
                  //                                                         child:
                  //                                                             const Text('Cancel'),
                  //                                                       ),
                  //                                                       TextButton(
                  //                                                         onPressed:
                  //                                                             () async {
                  //                                                           var statusCode =
                  //                                                               await _bookmarkCategoryController.addBookmarkCategory(_homeController.tokenGlobal, _categoryController.text);

                  //                                                           if (statusCode ==
                  //                                                               200) {
                  //                                                             _categoryController.clear();
                  //                                                             // Get.back();
                  //                                                             setState(() {});
                  //                                                             Get.off(GroceryProduct());
                  //                                                             Get.snackbar('Success', 'Category Added');
                  //                                                           } else {
                  //                                                             Get.back();
                  //                                                             Get.snackbar('Error', 'Category Not Added');
                  //                                                           }
                  //                                                         },
                  //                                                         child:
                  //                                                             const Text('Add'),
                  //                                                       ),
                  //                                                     ],
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                               barrierDismissible:
                  //                                                   false,
                  //                                             );

                  //                                       // var message =
                  //                                       //     await _addtoBookmarksController
                  //                                       //         .addToBookmarks(
                  //                                       //             userId,
                  //                                       //             data[index].id,
                  //                                       //             "grocery",
                  //                                       //             tokenp);

                  //                                       // if (message != null) {
                  //                                       //   Get.snackbar(
                  //                                       //       "Product Added to Bookmarks",
                  //                                       //       message);
                  //                                       // } else {
                  //                                       //   print("Not Added");
                  //                                       // }
                  //                                     },
                  //                                     icon:
                  //                                         // subProduct
                  //                                         //         .bookmark
                  //                                         //     ? const Icon(
                  //                                         //         FontAwesome
                  //                                         //             .book_bookmark,
                  //                                         //         color: Colors
                  //                                         //             .blue,
                  //                                         //         size: 18,
                  //                                         //       )
                  //                                         //     :
                  //                                         const Icon(
                  //                                       FontAwesome.bookmark,
                  //                                       color: Colors.black,
                  //                                       size: 18,
                  //                                     ),
                  //                                   ),
                  //                                   const Spacer(),
                  //                                   Text(
                  //                                     subProduct.marketPrice
                  //                                         .toString(),
                  //                                     textAlign:
                  //                                         TextAlign.center,
                  //                                   ),
                  //                                   const SizedBox(
                  //                                     width: 5,
                  //                                   ),
                  //                                   SizedBox(
                  //                                       width: MediaQuery.of(
                  //                                                   context)
                  //                                               .size
                  //                                               .width *
                  //                                           .01),
                  //                                 ],
                  //                               ),
                  //                               Stack(
                  //                                 children: [
                  //                                   Padding(
                  //                                     padding: const EdgeInsets
                  //                                         .symmetric(
                  //                                       horizontal: 10,
                  //                                     ),
                  //                                     child: Image.network(
                  //                                       // Appurl.baseURL+'${data[index].image}' ??
                  //                                       Appurl.baseURL +
                  //                                           '${subProduct.image}',
                  //                                       fit: BoxFit.cover,
                  //                                       width: 140,
                  //                                       height: 160,
                  //                                     ),
                  //                                   ),
                  //                                   Positioned(
                  //                                       top: 20,
                  //                                       right: 0,
                  //                                       child: Container(
                  //                                         height: 50,
                  //                                         width: 50,
                  //                                         color: Colors.yellow,
                  //                                         child: Text(
                  //                                           "${subProduct.offPrice.toString()}% off",
                  //                                           textAlign: TextAlign
                  //                                               .center,
                  //                                           style: const TextStyle(
                  //                                               fontSize: 20,
                  //                                               fontWeight:
                  //                                                   FontWeight
                  //                                                       .w500,
                  //                                               color:
                  //                                                   Colors.red),
                  //                                         ),
                  //                                       ))
                  //                                 ],
                  //                               ),
                  //                               // SizedBox(
                  //                               //   height: size.height * .02,
                  //                               // ),
                  //                               Row(
                  //                                 children: [
                  //                                   SizedBox(
                  //                                       width: MediaQuery.of(
                  //                                                   context)
                  //                                               .size
                  //                                               .width *
                  //                                           .03),
                  //                                   Column(
                  //                                     crossAxisAlignment:
                  //                                         CrossAxisAlignment
                  //                                             .start,
                  //                                     mainAxisAlignment:
                  //                                         MainAxisAlignment
                  //                                             .center,
                  //                                     children: [
                  //                                       Text(
                  //                                         subProduct.name,
                  //                                         style:
                  //                                             const TextStyle(
                  //                                           fontSize: 12,
                  //                                           fontWeight:
                  //                                               FontWeight.w500,
                  //                                           color: Colors.black,
                  //                                         ),
                  //                                         textAlign:
                  //                                             TextAlign.start,
                  //                                       ),
                  //                                       Text(
                  //                                         "${subProduct.price} kr",
                  //                                         style:
                  //                                             const TextStyle(
                  //                                           fontSize: 18,
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                           color: Colors.black,
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                 ],
                  //                               ),

                  //                               SizedBox(
                  //                                   height:
                  //                                       MediaQuery.of(context)
                  //                                               .size
                  //                                               .height *
                  //                                           .01),
                  //                               subProduct != null
                  //                                   ? GroceryCount(
                  //                                       index: subProductIndex,
                  //                                       // userId: userId,
                  //                                       productId:
                  //                                           subProduct.id,
                  //                                       price: subProduct.price,
                  //                                     )
                  //                                   : const Center(
                  //                                       child: Center(
                  //                                           child:
                  //                                               SpinKitFadingCircle(
                  //                                       color: Colors.black,
                  //                                     ))),

                  //                               SizedBox(height: 5),
                  //                             ],
                  //                           ),
                  //                           // height: 147,
                  //                           // width: ,
                  //                         ),
                  //                       );
                  //                     }),
                  //               )
                  //             ],
                  //           );
                  //         }),
                  //   ),
                  // ));
                  Get.to(GroceryDetails(
                    Id: groceryAllProduct.data[index].id.toString(),
                  ));
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 85,
                  decoration: BoxDecoration(
                    color: selectIndex == index
                        ? Colors.blueAccent
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          Appurl.baseURL + groceryAllProduct.data[index].image,
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 10),
                        Text(groceryAllProduct.data[index].name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _showaccessbegged() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Card(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Your request in review\nplease wait!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  late SubItemModel subItemModel;
  bool isClicked = false;
  bool isproductByIdLoading = false;
  Future<void> _showMyDialog() async {
    print("object");
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "You don't have",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "access for",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "SVCRAFT SHOP",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    _showaccessbegged();
                  },
                  child: const Text(
                    "Get Access",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                )
              ],
            ));
      },
    );
  }

  // Future<void> _showaccessbegged() async {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return Container(
  //           color: Colors.black54,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: const [
  //               Card(
  //                 color: Colors.redAccent,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(15),
  //                   child: Text(
  //                     "Your request in review\nplease wait!",
  //                     style: TextStyle(
  //                       fontSize: 22,
  //                       color: Colors.white,
  //                       decoration: TextDecoration.none,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ));
  //     },
  //   );
  // }

  void getGroceryProducts() async {
    setState(() {
      isLoading = true;
    });
    var url = Appurl.baseURL + "api/groceries/category/all";

    http.Response response =
        await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);
    // print("Response:::::::${response.body}");
    if (response.statusCode == 200) {
      var data = groceryAllProductFromJson(response.body);
      groceryAllProduct = data;
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error",
          response.body.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void getProductbyId(String id) async {
    setState(() {
      isproductByIdLoading = true;
    });
    var url = Appurl.baseURL + "api/groceries/v2/category/$id";
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      if (response.statusCode == 200) {
        var res = subItemModelFromJson(response.body);

        subItemModel = res;
      } else {
        print('Product not found');
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error",
          e.toString());
    }
    setState(() {
      isproductByIdLoading = false;
      isClicked = true;
    });
  }
}
