import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/bookmarks/controller/add_to_bookmarks_con.dart';
import 'package:sv_craft/Features/grocery/controllar/all_product_controller.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_add_product.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/controllar/searched_product_con.dart';
import 'package:sv_craft/Features/grocery/model/product_model.dart';
import 'package:sv_craft/Features/grocery/model/sub_item_model.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/grocery/view/see_all_products.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/catagoriHttp.dart';
import 'package:sv_craft/services/services.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
  });
  // final String subcategory;
  // final String token;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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
  Map<String, dynamic>? productData;

  SubItemModel subItemModel = SubItemModel();

  // final DetailController productController = Get.put(DetailController());
  getData(String id) async {
    dynamic Api = "http://svkraft.shop/api/groceries/v2/category/$id";

    var response =
        await http.get(Uri.parse(Api), headers: ServicesClass.headersForAuth);
    print("rresult is${response.body}");

    setState(() {
      productData = Map<String, dynamic>.from(json.decode(response.body));
    });
  }

  @override
  void initState() {
    getData(toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      child: ListView.builder(
          itemCount: subItemModel.data!.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, subIndex) {
            var productItem = subItemModel.data![subIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productItem.title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(SeeAllProductsScreen(
                            title: productItem.title,
                            id: productItem.id.toString(),
                          ));
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productItem.lists.length,
                      physics: const BouncingScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, subProductIndex) {
                        var subProduct = productItem.lists[subProductIndex];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 180,
                            //color: Colors.green,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, //color of shadow
                                  spreadRadius: 2, //spread radius
                                  blurRadius: 5, // blur radius
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                )
                              ],
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _bookmarkCategoryController
                                                    .BookmarkCategory.length >
                                                0
                                            ? Get.dialog(
                                                AlertDialog(
                                                  title: const Text(
                                                      'Add To Bookmarks.'),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            size.height * .2,
                                                        width: size.width * .6,
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                _bookmarkCategoryController
                                                                    .BookmarkCategory
                                                                    .length,
                                                            itemBuilder:
                                                                (context, ind) {
                                                              return Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                                // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black12, //color of shadow
                                                                      spreadRadius:
                                                                          1, //spread radius
                                                                      blurRadius:
                                                                          0, // blur radius
                                                                      offset: Offset(
                                                                          0,
                                                                          0), // changes position of shadow
                                                                    )
                                                                  ],
                                                                ),
                                                                width:
                                                                    size.width *
                                                                        .4,
                                                                height: 40,
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    var status = await _bookmarkProductAddController.addBookmarkProduct(
                                                                        _homeController
                                                                            .tokenGlobal,
                                                                        _bookmarkCategoryController
                                                                            .BookmarkCategory[
                                                                                ind]
                                                                            .id,
                                                                        subProduct
                                                                            .id);
                                                                    if (status ==
                                                                        200) {
                                                                      setState(
                                                                          () {});
                                                                      Get.back();
                                                                      Get.snackbar(
                                                                          'Success',
                                                                          'Product Added To Bookmark');
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .list),
                                                                      const SizedBox(
                                                                          width:
                                                                              20),
                                                                      Text(
                                                                        _bookmarkCategoryController
                                                                            .BookmarkCategory[ind]
                                                                            .name,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 15),
                                                                        textAlign:
                                                                            TextAlign.center,
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
                                                barrierDismissible: false,
                                              )
                                            : Get.dialog(
                                                AlertDialog(
                                                  title: const Text(
                                                      'Add Bookmarks Category'),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        controller:
                                                            _categoryController,
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Category Name',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            var statusCode = await _bookmarkCategoryController
                                                                .addBookmarkCategory(
                                                                    _homeController
                                                                        .tokenGlobal,
                                                                    _categoryController
                                                                        .text);

                                                            if (statusCode ==
                                                                200) {
                                                              _categoryController
                                                                  .clear();
                                                              // Get.back();
                                                              setState(() {});
                                                              Get.off(
                                                                  GroceryProduct());
                                                              Get.snackbar(
                                                                  'Success',
                                                                  'Category Added');
                                                            } else {
                                                              Get.back();
                                                              Get.snackbar(
                                                                  'Error',
                                                                  'Category Not Added');
                                                            }
                                                          },
                                                          child:
                                                              const Text('Add'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                barrierDismissible: false,
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
                                      icon:
                                          // subProduct
                                          //         .bookmark
                                          //     ? const Icon(
                                          //         FontAwesome
                                          //             .book_bookmark,
                                          //         color: Colors
                                          //             .blue,
                                          //         size: 18,
                                          //       )
                                          //     :
                                          const Icon(
                                        FontAwesome.bookmark,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      subProduct.marketPrice.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(width: size.width * .01),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Image.network(
                                        // Appurl.baseURL+'${data[index].image}' ??
                                        Appurl.baseURL + '${subProduct.image}',
                                        fit: BoxFit.cover,
                                        width: 140,
                                        height: 160,
                                      ),
                                    ),
                                    Positioned(
                                        top: 20,
                                        right: 0,
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.yellow,
                                          child: Text(
                                            "${subProduct.offPrice.toString()}% off",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red),
                                          ),
                                        ))
                                  ],
                                ),
                                // SizedBox(
                                //   height: size.height * .02,
                                // ),
                                Row(
                                  children: [
                                    SizedBox(width: size.width * .03),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          subProduct.name,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "${subProduct.price} " + "kr".tr,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: size.height * .01),
                                subProduct != null
                                    ? GroceryCount(
                                        index: subProductIndex,
                                        // userId: userId,
                                        productId: subProduct.id,
                                        price: subProduct.price,
                                      )
                                    : const Center(
                                        child: Center(
                                            child: SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))),

                                SizedBox(height: 5),
                              ],
                            ),
                            // height: 147,
                            // width: ,
                          ),
                        );
                      }),
                )
              ],
            );
          }),
    ));
  }
}
