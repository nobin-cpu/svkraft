import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/controllar/category_1_con.dart';
import 'package:sv_craft/Features/special_day/controllar/special_all_product_con.dart';
import 'package:sv_craft/Features/special_day/model/category_1.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';
import 'package:sv_craft/Features/special_day/view/Bookmark_product_show.dart';
import 'package:sv_craft/Features/special_day/view/category_product.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/Features/special_day/view/search_page.dart';
import 'package:sv_craft/Features/special_day/view/specialdiscount.dart';
import 'package:sv_craft/Features/special_day/view/widgets/alarm_system.dart';
import 'package:sv_craft/app/constant/api_constant.dart';
import 'package:sv_craft/app/module/shops/controller/slider_controller.dart';
import 'package:sv_craft/common/post_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';
import 'package:sv_craft/main.dart';
import 'package:sv_craft/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/color.dart';
import '../../../constant/constant.dart';
import '../controllar/special_post_controller.dart';
import 'widgets/category_card.dart';
import 'widgets/special_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devlog;

class SpecialHomeScreen extends StatefulWidget {
  SpecialHomeScreen({Key? key}) : super(key: key);

  @override
  State<SpecialHomeScreen> createState() => _SpecialHomeScreenState();
}

class _SpecialHomeScreenState extends State<SpecialHomeScreen> {
  final sliderController = Get.put(SliderController());

