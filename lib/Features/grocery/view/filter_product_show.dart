import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_add_product.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/controllar/filter_product_con.dart';
import 'package:sv_craft/Features/grocery/model/filter_product_model.dart';
import 'package:sv_craft/Features/grocery/view/bookmarks_screen.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/constant.dart';

class FilterProductShow extends StatefulWidget {
  const FilterProductShow(
      {Key? key, required this.subcategory, required this.token})
      : super(key: key);
  final String subcategory;
  final String token;

  @override
  State<FilterProductShow> createState() => _FilterProductShowState();
}

class _FilterProductShowState extends State<FilterProductShow> {
  final GroceryFilterController _groceryFilterController =
      Get.put(GroceryFilterController());
  BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  HomeController _homeController = Get.put(HomeController());
  BookmarkProductAddController _bookmarkProductAddController =
      Get.put(BookmarkProductAddController());
  final TextEditingController _categoryController = TextEditingController();
  var _selectedIndex = 2;
  PageController? _pageController;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 135, 235, 157),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.subcategory,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body: Container(
          height: size.height,
          // color: Colors.blue,
          child: FutureBuilder<List<FilterProductData>?>(
              future: _groceryFilterController.getGroceryFilterProduct(
                  widget.token, widget.subcategory),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                      child: Center(
                          child: Center(
                              child: const SpinKitFadingCircle(
                    color: Colors.black,
                  ))));
                } else {
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Product Found'));
                  } else {
                    final data = snapshot.data;
                    return GridView.builder(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      itemCount: data!.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: .48,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
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
                              offset:
                                  Offset(0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),

                        child: Column(
                          children: [
                            // SizedBox(height: size.height * .01),
                            Row(
                              children: [
                                SizedBox(width: size.width * .01),
                                IconButton(
                                    onPressed: () async {
                                      _bookmarkCategoryController
                                                  .BookmarkCategory.length >
                                              0
                                          ? Get.dialog(
                                              AlertDialog(
                                                title: const Text(
                                                    'Add To Bookmarks'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: size.height * .3,
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
                                                                      data[index]
                                                                          .id);

                                                                  if (status ==
                                                                      200) {
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
                                                                      width: 20,
                                                                    ),
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
                                                          var statusCode =
                                                              await _bookmarkCategoryController
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
                                    },
                                    icon: const Icon(
                                      FontAwesome.bookmark,
                                      color: Colors.black,
                                      size: 18,
                                    )),
                                Spacer(),
                                Text(
                                  data[index].marketPrice.toString(),
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
                                      horizontal: 10, vertical: 10),
                                  child: Image.network(
                                    // Appurl.baseURL+'${data[index].image}' ??
                                    AppImage.carouselImages[index],
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 150,
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
                                        "${data[index].offPrice.toString()}% off",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data[index].name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "${data[index].price} " + "kr".tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: size.width * .4,
                                      child: Text(
                                        data[index].description,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                    // Text(
                                    //   "also the leap into electronic",
                                    //   style: TextStyle(
                                    //     fontSize: 12,
                                    //     fontWeight: FontWeight.w500,
                                    //     color: Colors.black,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            data != null
                                ? GroceryCount(
                                    index: index,
                                    productId: data[index].id,
                                    price: data[index].price,
                                  )
                                : Center(
                                    child: Center(
                                        child: const SpinKitFadingCircle(
                                    color: Colors.black,
                                  ))),
                          ],
                        ),
                        // height: 147,
                        // width: ,
                      ),
                    );
                  }
                }
              }),
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Appcolor.primaryColor,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController?.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);

            if (_selectedIndex == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GroceryProduct()),
              );
            } else if (_selectedIndex == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => GroceryBookmarks()),
              );
            } else if (_selectedIndex == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          from: "grocery",
                        )),
              );
            }
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_bag),
                title: Text('Grocery'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.bookmark_border),
                title: Text('Bookmarks'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
