import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/resturant/resturanthome.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/main.dart';

import '../../constant/color.dart';
import '../grocery/controllar/cart_count.dart';
import '../profile/controller/get_profile_con.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Cartcontrollerofnav _cartControllers = Get.put(Cartcontrollerofnav());
  final HomeController _homeController = Get.put(HomeController());
  final GetProfileController getProfileController =
      Get.put(GetProfileController());

  PageController? _pageController;
  var _selectedIndex = 0;

  late int userId;
  final List locale = [
    {'name': 'English', 'locale': Locale("eng")},
    {'name': 'Svenska', 'locale': Locale("swe")},
    {'name': 'عربى', 'locale': Locale("arabic")}
  ];
  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (Builder) {
          return AlertDialog(
            title: Text("choose a language".tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: locale.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        updatelanguage(locale[index]["locale"]);
                      },
                      child: Text(locale[index]["name"]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
              ),
            ),
          );
        });
  }

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
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });

    //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    final tokensss = await _homeController.getToken();
    // print('token = ' + token);
    setState(() {
      _homeController.tokenGlobal = getTOken;
      token = tokensss;
    });

    final userid = await _homeController.getUserId();
    // print('token = ' + token);
    mainUserID = userid;
    setState(() {
      _homeController.userId = userid;
      token = _homeController.tokenGlobal.toString();
    });

    getProfileController.getUserProfile(token);
//  setUserInFirebase();
    print("Home Initialized::::");
  }

  void setUserInFirebase() {
    final fs = FirebaseFirestore.instance;
    fs
        .collection('users')
        .doc("user${getProfileController.userProfileModel.value.data!.id}")
        .set({
      'name': getProfileController.userProfileModel.value.data!.name.toString(),
      "userid": getProfileController.userProfileModel.value.data!.id.toString(),
      'profileImage':
          getProfileController.userProfileModel.value.data!.image.toString(),
    });
  }

  bool showOverlay = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("YES"),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                    TextButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                actions: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                    child: IconButton(
                      icon: Icon(
                        Icons.language,
                        color: Appcolor.iconColor,
                        size: 20,
                      ),
                      onPressed: () {
                        builddialog(context);
                      },
                    ),
                  ),
                ],
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  "SV_Kraft".tr,
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 230, 180, 0)),
                ),
              ),
              body: WillPopScope(
                onWillPop: () async {
                  // Get.to(() => HomeScreen());
                  return false;
                },
                child: Stack(children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: size.height * .25,
                            width: size.width,
                            //color: const Color.fromARGB(255, 70, 192, 230),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 66, 163, 192),
                                  Color.fromARGB(255, 253, 251, 250),
                                ],
                              ),
                              //borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("home-marketplace".tr,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                Spacer(),
                                Image.asset(
                                  'images/market.png',
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: size.height * .25,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.toNamed('/marketplace');
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: size.height * .25,
                            width: size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 35, 117, 53),
                                  Color.fromARGB(255, 253, 251, 250),
                                ],
                              ),
                              //borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("home-grocery".tr,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                const Spacer(),
                                Image.asset(
                                  'images/grocery.png',
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: size.height * .25,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.toNamed('/groceryproduct');
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: size.height * .25,
                            width: size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 158, 30, 105),
                                  Color.fromARGB(255, 253, 251, 250),
                                ],
                              ),
                              //borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("home-Special-day".tr,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                                const Spacer(),
                                Image.asset(
                                  'images/special.png',
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: size.height * .25,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.toNamed("/specialhome");
                          },
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Container(
                            height: size.height * .25,
                            width: size.width,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 145, 31, 42),
                                  Color.fromARGB(255, 253, 251, 250),
                                ],
                              ),
                              //borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("home-restaurant".tr,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                    Text("coming soon".tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ],
                                ),
                                const Spacer(),
                                Image.asset(
                                  'images/restaurant.png',
                                  fit: BoxFit.cover,
                                  width: 140,
                                  height: size.height * .25,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // Get.to(() => Resturanthome());
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              bottomNavigationBar: BottomNavyBar(
                backgroundColor: Appcolor.primaryColor,
                selectedIndex: _selectedIndex,
                showElevation: true,
                onItemSelected: (index) => setState(() {
                  _selectedIndex = index;
                  _pageController?.animateToPage(index,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.ease);

                  if (_selectedIndex == 0) {
                    print("Home");
                  } else if (_selectedIndex == 1) {
                    Get.to(() => CartScreen());
                  } else if (_selectedIndex == 2) {
                    Get.to(() => BookmarkedProductScreen());
                  } else if (_selectedIndex == 3) {
                    Get.to(() => ProfileScreen());
                  }
                }),
                items: [
                  BottomNavyBarItem(
                    icon: const Icon(Icons.home),
                    title: Text('Home'.tr),
                    activeColor: Colors.white,
                  ),
                  BottomNavyBarItem(
                      icon: Obx(
                        () => Badge(
                          position: BadgePosition.topEnd(),
                          badgeContent: Container(
                            child: Text(
                              _cartControllers.count.value.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          child: Icon(Icons.shopping_cart_outlined),
                        ),
                      ),
                      title: Text("Cart Screen".tr),
                      activeColor: Colors.white),
                  BottomNavyBarItem(
                      icon: const Icon(Icons.favorite_border),
                      title: Text('Bookmarks'.tr),
                      activeColor: Colors.white),
                  BottomNavyBarItem(
                      icon: Icon(Icons.person),
                      title: Text('Profile'.tr),
                      activeColor: Colors.white),
                ],
              )),
        ));
  }
}
