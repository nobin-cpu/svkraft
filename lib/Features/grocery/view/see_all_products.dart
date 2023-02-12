import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../../home/controller/home_controller.dart';
import '../controllar/bookmark_add_product.dart';
import '../controllar/bookmark_category_con.dart';
import 'grocery_product.dart';

class SeeAllProductsScreen extends StatefulWidget {
  final String title;
  final String id;
  SeeAllProductsScreen({super.key, required this.title, required this.id});

  @override
  State<SeeAllProductsScreen> createState() => _SeeAllProductsScreenState();
}

class _SeeAllProductsScreenState extends State<SeeAllProductsScreen> {
  final GroceryCategoryController groceryCategoryController =
      Get.put(GroceryCategoryController());
  final BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  final BookmarkProductAddController _bookmarkProductAddController =
      Get.put(BookmarkProductAddController());
  final HomeController _homeController = Get.put(HomeController());

  final TextEditingController _categoryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    groceryCategoryController.getSeeAllProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 135, 235, 157),
      appBar: AppBar(
        backgroundColor: Appcolor.primaryColor,
        title: Text(widget.title,
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        elevation: 0,
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Obx(() => groceryCategoryController.isLoading == true
          ? ShimmerEffect.listSimmerEffect()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 1),
                itemCount:
                    groceryCategoryController.sellAllModel.value.data!.length,
                itemBuilder: (context, index) {
                  var items =
                      groceryCategoryController.sellAllModel.value.data![index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
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
                            offset: Offset(0, 2), // changes position of shadow
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
                                            title: Text('Add To Bookmarks'.tr),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: size.height * .2,
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
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
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
                                                              size.width * .4,
                                                          height: 40,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var status = await _bookmarkProductAddController.addBookmarkProduct(
                                                                  _homeController
                                                                      .tokenGlobal,
                                                                  _bookmarkCategoryController
                                                                      .BookmarkCategory[
                                                                          ind]
                                                                      .id,
                                                                  items.id);
                                                              if (status ==
                                                                  200) {
                                                                setState(() {});
                                                                Get.back();
                                                                // Get.snackbar(
                                                                //     'Success'
                                                                //         .tr,
                                                                //     'Product Added To Bookmark'
                                                                //         .tr);
                                                              }
                                                            },
                                                            child: Row(
                                                              children: [
                                                                const Icon(
                                                                    Icons.list),
                                                                const SizedBox(
                                                                    width: 20),
                                                                Text(
                                                                  _bookmarkCategoryController
                                                                      .BookmarkCategory[
                                                                          ind]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          15),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
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
                                            title: Text(
                                                'Add Bookmarks Category'.tr),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      _categoryController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Category Name'.tr,
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
                                                    child: Text('Cancel'.tr),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      var statusCode = await _bookmarkCategoryController
                                                          .addBookmarkCategory(
                                                              _homeController
                                                                  .tokenGlobal,
                                                              _categoryController
                                                                  .text);

                                                      if (statusCode == 200) {
                                                        _categoryController
                                                            .clear();
                                                        // Get.back();
                                                        setState(() {});
                                                        Get.off(
                                                            GroceryProduct());
                                                        // Get.snackbar('Success',
                                                        //     'Category Added');
                                                      } else {
                                                        Get.back();
                                                        Get.snackbar(
                                                            'Error'.tr,
                                                            'Category Not Added'
                                                                .tr);
                                                      }
                                                    },
                                                    child: Text('Add'.tr),
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
                                    Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                items.marketPrice.toString(),
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
                                  Appurl.baseURL + '${items.image}',
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height:
                                      MediaQuery.of(context).size.height * .13,
                                ),
                              ),
                              items.ar_off_price == "٠"
                                  ? SizedBox()
                                  : Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.yellow,
                                        child: Text(
                                          "${items.ar_off_price}% off",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    items.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "${(items.ar_pricee)} " + "kr".tr,
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
                          items != null
                              ? GroceryCount(
                                  index: index,
                                  // userId: userId,
                                  productId: items.id,
                                  price: double.parse(items.price!),
                                )
                              : const Center(
                                  child: Center(
                                      child: SpinKitFadingCircle(
                                  color: Colors.black,
                                ))),

                          const SizedBox(height: 5),
                        ],
                      ),
                      // height: 147,
                      // width: ,
                    ),
                  );
                },
              ))),
    );
  }
}
