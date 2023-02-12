// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:icons_plus/icons_plus.dart';

// import '../../../../constant/api_link.dart';
// import '../../../../services/services.dart';
// import '../../../bookmarks/controller/add_to_bookmarks_con.dart';
// import '../../../home/controller/home_controller.dart';
// import '../../../market_place/controller/all_product_controller.dart';
// import '../../controllar/all_product_controller.dart';
// import '../../controllar/bookmark_add_product.dart';
// import '../../controllar/bookmark_category_con.dart';
// import '../../controllar/searched_product_con.dart';
// import '../../model/all_product_model.dart';
// import '../../model/sub_item_model.dart';
// import '../grocery_product.dart';
// import '../see_all_products.dart';
// import 'grocery_count.dart';
// import 'package:http/http.dart' as http;

// class GroceryCategoriFilterringPruducts extends StatefulWidget {
//   const GroceryCategoriFilterringPruducts({super.key});

//   @override
//   State<GroceryCategoriFilterringPruducts> createState() =>
//       _GroceryCategoriFilterringPruductsState();
// }

// class _GroceryCategoriFilterringPruductsState
//     extends State<GroceryCategoriFilterringPruducts> {
//   final AllProductController _allProductController =
//       Get.put(AllProductController());
//   final GroceryAllProductController _groceryAllProductController =
//       Get.put(GroceryAllProductController());
//   final GrocerySearchController _grocerySearchController =
//       Get.put(GrocerySearchController());
//   final AddtoBookmarksController _addtoBookmarksController =
//       Get.put(AddtoBookmarksController());
//   final BookmarkCategoryController _bookmarkCategoryController =
//       Get.put(BookmarkCategoryController());
//   final HomeController _homeController = Get.put(HomeController());
//   final BookmarkProductAddController _bookmarkProductAddController =
//       Get.put(BookmarkProductAddController());
//   final TextEditingController _categoryController = TextEditingController();

//   late GroceryAllProduct groceryAllProduct;

// //Access confirmation dialog
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   bool haveaccess = true;
//   bool accessreq = false;
//   bool accessgrant = false;
//   @override
//   void initState() {
//     super.initState();
//     getGroceryProducts();


//     // haveaccess
//     //     ? print('have access')
//     //     : accessreq
//     //         ? Timer(const Duration(seconds: 1), () {
//     //             _showaccessbegged();
//     //           })
//     //         : accessgrant
//     //             ? print("Access granted")
//     //             : Timer(const Duration(seconds: 1), () {
//     //                 _showMyDialog();
//     //               });
//     // Future.delayed(Duration.zero, () async {
//     //   setTokenToVariable();
//     // });
//     // Future.delayed(const Duration(seconds: 2), () async {
//     //   const Center(
//     //       child: Center(
//     //           child: SpinKitFadingCircle(
//     //     color: Colors.black,
//     //   )));
//     // });
//     Future.delayed(
//         const Duration(
//           seconds: 1,
//         ), () {
//       getProductbyId(groceryAllProduct.data[0].id.toString());

//       selectIndex = 0;
//       setState(() {});
//     });
//   }

//   bool isLoading = false;
//   int? _productIndex;

