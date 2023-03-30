import 'dart:async';
import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';

import 'package:sv_craft/Features/market_add_products/view/categoris_import_screen.dart';

import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/bookmark_con.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/market_place/view/chatlist.dart';
import 'package:sv_craft/Features/market_place/view/details.dart';
import 'package:sv_craft/Features/market_place/view/my_ads_screen.dart';
import 'package:sv_craft/Features/market_place/view/my_membership_screen.dart';
import 'package:sv_craft/Features/market_place/view/search_product_screen.dart';
import 'package:sv_craft/Features/market_place/widgets/filter_box_widgets.dart';
import 'package:sv_craft/Features/profile/view/my_adds.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/seller_profile/controller/show_all_product.dart';
import 'package:sv_craft/Features/seller_profile/models/seller_profile_model.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/seller_profile/view/profile.dart';
import 'package:sv_craft/Features/special_day/view/widgets/special_drawer.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

import 'package:http/http.dart' as http;
import 'package:sv_craft/constant/shimmer_effects.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../app/module/shops/controller/slider_controller.dart';
import '../../profile/controller/get_profile_con.dart';
import 'dart:developer' as devlog;

class MarketPlace extends StatefulWidget {
  MarketPlace({Key? key}) : super(key: key);

  String get sellerId => toString();

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();
  final sliderController = Get.put(SliderController());
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  final GetProfileController getProfileController =
      Get.put(GetProfileController());
  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  final HomeController _homeController = Get.put(HomeController());

  final ShowAllProductController _showAllProductController =
      Get.put(ShowAllProductController());

  final ShowSellerProfileController sellercon =
      Get.put(ShowSellerProfileController());
  final AllProductController _allProductController =
      Get.put(AllProductController());

  var count = 0;
  var totalPrice = 0;
  var _selectedIndex = 2;

  Map<String, dynamic>? sellerProfile = {};

  PageController? _pageController;

