import 'dart:convert';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/market_place/view/market_place.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';

import 'package:sv_craft/Features/profile/view/my_profile_screen.dart';
import 'package:sv_craft/Features/profile/view/settings_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/shimmer_effects.dart';
import '../../grocery/controllar/cart_count.dart';
import 'coin_redeam_page.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, this.from}) : super(key: key);

  final String? from;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Cartcontrollerofnav _cartControllers = Get.put(Cartcontrollerofnav());
  var title = "";
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController smscontroller = TextEditingController();
  final arabicNumber = ArabicNumbers();
  PageController? _pageController;
  var _selectedIndex = 4;
  GetProfileController getProfileController = Get.put(GetProfileController());
  Future withdraw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.help),
    );
    request.fields.addAll({
      'subject': titlecontroller.text,
      'message': smscontroller.text,
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          titlecontroller.clear();
          smscontroller.clear();
          var data = jsonDecode(response.body);
          print(titlecontroller.text);
          // saveprefs(data["token"]);
          // chat.clear();
          Get.back();
          setState(() {});
        } else {
          print(title);
          print(response.body.toString());
          // Fluttertoast.showToast(
          //     msg: "Error Occured",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          return response.body;
        }
      });
    });
  }

  saveprefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', token);
  }

  Future destroy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth-token');
    await prefs.remove('user-id');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.deleteaccount),
    );
    // request.fields.addAll({
    //   'otp': pin,
    //   'phone': widget.number,
    // });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print("massge sent");

          // chat.clear();
          Get.to(SigninScreen());
          setState(() {});
        } else {
          print("Fail! ");

          print(response.body.toString());

          return response.body;
        }
      });
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
    getProfileController.getUserProfile(token);
  }

  List profileItems = [
    {
      "Name": "Profile Settings".tr,
      "Icon": Icon(Icons.people),
    },
    {
      "Name": "Language".tr,
      "Icon": Icon(Icons.settings),
    },
    {
      "Name": "Privacy and Policy".tr,
      "Icon": Icon(Icons.support),
    },
    {
      "Name": "Help and Support".tr,
      "Icon": Icon(Icons.settings),
    },
    {
      "Name": "Logout".tr,
      "Icon": Icon(Icons.logout),
    },
  ];

  @override
  Widget build(BuildContext context) {
    //chnage
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.black26,
          height: MediaQuery.of(context).size.height,
          child: Obx(() {
            return (getProfileController.isLoading.value)
                ? ShimmerEffect.profileShimmerEffect()
                : Scaffold(
                    body: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * .4,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .06,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.white,
                                              )),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .1,
                                            ),
                                            child: Text(
                                              "Profile".tr,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    getProfileController.userProfileModel.value
                                                .data!.image !=
                                            null
                                        ? Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              backgroundImage: NetworkImage(
                                                  Appurl.baseURL +
                                                      getProfileController
                                                          .userProfileModel
                                                          .value
                                                          .data!
                                                          .image
                                                          .toString()),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 37,
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Icon(
                                                Icons.person,
                                                size: 37,
                                              ),
                                            ),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        getProfileController
                                            .userProfileModel.value.data!.name
                                            .toString(),
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(
                                            255, 255, 255, 255), // background
                                        // foreground
                                      ),
                                      onPressed: () {
                                        Get.to(CoinRedeamPage(
                                            // userId: getProfileController
                                            //     .userProfileModel.value.data!.id
                                            //     .toString(),
                                            ));
                                      },
                                      child: Text(
                                        "Coins : ".tr +
                                            arabicNumber.convert(
                                                getProfileController
                                                    .userProfileModel
                                                    .value
                                                    .data!
                                                    .coins
                                                    .toString()),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  scale: 0.1,
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                    "images/cur.jpeg",
                                  ),
                                )),
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .6,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(MyProfileScreen(
                                                    userProfileModel:
                                                        getProfileController
                                                            .userProfileModel
                                                            .value));
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(MyProfileScreen(
                                                      userProfileModel:
                                                          getProfileController
                                                              .userProfileModel
                                                              .value));
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.people,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 23,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Profile Settings".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .001,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(SettingsScreen());
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(SettingsScreen());
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.settings,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 23,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Language".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .001,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _launchUrl();
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  _launchUrl();
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.support,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 23,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Privacy and Policy".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .001,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40,
                                                              vertical: 20),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Help and Support"
                                                                  .tr,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(height: 8),
                                                            TextFormField(
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    UnderlineInputBorder(),
                                                                labelText:
                                                                    'Title'.tr,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            TextFormField(
                                                              maxLength: 556,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              maxLines: 6,
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      labelText:
                                                                          'Message'
                                                                              .tr,
                                                                      enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors
                                                                                  .grey)),
                                                                      focusedBorder:
                                                                          UnderlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(color: Colors.black),
                                                                      ),
                                                                      errorBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color.fromARGB(255, 66, 125,
                                                                                  145))),
                                                                      hintText:
                                                                          "Message here"),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  withdraw();
                                                                },
                                                                child: Text(
                                                                    "Send"))
                                                          ],
                                                        ),
                                                      )),
                                                  isDismissible: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                  ),
                                                  enableDrag: false,
                                                );
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  Get.bottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.6,
                                                        color: Colors.white,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 40,
                                                                vertical: 20),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Help and Support"
                                                                    .tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              SizedBox(
                                                                  height: 8),
                                                              TextFormField(
                                                                controller:
                                                                    titlecontroller,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      UnderlineInputBorder(),
                                                                  labelText:
                                                                      'Title'
                                                                          .tr,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              TextFormField(
                                                                controller:
                                                                    smscontroller,
                                                                maxLength: 556,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                maxLines: 6,
                                                                decoration:
                                                                    InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        labelText: 'Message'
                                                                            .tr,
                                                                        enabledBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .grey)),
                                                                        focusedBorder:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.black),
                                                                        ),
                                                                        errorBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Color.fromARGB(255, 66, 125,
                                                                                    145))),
                                                                        hintText:
                                                                            "Message here"),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    withdraw();
                                                                    print("send"
                                                                        .tr);
                                                                  },
                                                                  child: Text(
                                                                      "Send"
                                                                          .tr))
                                                            ],
                                                          ),
                                                        )),
                                                    isDismissible: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              35),
                                                    ),
                                                    enableDrag: false,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.settings,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 23,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Help and Support".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .001,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(MyProfileScreen(
                                                    userProfileModel:
                                                        getProfileController
                                                            .userProfileModel
                                                            .value));
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              Color(0xff004d95),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .25,
                                                                child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          "Are you sure you wants to delete your account?"
                                                                              .tr,
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                destroy();
                                                                              },
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                                                  height: MediaQuery.of(context).size.height * .06,
                                                                                  width: MediaQuery.of(context).size.height * .1,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(7),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          "YES".tr,
                                                                                          style: TextStyle(color: Color(0xff004d95), fontWeight: FontWeight.bold),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                                                                  height: MediaQuery.of(context).size.height * .06,
                                                                                  width: MediaQuery.of(context).size.height * .08,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.all(0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                          "NO".tr,
                                                                                          style: TextStyle(color: Color(0xff004d95), fontWeight: FontWeight.bold),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.delete_forever,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 23,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Delete Account".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .001,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();

                                                await prefs
                                                    .remove('auth-token');
                                                await prefs.remove('user-id');

                                                Get.offAll(
                                                    () => SigninScreen());
                                              },
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  await prefs
                                                      .remove('auth-token');
                                                  await prefs.remove('user-id');

                                                  Get.offAll(
                                                      () => SigninScreen());
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .05,
                                                    ),
                                                    Icon(
                                                      Icons.logout,
                                                      color: Color.fromARGB(
                                                          255, 0, 107, 194),
                                                      size: 25,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .10,
                                                    ),
                                                    Text(
                                                      "Logout".tr,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        )));
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              if (widget.from == "market") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MarketPlace()),
                );
              } else if (widget.from == "grocery") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GroceryProduct()),
                );
              } else if (widget.from == "special") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialHomeScreen()),
                );
              }
            } else if (_selectedIndex == 3) {
              Get.to(BookmarkedProductScreen());
            } else if (_selectedIndex == 4) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
            }
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
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
                icon: Icon(Icons.shopping_bag),
                title: Text(''),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_outline_outlined),
                title: Text('Bookmarks'.tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text("My Profile".tr),
                activeColor: Colors.white),
          ],
        ),
      ),
    );
  }

  void navigatorRoutinProfile(String rountName) async {
    GetProfileController getProfileController = Get.put(GetProfileController());

    switch (rountName) {
      case "My Profile":
        {
          Get.to(MyProfileScreen(
              userProfileModel: getProfileController.userProfileModel.value));
        }
        break;

      case "Settings":
        {
          Get.to(SettingsScreen());
        }
        break;
      case "Privacy and Policy":
        {
          _launchUrl();
        }
        break;
      case "Help and Support":
        {
          Get.bottomSheet(
            backgroundColor: Colors.transparent,
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Help And Support".tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        maxLength: 556,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Messages'.tr,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 125, 145))),
                            hintText: "Message here"),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            // withdraw();
                            print("hi");
                          },
                          child: Text("Send"))
                    ],
                  ),
                )),
            isDismissible: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            enableDrag: false,
          );
        }
        break;
      case "Logout":
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.remove('auth-token');
          await prefs.remove('user-id');

          Get.offAll(() => SigninScreen());
        }
        break;

      default:
        {}
        break;
    }
  }
}

Future<void> _launchUrl() async {
  final Uri webURl = Uri.parse(Appurl.baseURL + "terms");

  if (!await launchUrl(webURl)) {
    throw 'Could not launch $webURl';
  }
}