//   int selectIndex = 0;
//   late SubItemModel subItemModel;
//   bool isClicked = false;
//   bool isproductByIdLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromARGB(255, 164, 221, 166),
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(Icons.arrow_back_ios)),
//           title: Text(" All your Filtering Products "),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListView.builder(
//                   itemCount: subItemModel.data.length,
//                   shrinkWrap: true,
//                   primary: false,
//                   itemBuilder: (context, subIndex) {
//                     var productItem = subItemModel.data[subIndex];
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 productItem.title,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Get.to(SeeAllProductsScreen(
//                                     title: productItem.title,
//                                     id: productItem.id.toString(),
//                                   ));
//                                 },
//                                 child: Text(
//                                   "View all",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.38,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: productItem.lists.length,
//                               physics: const BouncingScrollPhysics(),
//                               primary: false,
//                               shrinkWrap: true,
//                               itemBuilder: (context, subProductIndex) {
//                                 var subProduct =
//                                     productItem.lists[subProductIndex];
//                                 return Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Container(
//                                     width: 180,
//                                     //color: Colors.green,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color:
//                                               Colors.black12, //color of shadow
//                                           spreadRadius: 2, //spread radius
//                                           blurRadius: 5, // blur radius
//                                           offset: Offset(0,
//                                               2), // changes position of shadow
//                                           //first paramerter of offset is left-right
//                                           //second parameter is top to down
//                                         )
//                                       ],
//                                     ),

//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                               onPressed: () {
//                                                 _bookmarkCategoryController
//                                                             .BookmarkCategory
//                                                             .length >
//                                                         0
//                                                     ? Get.dialog(
//                                                         AlertDialog(
//                                                           title: const Text(
//                                                               'Add To Bookmarks'),
//                                                           content: Column(
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             children: [
//                                                               SizedBox(
//                                                                 height:
//                                                                     size.height *
//                                                                         .2,
//                                                                 width:
//                                                                     size.width *
//                                                                         .6,
//                                                                 child: ListView
//                                                                     .builder(
//                                                                         shrinkWrap:
//                                                                             true,
//                                                                         itemCount: _bookmarkCategoryController
//                                                                             .BookmarkCategory
//                                                                             .length,
//                                                                         itemBuilder:
//                                                                             (context,
//                                                                                 ind) {
//                                                                           return Container(
//                                                                             padding:
//                                                                                 const EdgeInsets.symmetric(horizontal: 20),
//                                                                             // margin: const EdgeInsets.symmetric(horizontal: 20),
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             decoration:
//                                                                                 BoxDecoration(
//                                                                               color: Colors.white,
//                                                                               borderRadius: BorderRadius.circular(0),
//                                                                               boxShadow: const [
//                                                                                 BoxShadow(
//                                                                                   color: Colors.black12, //color of shadow
//                                                                                   spreadRadius: 1, //spread radius
//                                                                                   blurRadius: 0, // blur radius
//                                                                                   offset: Offset(0, 0), // changes position of shadow
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                             width:
//                                                                                 size.width * .4,
//                                                                             height:
//                                                                                 40,
//                                                                             child:
//                                                                                 InkWell(
//                                                                               onTap: () async {
//                                                                                 var status = await _bookmarkProductAddController.addBookmarkProduct(_homeController.tokenGlobal, _bookmarkCategoryController.BookmarkCategory[ind].id, subProduct.id);
//                                                                                 if (status == 200) {
//                                                                                   setState(() {});
//                                                                                   Get.back();
//                                                                                   Get.snackbar('Success', 'Product Added To Bookmark');
//                                                                                 }
//                                                                               },
//                                                                               child: Row(
//                                                                                 children: [
//                                                                                   const Icon(Icons.list),
//                                                                                   const SizedBox(width: 20),
//                                                                                   Text(
//                                                                                     _bookmarkCategoryController.BookmarkCategory[ind].name,
//                                                                                     style: const TextStyle(color: Colors.black, fontSize: 15),
//                                                                                     textAlign: TextAlign.center,
//                                                                                   ),
//                                                                                   const Spacer(),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                           );
//                                                                         }),
//                                                               )
//                                                             ],
//                                                           ),
//                                                           // actions: [],
//                                                         ),
//                                                         barrierDismissible:
//                                                             false,
//                                                       )
//                                                     : Get.dialog(
//                                                         AlertDialog(
//                                                           title: const Text(
//                                                               'Add Bookmarks Category'),
//                                                           content: Column(
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             children: [
//                                                               TextFormField(
//                                                                 controller:
//                                                                     _categoryController,
//                                                                 decoration:
//                                                                     const InputDecoration(
//                                                                   hintText:
//                                                                       'Category Name',
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           actions: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               children: [
//                                                                 TextButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     Get.back();
//                                                                   },
//                                                                   child: const Text(
//                                                                       'Cancel'),
//                                                                 ),
//                                                                 TextButton(
//                                                                   onPressed:
//                                                                       () async {
//                                                                     var statusCode = await _bookmarkCategoryController.addBookmarkCategory(
//                                                                         _homeController
//                                                                             .tokenGlobal,
//                                                                         _categoryController
//                                                                             .text);

//                                                                     if (statusCode ==
//                                                                         200) {
//                                                                       _categoryController
//                                                                           .clear();
//                                                                       // Get.back();
//                                                                       setState(
//                                                                           () {});
//                                                                       Get.off(
//                                                                           GroceryProduct());
//                                                                       Get.snackbar(
//                                                                           'Success',
//                                                                           'Category Added');
//                                                                     } else {
//                                                                       Get.back();
//                                                                       Get.snackbar(
//                                                                           'Error',
//                                                                           'Category Not Added');
//                                                                     }
//                                                                   },
//                                                                   child:
//                                                                       const Text(
//                                                                           'Add'),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         barrierDismissible:
//                                                             false,
//                                                       );

//                                                 // var message =
//                                                 //     await _addtoBookmarksController
//                                                 //         .addToBookmarks(
//                                                 //             userId,
//                                                 //             data[index].id,
//                                                 //             "grocery",
//                                                 //             tokenp);

//                                                 // if (message != null) {
//                                                 //   Get.snackbar(
//                                                 //       "Product Added to Bookmarks",
//                                                 //       message);
//                                                 // } else {
//                                                 //   print("Not Added");
//                                                 // }
//                                               },
//                                               icon:
//                                                   // subProduct
//                                                   //         .bookmark
//                                                   //     ? const Icon(
//                                                   //         FontAwesome
//                                                   //             .book_bookmark,
//                                                   //         color: Colors
//                                                   //             .blue,
//                                                   //         size: 18,
//                                                   //       )
//                                                   //     :
//                                                   const Icon(
//                                                 FontAwesome.bookmark,
//                                                 color: Colors.black,
//                                                 size: 18,
//                                               ),
//                                             ),
//                                             const Spacer(),
//                                             Text(
//                                               subProduct.marketPrice.toString(),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                             const SizedBox(
//                                               width: 5,
//                                             ),
//                                             SizedBox(width: size.width * .01),
//                                           ],
//                                         ),
//                                         Stack(
//                                           children: [
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                 horizontal: 10,
//                                               ),
//                                               child: Image.network(
//                                                 // Appurl.baseURL+'${data[index].image}' ??
//                                                 Appurl.baseURL +
//                                                     '${subProduct.image}',
//                                                 fit: BoxFit.cover,
//                                                 width: 140,
//                                                 height: 160,
//                                               ),
//                                             ),
//                                             Positioned(
//                                                 top: 20,
//                                                 right: 0,
//                                                 child: Container(
//                                                   height: 50,
//                                                   width: 50,
//                                                   color: Colors.yellow,
//                                                   child: Text(
//                                                     "${subProduct.offPrice.toString()}% off",
//                                                     textAlign: TextAlign.center,
//                                                     style: const TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         color: Colors.red),
//                                                   ),
//                                                 ))
//                                           ],
//                                         ),
//                                         // SizedBox(
//                                         //   height: size.height * .02,
//                                         // ),
//                                         Row(
//                                           children: [
//                                             SizedBox(width: size.width * .03),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   subProduct.name,
//                                                   style: const TextStyle(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Colors.black,
//                                                   ),
//                                                   textAlign: TextAlign.start,
//                                                 ),
//                                                 Text(
//                                                   "${subProduct.price} kr",
//                                                   style: const TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),

//                                         SizedBox(height: size.height * .01),
//                                         subProduct != null
//                                             ? GroceryCount(
//                                                 index: subProductIndex,
//                                                 // userId: userId,
//                                                 productId: subProduct.id,
//                                                 price: subProduct.price,
//                                               )
//                                             : const Center(
//                                                 child: Center(
//                                                     child: SpinKitFadingCircle(
//                                                 color: Colors.black,
//                                               ))),

//                                         SizedBox(height: 5),
//                                       ],
//                                     ),
//                                     // height: 147,
//                                     // width: ,
//                                   ),
//                                 );
//                               }),
//                         )
//                       ],
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void getGroceryProducts() async {
//     setState(() {
//       isLoading = true;
//     });
//     var url = Appurl.baseURL + "api/groceries/category/all";

//     http.Response response =
//         await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);
//     // print("Response:::::::${response.body}");
//     if (response.statusCode == 200) {
//       var data = groceryAllProductFromJson(response.body);
//       groceryAllProduct = data;
//     } else {
//       Get.snackbar(
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           "Error",
//           response.body.toString());
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   void getProductbyId(String id) async {
//     setState(() {
//       isproductByIdLoading = true;
//     });
//     var url = Appurl.baseURL + "api/groceries/v2/category/$id";
//     try {
//       http.Response response =
//           await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

//       if (response.statusCode == 200) {
//         var res = subItemModelFromJson(response.body);

//         subItemModel = res;
//       } else {
//         print('Product not found');
//       }
//     } catch (e) {
//       Get.snackbar(
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           "Error",
//           e.toString());
//     }
//     setState(() {
//       isproductByIdLoading = false;
//       isClicked = true;
//     });
//   }
// }