  final List<mCategory> _categoryList = [];
  var _categoryData;
  List marketDrawerItems = [
    {
      "Name": "My Ads",
      "Icon": Icon(Icons.ads_click),
    },
    {
      "Name": "My Membership",
      "Icon": Icon(Icons.card_membership),
    },
    {
      "Name": "Favourite",
      "Icon": Icon(Icons.favorite),
    },
    {
      "Name": "Messages",
      "Icon": Icon(Icons.message),
    },
    {
      "Name": "Privacy and Policy",
      "Icon": Icon(Icons.support),
    },
    {
      "Name": "Help and Support",
      "Icon": Icon(Icons.settings),
    },
    {
      "Name": "Call US",
      "Icon": Icon(Icons.call),
    },
  ];

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
      'message': messagecontroller.text,
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          print(titlecontroller.text);
          titlecontroller.clear();
          messagecontroller.clear();
          // saveprefs(data["token"]);
          // chat.clear();
          Get.back();
          setState(() {});
        } else {
          // print(title);
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

  Future viewOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(Appurl.callus), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_experience;

  @override
  void initState() {
    super.initState();
    viewall_experience = viewOffers();
    SellerProfile;
    setTokenToVariable();

    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      getDataFromProductID(0);
      getDataFromID("0");

      selectIndex = 0;
      setState(() {});
    });
  }

  var textToken = '';

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    textToken = token!;
    print(token);
    getCategoryProduct(textToken, id);
    return token;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user-id');
    return userId;
  }

  String? tokenGlobal;

  Future<void> setTokenToVariable() async {
    final responce = await _marketCategoryController
        .getmarketCategoryProduct(_homeController.tokenGlobal);
    _categoryList.clear();
    if (responce != null) {
      setState(() {
        _categoryData = responce;
      });
      for (var task in responce) {
        // _categoryList.name.add(task.categoryName);
        _categoryList.add(
          mCategory(
            categoryName: task.categoryName,
            image: task.image,
          ),
        );
      }
    }
  }

  Map<String, dynamic>? allProduct;
  Future<List<Datum>?> getCategoryProduct(String textToken, int id) async {
    try {
      var url = Appurl.baseURL + 'api/product/$id';

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = allProductFromJson(response.body);

        print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  bool itmesLoading = false;
  List productdet = [];
  void getDataFromID(String id) async {
    setState(() {
      itmesLoading = true;
    });
    try {
      var url = "http://svkraft.shop/api/product/0";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      devlog.log("esponse.body${response.body}");
      if (response.statusCode == 200) {
        // final allProduct = allProductFromJson(response.body);
        var pro = jsonDecode(response.body);

        print(pro);
        print(pro['data']);
        List product = pro['data'];
        // productdet = product;
        // print(productdet.length);
        // print("product:::::$product");
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    setState(() {
      itmesLoading = false;
    });
  }

  Future<void> setTokenToVariablea(String sellerId) async {
    var profile = await sellercon.getSellerProfileProduct(
        _homeController.tokenGlobal, widget.sellerId);
    if (profile != null) {
      setState(() {
        sellerProfile = profile as Map<String, dynamic>?;
      });
    }
  }

  @override
  dispose() {
    PageController;
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BookmarkController _bookmarkController = Get.put(BookmarkController());

  List productsItems = [];

  int selectIndex = 0;
  Map<String, dynamic>? rMap;

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

  bool isLoading = false;
  Color _favIconColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    final GetProfileController getProfileController =
        Get.put(GetProfileController());
    final size = MediaQuery.of(context).size;
    print("Market place page build");

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
            backgroundColor: Color.fromARGB(253, 255, 255, 255),
            child: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(MyAdds());
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.ads_click),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "My Ads".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Colors.black45,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(MySubscriptionScreen());
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.card_membership),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "My Membership".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(BookmarkedProductScreen());
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.favorite),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Favourite".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                  InkWell(
                    onTap: () {
                      // Get.to(
                      //   WebViewExam(
                      //     id1:
                      //         '${getProfileController.userProfileModel.value.data!.id}'));
                      Get.to(() => Chatlist());
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.message),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Messages".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                  InkWell(
                    onTap: () async {
                      final Uri webURl =
                          Uri.parse(Appurl.baseURL + "privacy-policy");

                      if (!await launchUrl(webURl)) {
                        throw 'Could not launch $webURl';
                      }
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.shield),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Privacy and Policy".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(Get.bottomSheet(
                        backgroundColor: Colors.transparent,
                        Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Help and Support".tr,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    controller: titlecontroller,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Title'.tr,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: messagecontroller,
                                    maxLength: 556,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Message'.tr,
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145))),
                                        hintText: "Message here".tr),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                      onPressed: () {
                                        withdraw();
                                      },
                                      child: Text("Send".tr))
                                ],
                              ),
                            )),
                        isDismissible: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        enableDrag: false,
                      ));
                    },
                    child: Container(
                        color: Color.fromARGB(243, 244, 244, 244),
                        height: MediaQuery.of(context).size.height * .09,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.settings),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Help and Support".tr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        )),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                  FutureBuilder(
                    future: viewall_experience,
                    builder: (_, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            launch("tel://${snapshot.data["support_no"]}");
                          },
                          child: Container(
                              color: Color.fromARGB(243, 244, 244, 244),
                              height: MediaQuery.of(context).size.height * .09,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(14),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Icon(Icons.call),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Text(
                                          "Call Us".tr,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              )),
                        );
                      } else {
                        return Text("No productt found");
                      }
                    },
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width * .90,
                    color: Color.fromARGB(115, 58, 58, 58),
                  ),
                ],
              ),
            )),
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getProfileController.userProfileModel.value.data!.postLimit == 0
                ? Get.to(MySubscriptionScreen())
                : Get.to(AddMarketProductScreen());
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Color.fromARGB(255, 143, 211, 231),
        appBar: AppBar(
            backgroundColor: Appcolor.primaryColor,
            elevation: 1,
            title: Text("home-marketplace".tr,
                style: TextStyle(
                    color: Appcolor.uperTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            actions: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Appcolor.iconColor,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.off(() => SearchProductScreen());
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                child: IconButton(
                  icon: Icon(
                    FontAwesome.sliders,
                    color: Appcolor.iconColor,
                    size: 20,
                  ),
                  onPressed: () async {
                    Get.to(() => FilterBoxWidget());
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
            ]),
        body: WillPopScope(
          onWillPop: () async {
            Get.to(() => HomeScreen());
            return true;
          },
          child: Container(
            child: isLoading
                ? ShimmerEffect.horizontalScrollItems()
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      // Container(
                      //   color: Color.fromARGB(255, 143, 211, 231),
                      //   height: 50,
                      //   width: double.infinity,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(10.0),
                      //     child: Row(
                      //       children: [
                      //         Text("today".tr,
                      //             style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontSize: 22,
                      //                 fontWeight: FontWeight.bold)),
                      //         Spacer(),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      _categoryData != null
                          ? SizedBox(
                              height: size.height * .3,
                              child: GridView.builder(
                                reverse: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                  mainAxisExtent:
                                      MediaQuery.of(context).size.height * .17,
                                ),
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _categoryData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      selectIndex = index;
                                      setState(() {
                                        getDataFromProductID(
                                            _categoryData[index].id);
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: selectIndex == index
                                              ? Colors.blueAccent
                                              : Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                Appurl.baseURL +
                                                    _categoryData[index].image,
                                                height: size.height * .068,
                                                width: size.width * .18,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text(
                                                    _categoryData[index]
                                                        .categoryName,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : ShimmerEffect.horizontalScrollItems(),
                      Container(
                        color: Color.fromARGB(255, 143, 211, 231),
                        height: 40,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              // Text("today".tr,
                              //     style: TextStyle(
                              //         color: Colors.black,
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold)),
                              // Spacer(),
                            ],
                          ),
                        ),
                      ),
                      itmesLoading
                          ? ShimmerEffect.gridviewShimerLoader()
                          : getGridviewDesignForCategorisItems(),
                      SizedBox(height: MediaQuery.of(context).size.height * .1)
                    ],
                  )),
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
            } else if (_selectedIndex == 2) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );

            } else if (_selectedIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookmarkedProductScreen()),
              );
            } else if (_selectedIndex == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                          from: "market",
                        )),
              );
            }
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("home-marketplace".tr),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                title: Text("chat"),
                icon: IconButton(
                    onPressed: () async {
                      // Get.to(WebViewExam(
                      //     id1:
                      //         '${getProfileController.userProfileModel.value.data!.id}'));
                      Get.to(() => Chatlist());
                    },
                    icon: Icon(
                      Icons.chat,
                    )),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.local_mall),
                title: Text(
                  "home-marketplace".tr,
                  overflow: TextOverflow.ellipsis,
                ),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_outline),
                title: Text('Bookmarks'.tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile".tr),
                activeColor: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget getGridviewDesignForCategorisItems() {
    return _categoryData != null
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: .75,
              mainAxisSpacing: MediaQuery.of(context).size.height * .04,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: List.generate(productsItems.length, (itemIndex) {
                devlog.log(productsItems[itemIndex].toString());

                return productsItems.isEmpty
                    ? Text("No product found")
                    : Container(
                        color: Appcolor.primaryColor,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detailss(
                                          productId: productsItems[itemIndex]
                                                  ["product_id"]
                                              .toString(),
                                          Id: productsItems[itemIndex]
                                                  ["product_id"]
                                              .toString(),
                                        )));
                          },
                          child: Container(
                            // height: 10,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    right: 0,
                                    left:
                                        MediaQuery.of(context).size.width * .0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.cover,
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .07),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .17,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .49,
                                                        child: Image.network(
                                                          Appurl.baseURL +
                                                              productsItems[
                                                                          itemIndex]
                                                                      [
                                                                      'image'][0]
                                                                  ["file_path"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                              Positioned(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .01,
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .0,
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      if (productsItems[
                                                                  itemIndex]
                                                              ['bookmark'] ==
                                                          true) {
                                                        var status = await _bookmarkController
                                                            .removeBookmarkProduct(
                                                                _homeController
                                                                    .tokenGlobal,
                                                                productsItems[
                                                                        itemIndex]
                                                                    [
                                                                    "product_id"]);

                                                        if (status == 200) {
                                                          productsItems[
                                                                      itemIndex]
                                                                  ['bookmark'] =
                                                              false;
                                                        }
                                                        //  getDataFromProductID(
                                                        //     _categoryData[selectIndex].id.toString());
                                                        setState(() {});
                                                      } else {
                                                        var status = await _bookmarkController
                                                            .addBookmarkProduct(
                                                                _homeController
                                                                    .tokenGlobal,
                                                                productsItems[
                                                                        itemIndex]
                                                                    [
                                                                    "product_id"]);

                                                        if (status == 200) {
                                                          productsItems[
                                                                      itemIndex]
                                                                  ['bookmark'] =
                                                              true;
                                                        }
                                                        //  getDataFromProductID(
                                                        //     _categoryData[selectIndex].id.toString());
                                                        setState(() {});
                                                      }
                                                    },
                                                    icon: productsItems[
                                                                    itemIndex]
                                                                ['bookmark'] ==
                                                            true
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    1,
                                                                    1),
                                                            size: 30,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .favorite_border_outlined,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            size: 27,
                                                          ),
                                                  )),
                                              productsItems[itemIndex]
                                                          ['location'] !=
                                                      null
                                                  ? Positioned(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .01,
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                      child: FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.pin_drop,
                                                                color: Colors
                                                                    .white),
                                                            Text(
                                                              '${productsItems[itemIndex]['location']}',
                                                              style: TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      .027,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 1,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02),
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                                '${productsItems[itemIndex]['product_name']}',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .02,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .016),
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Text(
                                              " ${productsItems[itemIndex]['price']} " +
                                                  "kr".tr,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .022),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ),
                      );
              }),
            ))
        : CircularProgressIndicator();
  }

  void getDataFromProductID(int id) async {
    setState(() {
      itmesLoading = true;
    });
    try {
      var url = Appurl.baseURL + "api/product/$id";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      devlog.log("esponse.body${response.body}");
      if (response.statusCode == 200) {
        // final allProduct = allProductFromJson(response.body);
        var pro = jsonDecode(response.body);

        List product = pro['data'];
        productsItems = product;
        // print("product:::::$product");
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    setState(() {
      itmesLoading = false;
    });
/*
    addUserinIFrenase();
*/
  }

  late CollectionReference _collectionReference;

  /*void addUserinIFrenase() async {
    print("CheckHomeFirebase:::");
    firebaseFirestore
        .collection('users')
        .doc(getProfileController.userProfileModel.value.data!.id.toString())
        .set({
      "name": getProfileController.userProfileModel.value.data!.name.toString(),
      "userid": getProfileController.userProfileModel.value.data!.id.toString(),
      "photoUrl":
          getProfileController.userProfileModel.value.data!.image.toString(),
    }).whenComplete(() => {print("Firenase....COmplete::::")});
  }*/

}

class ShowSellerProfileController extends GetxController {
  Future<SellerProfile?> getSellerProfileProduct(
    String textToken,
    String sellerId,
  ) async {
    try {
      var url = Appurl.baseURL + "api/product/user/$sellerId";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final sellerProfile = sellerProfileFromJson(response.body);

        return sellerProfile;
      } else {
        print('Seller not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }
}
