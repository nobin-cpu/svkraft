import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/special_day/controllar/bookmark_con.dart';
import 'package:sv_craft/Features/special_day/controllar/category_1_con.dart';
import 'package:sv_craft/Features/special_day/controllar/special_all_product_con.dart';
import 'package:sv_craft/Features/special_day/view/Bookmark_product_show.dart';

import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';
import '../../grocery/controllar/cart_count.dart';
import '../model/special_all_product_model.dart';
import 'package:http/http.dart' as http;

class CategoryProuctScreen extends StatefulWidget {
  CategoryProuctScreen({
    Key? key,
    required this.id,
    required this.token,
  }) : super(key: key);
  final int id;
  final String token;
  @override
  State<CategoryProuctScreen> createState() => _CategoryProuctScreenState();
}

class _CategoryProuctScreenState extends State<CategoryProuctScreen> {
  Cartcontrollerofnav _cartControllers =Get.put(Cartcontrollerofnav());
  final SpecialAllProductController _specialAllProductController =
      Get.put(SpecialAllProductController());
  SpBookmarkController _spBookmarkController = Get.put(SpBookmarkController());
  HomeController _homeController = Get.put(HomeController());
  final SpecialCategoryController _specialCategory1Controller =
      Get.put(SpecialCategoryController());
  var id;
  Future carts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(Appurl.cartitem), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData10 = jsonDecode(response.body)['count'];

      return userData10;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? cartcount;
  @override
  void initState() {
    super.initState();
    cartcount = carts();
  }

  var tokenp;
  var _selectedIndex = 2;
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final productCount = AppImage.carouselImages.length;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 130, 194),

        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: Icon(Icons.arrow_back_ios)),
        //   title:  Text(
        //                               data[index].category.name.toString(),
        //                               style: TextStyle(
        //                                   fontSize: 24,
        //                                   color: Color.fromARGB(255, 255, 0, 0),
        //                                   fontWeight: FontWeight.bold),
        //                             ),
        // ),
        // App bar in ListView.buielder Leading IconButton
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Appcolor.primaryColor,
                height: size.height * 0.07,
                width: double.infinity,
                child: FutureBuilder<List<SpecialAllProductData>?>(
                    future: _specialAllProductController.getSpecialAllProduct(
                        widget.token, widget.id),
                    builder: (context, snapshot) {
                      // print('Print from ui ${snapshot.data}');
                      if (!snapshot.hasData || snapshot.data == []) {
                        return Center(
                            child: Center(
                                child: Center(
                                    child:
                                        ShimmerEffect.gridviewShimerLoader())));
                      } else {
                        if (!snapshot.hasData) {
                          //snapshot.data!.isEmpty
                          return Center(child: Text('No Product Found'.tr));
                        } else {
                          final data = snapshot.data;
                          // App bar in Leading IconButton
                          return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                    leading: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(Icons.arrow_back_ios),
                                      color: Colors.white,
                                    ),
                                    title: Center(
                                      child: Text(
                                        data[index].category.name.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ));
                              }));
                        }
                      }
                    }),
              ),
              Container(
                height: size.height - 80,
                // color: Colors.blue,
                child: FutureBuilder<List<SpecialAllProductData>?>(
                    future: _specialAllProductController.getSpecialAllProduct(
                        widget.token, widget.id),
                    builder: (context, snapshot) {
                      // print('Print from ui ${snapshot.data}');
                      if (!snapshot.hasData || snapshot.data == []) {
                        return Center(
                            child: Center(
                                child: Center(
                                    child:
                                        ShimmerEffect.gridviewShimerLoader())));
                      } else {
                        if (!snapshot.hasData) {
                          //snapshot.data!.isEmpty
                          return Center(child: Text('No Product Found'.tr));
                        } else {
                          final data = snapshot.data;

                          return GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            itemCount: data!.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: .65,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                InkWell(
                              child: Container(
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
                                          0, 1), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    )
                                  ],
                                ),

                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * .01),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Image.network(
                                            data[index].image != null
                                                ? '${Appurl.baseURL}${data[index].image}'
                                                : 'https://upload.wikimedia.org/wikipedia/commons/d/dd/Avatar_flower.png',
                                            fit: BoxFit.cover,
                                            width: size.width * .4,
                                            height: size.height * .22,
                                          ),
                                        ),
                                        Positioned(
                                            top: 5,
                                            left: 0,
                                            child: Container(
                                                height: 30,
                                                width: 30,
                                                color: Colors.white,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      var status =
                                                          await _spBookmarkController
                                                              .addBookmarkProduct(
                                                                  _homeController
                                                                      .tokenGlobal,
                                                                  data[index]
                                                                      .id);

                                                      if (status == 200) {
                                                        setState(() {});
                                                        // Get.snackbar(
                                                        //     'Success'.tr,
                                                        //     'Product Added To Bookmark'
                                                        //         .tr);
                                                      }
                                                    },
                                                    icon: data[index]
                                                                .bookmark ==
                                                            false
                                                        ? Icon(
                                                            Icons
                                                                .favorite_border,
                                                            color: Colors.black,
                                                            size: 20,
                                                          )
                                                        : Icon(
                                                            Icons.favorite,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    0,
                                                                    0),
                                                            size: 20,
                                                          ))))
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .03,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: size.width * .4,
                                              child: Text(
                                                data[index].name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: size.height * .01),
                                            Text(
                                              "price".tr +
                                                  ' : ${data[index].ar_price} ' +
                                                  "kr".tr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * .02,
                                    ),
                                  ],
                                ),
                                // height: 147,
                                // width: ,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                            id: data[index].id,
                                            token: widget.token,
                                          )),
                                );
                              },
                            ),
                          );
                        }
                      }
                    }),
              ),
              SizedBox(height: size.height * .02),
            ],
          ),
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
                MaterialPageRoute(builder: (context) => SpecialHomeScreen()),
              );
            } else if (_selectedIndex == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BookmarkedProductShow()),
              );
            } else if (_selectedIndex == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          from: "special",
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
                icon:Obx(
                      () => Badge(
                    position: BadgePosition.topEnd(),
                    badgeContent: Container(
                      child: Text(
                        _cartControllers.count.value.toString() ,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ) ,
                title: Text("Cart Screen".tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite),
                title: Text("home-Special-day".tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text('Bookmarks'.tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'.tr),
                activeColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