  final AllProductController _allProductController =
      Get.put(AllProductController());
  final SpecialAllProductController _specialAllProductController =
      Get.put(SpecialAllProductController());
  final SpecialCategoryController _specialCategory1Controller =
      Get.put(SpecialCategoryController());
  final SpecialPostController specialPostController =
      Get.put(SpecialPostController());
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  var id;
  var _selectedIndex = 2;
  PageController? _pageController;
  var SpecialOfferName;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var tokenp;
  @override
  void initState() {
    super.initState();
    
    specialPostController.getSpecialRemainder();
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))

    // fetchUser();
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();
    print('token = ' + token);
    setState(() {
      tokenp = token;
    });

    //Get Special offer name
    var specialOfferName =
        await _specialCategory1Controller.getCategory1Product(tokenp);
    setState(() {
      SpecialOfferName = specialOfferName;
    });
  }

  List imgList = [
    'https://picsum.photos/500/300?random=1',
    'https://picsum.photos/500/300?random=2',
    'https://picsum.photos/500/300?random=3',
    'https://picsum.photos/500/300?random=4',
    'https://picsum.photos/500/300?random=5',
  ];

  List<String> _list = [
    'English Textbook',
    'Japanese Textbook',
    'English Vocabulary',
    'Japanese Vocabulary'
  ];

  // List userImage = [];

  // Future fetchUser() async {
  //   var url = Appurl.baseURL + "api/sliders";

  //   http.Response response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer L5CyOCbcsG827tJNMBN3FC3fvBK5UoHufM1GGg2i',
  //   });
  //   setState(() {
  //     var decode = jsonDecode(response.body);

  //     List userData = decode['data'];
  //     for (var i = 0; i < userData.length; i++) {
  //       userImage = userData.length as List;
  //       // userImage = userData.length as List;
  //       print(userImage);
  //     }
  //   });
  // }
  bool isLoading = false;
  @override
  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        // setState(() {
        //   _searchIndexList = [];
        //   for (int i = 0; i < _list.length; i++) {
        //     if (_list[i].contains(s)) {
        //       _searchIndexList.add(i);
        //     }
        //   }
        // });
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
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(child: ListTile(title: Text(_list[index])));
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 130, 194),
        key: _scaffoldKey,
        drawer: Drawer(
            child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(AlarmScreen());
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
                              Icon(Icons.local_activity),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Special Day".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                  Get.to(CategoryProuctScreen(
                    token: "token",
                    id: 5,
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
                              Icon(Icons.wallet_giftcard),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Wallet".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                  Get.to(CategoryProuctScreen(
                    token: "token",
                    id: 2,
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
                              Icon(Icons.favorite),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Flowers In Vases".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                  Get.to(CategoryProuctScreen(
                    token: "token",
                    id: 1,
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
                              Icon(Icons.fastfood_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Flower & Chocolate".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                  Get.to(CategoryProuctScreen(
                    token: "token",
                    id: 3,
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
                              Icon(Icons.payment),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Gift Box".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Title'.tr,
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
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
                                    hintText: "Message here"),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Send"))
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
                                    fontSize: 17, fontWeight: FontWeight.bold),
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
            ],
          ),
        )),
        appBar: AppBar(
          // leadingWidth: 300,
          // automaticallyImplyLeading: false,
          backgroundColor: Appcolor.primaryColor,
          elevation: 1,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Appcolor.iconColor,
                  size: 20,
                  // size: 44, // Changing Drawer Icon Size
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          centerTitle: true,

          title: !_searchBoolean
              ? Text(
                  "home-Special-day".tr,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : _searchTextField(),
          //!_searchBoolean ? : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Appcolor.iconColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        Future.delayed(const Duration(microseconds: 500),
                            () async {
                          _searchBoolean = true;
                        });

                        // _searchIndexList = [];

                        Get.off(() => SpecialSearchPage());
                      });
                    },
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                ]
              : [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black54, //<-- SEE HERE
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Appcolor.iconColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                ],
        ),
        body: tokenp == null
            ? Center(
                child: Center(
                    child:
                        Center(child: ShimmerEffect.horizontalScrollItems())),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   //padding: const EdgeInsets.all(5),
                    //   alignment: Alignment.center,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(0),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: Colors.black12, //color of shadow
                    //         spreadRadius: 1, //spread radius
                    //         blurRadius: 0, // blur radius
                    //         offset: Offset(0, 1), // changes position of shadow
                    //         //first paramerter of offset is left-right
                    //         //second parameter is top to down
                    //       )
                    //     ],
                    //   ),
                    //   width: size.width,
                    //   height: size.height * .3,
                    //   child: Image.asset(
                    //     'images/specialhome.png',
                    //     fit: BoxFit.cover,
                    //     width: size.width,
                    //     height: size.height * .3,
                    //   ),
                    // ),

                    sliderController.isLoading == true
                        ? Center(child: CircularProgressIndicator())
                        : CarouselSlider.builder(
                            itemCount: sliderController.items.length,
                            options: CarouselOptions(
                              // enableInfiniteScroll: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlay: true,
                              aspectRatio: 16 / 10,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              viewportFraction: 1.0,
                            ),
                            itemBuilder: (context, index, realIdx) {
                              return InkWell(
                                onTap: () {
                                  Get.to(SpecialDiscount(
                                    id: sliderController.items[index].id
                                        .toString(),
                                  ));
                                  print(sliderController.items[index].id
                                      .toString());
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(ApiConstant
                                              .media_base_url +
                                          sliderController.items[index].image
                                              .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: FutureBuilder<List<SpecialCategory1Datum>?>(
                          future: _specialCategory1Controller
                              .getCategory1Product(tokenp),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: Center(
                                      child: Center(
                                          child: ShimmerEffect.carous())));
                            } else {
                              if (snapshot.data == null) {
                                return Center(
                                    child: Center(
                                        child: Center(
                                            child: ShimmerEffect.carous())));
                              } else {
                                final data = snapshot.data;

                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1.4,
                                    mainAxisSpacing: 0.0,
                                    crossAxisSpacing: 0.0,
                                  ),
                                  itemCount: data!.length > 4 ? 4 : data.length,
                                  itemBuilder: (context, index) {
                                    return CategoryCard(
                                      text: data[index].name,
                                      imageLink:
                                          '${Appurl.baseURL}${data[index].image}',
                                      textColor: Colors.white,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryProuctScreen(
                                                    token: tokenp,
                                                    id: data[index].id,
                                                  )),
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            }
                          }),
                    ),
                    const SizedBox(height: 8),
                    specialPostController.isLoading == true
                        ? Center(child: ShimmerEffect.gridviewShimerLoader())
                        : specialPostController
                                .specialRemainderModel.value.data!.isEmpty
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlarmScreen()),
                                  );
                                },
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  padding: const EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Container(
                                      height: size.height * .2,
                                      width: size.width * .9,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: const NetworkImage(
                                                  "https://cdn.pixabay.com/photo/2014/12/08/11/49/couple-560783__340.jpg"),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.5),
                                                  BlendMode.darken))),
                                      // color: Colors.amber,
                                      child: Center(
                                        child: Text("Set Your Special Day".tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : sliderSpecialItems(size, context),
                    const SizedBox(
                      height: 5,
                    ),
                    SpecialOfferName != null
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: SpecialOfferName.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FutureBuilder<
                                      List<SpecialAllProductData>?>(
                                  future: _specialAllProductController
                                      .getSpecialAllProduct(
                                          tokenp, SpecialOfferName[index].id),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return Center(
                                          child: Center(
                                              child: Center(
                                                  child:
                                                      ShimmerEffect.carous())));
                                    } else {
                                      if (snapshot.data!.isEmpty) {
                                        //snapshot.data!.isEmpty
                                        return Center(
                                            child: Text('No Product Found'.tr));
                                      } else {
                                        final data = snapshot.data;

                                        // id = data![0].id;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(data![0].category.name,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  InkWell(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text("View All".tr,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                    ),
                                                    onTap: () {
                                                      Get.to(
                                                          CategoryProuctScreen(
                                                        token: token,
                                                        id: data[0].category.id,
                                                      ));

                                                      ;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * .32,
                                                child: GridView.builder(
                                                  // physics: NeverScrollableScrollPhysics(),
                                                  // shrinkWrap: true,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                                  itemCount: data.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 400,
                                                    childAspectRatio: 1.30,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 10,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          InkWell(
                                                    child: specialBottons(
                                                        data, index, size),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetails(
                                                                  id: data[
                                                                          index]
                                                                      .id,
                                                                  token: tokenp,
                                                                )),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }
                                  });
                            })
                        : Container(),
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );

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
              title: Text('Home'.tr),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart'.tr),
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

  CarouselSlider sliderSpecialItems(Size size, BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        height: size.height * .2,
        aspectRatio: 16 / 9,
        enlargeCenterPage: true,
      ),
      items: specialPostController.specialRemainderModel.value.data!
          .map(
            (item) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AlarmScreen()),
                  );
                },
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                            height: size.height * .2,
                            width: size.width * .9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        Appurl.baseURL + item.image.toString()),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.darken))),
                            // color: Colors.amber,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(item.title.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Text(
                                    item.time.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 240, 130, 194),
                                        shape: BoxShape.circle),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))))),
          )
          .toList(),
    );
  }

  Container specialBottons(
      List<SpecialAllProductData> data, int index, Size size) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          )
        ],
      ),

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Image.network(
              Appurl.baseURL + '${data[index].image}',
              fit: BoxFit.cover,
              width: size.width * .38,
              height: size.height * .17,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .3,
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
              const SizedBox(height: 6),
              Text(
                "price".tr + ": ${data[index].ar_price}" + "kr".tr,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      // height: 147,
      // width: ,
    );
  }
}
