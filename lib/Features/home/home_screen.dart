import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/view/bookmark_product_get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/resturant/resturanthome.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/main.dart';

import '../../constant/color.dart';
import '../profile/controller/get_profile_con.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final GetProfileController getProfileController =
      Get.put(GetProfileController());

  PageController? _pageController;
  var _selectedIndex = 0;

  late int userId;
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
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
            child: Column(
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
                                  color: Color.fromARGB(255, 255, 255, 255))),
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
                                  color: Color.fromARGB(255, 255, 255, 255))),
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
                                  color: Color.fromARGB(255, 255, 255, 255))),
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
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                              Text("coming soon".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
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
                      Get.to(() => Resturanthome());
                    },
                  ),
                ),
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
                  duration: const Duration(milliseconds: 300),
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
                  icon: const Icon(Icons.shopping_cart),
                  title: Text('Cart'.tr),
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
    );
  }
}
