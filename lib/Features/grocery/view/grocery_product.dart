import 'dart:async';
import 'dart:ui';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/bookmarks/controller/add_to_bookmarks_con.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/controllar/all_product_controller.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_add_product.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/controllar/searched_product_con.dart';
import 'package:sv_craft/Features/grocery/model/all_product_model.dart';
import 'package:sv_craft/Features/grocery/model/sub_item_model.dart';
import 'package:sv_craft/Features/grocery/view/bookmarks_screen.dart';
import 'package:sv_craft/Features/grocery/view/grocery_search_page.dart';
import 'package:sv_craft/Features/grocery/view/payment_history.dart';
import 'package:sv_craft/Features/grocery/view/see_all_products.dart';
import 'package:sv_craft/Features/grocery/view/widgets/categori_filter.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_drawer.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/common/log_x.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/services/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/color.dart';
import '../../../constant/shimmer_effects.dart';
import 'offers_screen.dart';
import 'order_history_screen.dart';

class GroceryProduct extends StatefulWidget {
  @override
  _GroceryProductState createState() {
    return _GroceryProductState();
  }
}

class _GroceryProductState extends State<GroceryProduct> {
  var selectedindexcat = 0;
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
  // Variable
  var tokenp;
  late int userId;
  bool _isSearched = false;
  var searchedData;
  var _selectedIndex = 2;
  PageController? _pageController;

  bool isLoading = false;
  int? _productIndex;

  final TextEditingController _searchController = TextEditingController();

  bool _searchBoolean = false;
  final List<int> _searchIndexList = [];
  var product = 0;

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (String name) async {
        Future.delayed(const Duration(seconds: 1), () async {
          final searchProduct = await _grocerySearchController
              .getGrocerySearchProduct(tokenp, name);
          print(name);

          if (searchProduct != null) {
            setState(() {
              _isSearched = true;
              searchedData = searchProduct;
              // print('searchProduct = ${searchedData[0].name}');
            });
          }
        });
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
          color: Appcolor.textColor,
          fontSize: 20,
        ),
      ),
    );
  }

  //Access confirmation dialog
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late GroceryAllProduct groceryAllProduct;
  bool haveaccess = true;
  bool accessreq = false;
  bool accessgrant = false;
  @override
  void initState() {
    super.initState();
    getGroceryProducts();

    haveaccess
        ? print('have access')
        : accessreq
            ? Timer(const Duration(seconds: 1), () {
                _showaccessbegged();
              })
            : accessgrant
                ? print("Access granted")
                : Timer(const Duration(seconds: 1), () {
                    _showMyDialog();
                  });
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
    Future.delayed(const Duration(seconds: 2), () async {
      const Center(
          child: Center(
              child: SpinKitFadingCircle(
        color: Colors.black,
      )));
    });
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      getProductbyId(groceryAllProduct.data[0].id.toString());
      getProductbyId("0");
      selectIndex = 0;
      setState(() {});
    });
  }

  Future<void> setTokenToVariable() async {
    final token = await _allProductController.getToken();

    setState(() {
      tokenp = token;
    });

    final userid = await _allProductController.getUserId();

    setState(() {
      userId = userid;
    });

    // Get bookmarks category name
    var bookmarkCategory = await _bookmarkCategoryController
        .getBookmarkCategory(_homeController.tokenGlobal);
    if (bookmarkCategory != null) {
      setState(() {
        _bookmarkCategoryController.BookmarkCategory = bookmarkCategory;
      });
    }
    // setState(() {
    //   BookmarkCategory = bookmarkCategory;
    //   print("Print from ui ${BookmarkCategory[0].length}");
    // });
  }

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Grocery product build");
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        Get.to(() => HomeScreen());
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 135, 235, 157),
        key: _scaffoldKey,
        drawer: Drawer(
            child: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(OfferScreen());
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
                                "Offers".tr,
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
                  Get.to(GroceryBookmarks());
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
                  Get.to(OrderHistoryScreen());
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
                              Icon(Icons.list),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Order History".tr,
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
                onTap: () {},
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
                                "Call US".tr,
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
              // InkWell(
              //   onTap: () {
              //     Get.to(PaymentHistoryPage());
              //   },
              //   child: Container(
              //       color: Color.fromARGB(243, 244, 244, 244),
              //       height: MediaQuery.of(context).size.height * .09,
              //       width: double.infinity,
              //       child: Padding(
              //         padding: EdgeInsets.all(14),
              //         child: Align(
              //             alignment: Alignment.centerLeft,
              //             child: Row(
              //               children: [
              //                 Icon(Icons.history),
              //                 SizedBox(
              //                   width: 9,
              //                 ),
              //                 Text(
              //                   "Payment History".tr,
              //                   style: TextStyle(
              //                       fontSize: 17, fontWeight: FontWeight.bold),
              //                 ),
              //               ],
              //             )),
              //       )),
              // ),

              // Container(
              //   height: 1,
              //   width: MediaQuery.of(context).size.width * .90,
              //   color: Color.fromARGB(115, 58, 58, 58),
              // ),
            ],
          ),
        )),

        appBar: AppBar(
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Appcolor.primaryColor,
          elevation: 0,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black, //<-- SEE HERE
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
            ],
          ),
          title: !_searchBoolean
              ? Text(
                  "home-grocery".tr,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : _searchTextField(),
          actions: !_searchBoolean
              ? [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          Future.delayed(const Duration(microseconds: 500),
                              () async {
                            _searchBoolean = true;
                          });

                          // _searchIndexList = [];

                          Get.off(() => GrocerySearchPage());
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black, //<-- SEE HERE
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_alt_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Get.to(CategoriFilter());
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * .02,
                  ),
                ]
              : [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          Future.delayed(const Duration(microseconds: 500),
                              () async {
                            _searchBoolean = false;
                            _isSearched = false;
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(width: size.width * .02),
                ],
        ),

        body: Container(
          child: isLoading
              ? ShimmerEffect.horizontalScrollItems()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///// categoris ui desing here..
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: GridView.builder(
                            reverse: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisExtent:
                                  MediaQuery.of(context).size.height * .17,
                            ),
                            itemCount: groceryAllProduct.data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  selectIndex = index;
                                  selectedindexcat = index;
                                  // getProductbyId(groceryAllProduct.data[index].id.toString());
                                  setState(() {
                                    getProductbyId(groceryAllProduct
                                        .data[index].id
                                        .toString());
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: selectIndex == index
                                          ? Colors.blueAccent
                                          : Colors.white24,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
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
                                                  groceryAllProduct
                                                      .data[index].image,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .18,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text(
                                                groceryAllProduct
                                                    .data[index].name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      isproductByIdLoading
                          ? ShimmerEffect.gridviewShimerLoader()
                          : Container(),
                      isClicked
                          ? SizedBox(
                              child:
                                  //  selectedindexcat == 0
                                  //     ?
                                  ListView.builder(
                                      itemCount: subItemModel.data!.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, subIndex) {
                                        var productItem =
                                            subItemModel.data![subIndex];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    productItem.title,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          SeeAllProductsScreen(
                                                        title:
                                                            productItem.title,
                                                        id: productItem.id
                                                            .toString(),
                                                      ));
                                                    },
                                                    child:
                                                        // Text(
                                                        //   "View All".tr,
                                                        //   style: TextStyle(
                                                        //     color: Colors.black,
                                                        //     shadows: [
                                                        //       Shadow(
                                                        //           color: Colors
                                                        //               .transparent,
                                                        //           offset: Offset(0, -5))
                                                        //     ],
                                                        //     fontWeight: FontWeight.bold,
                                                        //     decoration: TextDecoration
                                                        //         .underline,
                                                        //     decorationThickness: 3,
                                                        //   ),
                                                        // ),
                                                        Text(
                                                      "View All".tr,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .transparent, // Step 2 SEE HERE
                                                        shadows: [
                                                          Shadow(
                                                              offset:
                                                                  Offset(0, -6),
                                                              color:
                                                                  Colors.black)
                                                        ], // Step 3 SEE HERE
                                                        decoration:
                                                            TextDecoration
                                                                .underline,

                                                        decorationColor:
                                                            Color.fromARGB(
                                                                255, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.40,
                                              child: ListView.builder(
                                                  reverse: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      productItem.lists.length,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context,
                                                      subProductIndex) {
                                                    var subProduct = productItem
                                                        .lists[subProductIndex];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Container(
                                                        width: 180,
                                                        //color: Colors.green,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black12, //color of shadow
                                                              spreadRadius:
                                                                  2, //spread radius
                                                              blurRadius:
                                                                  5, // blur radius
                                                              offset: Offset(0,
                                                                  2), // changes position of shadow
                                                              //first paramerter of offset is left-right
                                                              //second parameter is top to down
                                                            )
                                                          ],
                                                        ),

                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      _bookmarkCategoryController.BookmarkCategory.length >
                                                                              0
                                                                          ? Get
                                                                              .dialog(
                                                                              AlertDialog(
                                                                                title: Text('Add To Bookmarks.'.tr),
                                                                                content: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: size.height * .2,
                                                                                      width: size.width * .6,
                                                                                      child: ListView.builder(
                                                                                          shrinkWrap: true,
                                                                                          itemCount: _bookmarkCategoryController.BookmarkCategory.length,
                                                                                          itemBuilder: (context, ind) {
                                                                                            return Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                                                              // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                                                              alignment: Alignment.center,
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                borderRadius: BorderRadius.circular(0),
                                                                                                boxShadow: const [
                                                                                                  BoxShadow(
                                                                                                    color: Colors.black12, //color of shadow
                                                                                                    spreadRadius: 1, //spread radius
                                                                                                    blurRadius: 0, // blur radius
                                                                                                    offset: Offset(0, 0), // changes position of shadow
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                              width: size.width * .4,
                                                                                              height: 40,
                                                                                              child: InkWell(
                                                                                                onTap: () async {
                                                                                                  var status = await _bookmarkProductAddController.addBookmarkProduct(_homeController.tokenGlobal, _bookmarkCategoryController.BookmarkCategory[ind].id, subProduct.id);
                                                                                                  if (status == 200) {
                                                                                                    setState(() {
                                                                                                      getGroceryProducts();
                                                                                                      status;
                                                                                                    });
                                                                                                    Get.back();
                                                                                                    // Navigator.of(context).pop();
                                                                                                    Get.to(GroceryProduct());
                                                                                                    // Get.snackbar('Success'.tr, 'Product Added To Bookmark'.tr);
                                                                                                    print("objectss" + _bookmarkCategoryController.BookmarkCategory[ind].id.toString());
                                                                                                  }
                                                                                                },
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    const Icon(Icons.list),
                                                                                                    const SizedBox(width: 20),
                                                                                                    Text(
                                                                                                      _bookmarkCategoryController.BookmarkCategory[ind].name,
                                                                                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                                                      textAlign: TextAlign.center,
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
                                                                          : Get
                                                                              .dialog(
                                                                              AlertDialog(
                                                                                title: Text('Add Bookmarks Category'.tr),
                                                                                content: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    TextFormField(
                                                                                      controller: _categoryController,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'Category Name'.tr,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                actions: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Get.back();
                                                                                        },
                                                                                        child: Text('Cancel'.tr),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () async {
                                                                                          var statusCode = await _bookmarkCategoryController.addBookmarkCategory(_homeController.tokenGlobal, _categoryController.text);

                                                                                          if (statusCode == 200) {
                                                                                            _categoryController.clear();
                                                                                            // Get.back();

                                                                                            Get.back();
                                                                                            // Get.snackbar('Success'.tr, 'Category Added'.tr);
                                                                                          } else {
                                                                                            Get.back();
                                                                                            Get.snackbar('Error'.tr, 'Category Not Added'.tr);
                                                                                          }
                                                                                          setState(() {});
                                                                                        },
                                                                                        child: Text('Add'.tr),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              barrierDismissible: false,
                                                                            ).then((value) =>
                                                                              setState(() {}));

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
                                                                    icon: subProduct.bookmark !=
                                                                            true
                                                                        ?
                                                                        //  _bookmarkCategoryController
                                                                        //                 .BookmarkCategory[productItem]
                                                                        //             [
                                                                        //             "bookmark"] ==
                                                                        //                productsItems[itemIndex]
                                                                        //         ['bookmark'] ==
                                                                        // true
                                                                        // ? Icon(
                                                                        //     Icons
                                                                        //         .favorite,
                                                                        //     color: Color
                                                                        //         .fromARGB(
                                                                        //             255,
                                                                        //             255,
                                                                        //             1,
                                                                        //             1),
                                                                        //     size: 30,
                                                                        //   )
                                                                        // : Icon(
                                                                        //     Icons
                                                                        //         .favorite_border_outlined,
                                                                        //     color: Colors
                                                                        //         .black,
                                                                        //     size: 30,
                                                                        //   ),
                                                                        //  _bookmarkProductAddController
                                                                        //             .addBookmarkProduct ==
                                                                        //         true
                                                                        //     ?
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
                                                                            Icons.favorite_outline,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            size:
                                                                                18,
                                                                          )
                                                                        : Icon(
                                                                            Icons.favorite,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                1,
                                                                                1),
                                                                            size:
                                                                                30,
                                                                          )),
                                                                const Spacer(),
                                                                Text(
                                                                  subProduct
                                                                      .marketPrice
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        .01),
                                                              ],
                                                            ),

                                                            Stack(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    // Appurl.baseURL+'${data[index].image}' ??
                                                                    Appurl.baseURL +
                                                                        '${subProduct.image}',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .43,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .16,
                                                                  ),
                                                                ),
                                                                subProduct.offPrice ==
                                                                        0
                                                                    ? SizedBox()
                                                                    : Positioned(
                                                                        top: 0,
                                                                        right:
                                                                            0,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              45,
                                                                          width:
                                                                              45,
                                                                          color:
                                                                              Colors.yellow,
                                                                          child:
                                                                              Text(
                                                                            "${subProduct.ar_off_price}% off",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w300,
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
                                                                SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        .03),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            .035,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            .25,
                                                                        child:
                                                                            FittedBox(
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          child:
                                                                              Text(
                                                                            subProduct.name,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          ),
                                                                        )),
                                                                    Text(
                                                                      "${subProduct.pricee} " +
                                                                          "kr".tr,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(
                                                                height:
                                                                    size.height *
                                                                        .01),
                                                            subProduct != null
                                                                ? GroceryCount(
                                                                    index:
                                                                        subProductIndex,
                                                                    // userId: userId,
                                                                    productId:
                                                                        subProduct
                                                                            .id,
                                                                    price: subProduct
                                                                        .price,
                                                                  )
                                                                : const Center(
                                                                    child: Center(
                                                                        child: SpinKitFadingCircle(
                                                                    color: Colors
                                                                        .black,
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
                                      })
                              // : ListView.builder(
                              //     itemCount: subItemModel.data!.length,
                              //     shrinkWrap: true,
                              //     primary: false,
                              //     itemBuilder: (context, subIndex) {
                              //       var productItem =
                              //           subItemModel.data![subIndex];
                              //       return Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Padding(
                              //             padding:
                              //                 const EdgeInsets.all(8.0),
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment
                              //                       .spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   productItem.title,
                              //                   style: TextStyle(
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 ),
                              //                 GestureDetector(
                              //                   onTap: () {
                              //                     Get.to(
                              //                         SeeAllProductsScreen(
                              //                       title:
                              //                           productItem.title,
                              //                       id: productItem.id
                              //                           .toString(),
                              //                     ));
                              //                   },
                              //                   child:
                              //                       // Text(
                              //                       //   "View All".tr,
                              //                       //   style: TextStyle(
                              //                       //     color: Colors.black,
                              //                       //     shadows: [
                              //                       //       Shadow(
                              //                       //           color: Colors
                              //                       //               .transparent,
                              //                       //           offset: Offset(0, -5))
                              //                       //     ],
                              //                       //     fontWeight: FontWeight.bold,
                              //                       //     decoration: TextDecoration
                              //                       //         .underline,
                              //                       //     decorationThickness: 3,
                              //                       //   ),
                              //                       // ),
                              //                       Text(
                              //                     "View All".tr,
                              //                     style: TextStyle(
                              //                       fontSize: 13,
                              //                       color: Colors
                              //                           .transparent, // Step 2 SEE HERE
                              //                       shadows: [
                              //                         Shadow(
                              //                             offset:
                              //                                 Offset(0, -6),
                              //                             color:
                              //                                 Colors.black)
                              //                       ], // Step 3 SEE HERE
                              //                       decoration:
                              //                           TextDecoration
                              //                               .underline,
                              )
                          //                       decorationColor:
                          //                           Color.fromARGB(
                          //                               255, 0, 0, 0),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             child: GridView.builder(
                          //                 gridDelegate:
                          //                     SliverGridDelegateWithFixedCrossAxisCount(
                          //                         crossAxisCount: 2,
                          //                         childAspectRatio: 1,
                          //                         mainAxisExtent:
                          //                             MediaQuery.of(
                          //                                         context)
                          //                                     .size
                          //                                     .height *
                          //                                 .4,
                          //                         crossAxisSpacing: 4.0,
                          //                         mainAxisSpacing: 4.0),
                          //                 scrollDirection:
                          //                     Axis.vertical,
                          //                 itemCount:
                          //                     productItem.lists.length,
                          //                 physics:
                          //                     const BouncingScrollPhysics(),
                          //                 primary: false,
                          //                 shrinkWrap: true,
                          //                 itemBuilder:
                          //                     (context, index2) {
                          //                   var subProduct = productItem
                          //                       .lists[index2];
                          //                   return Container(
                          //                     child: Padding(
                          //                       padding:
                          //                           const EdgeInsets
                          //                                   .symmetric(
                          //                               vertical: 1,
                          //                               horizontal: 8),
                          //                       child: Container(
                          //                         height: MediaQuery.of(
                          //                                     context)
                          //                                 .size
                          //                                 .height *
                          //                             .1,
                          //                         //color: Colors.green,
                          //                         alignment:
                          //                             Alignment.center,
                          //                         decoration:
                          //                             BoxDecoration(
                          //                           color: Colors.white,
                          //                           borderRadius:
                          //                               BorderRadius
                          //                                   .circular(
                          //                                       10),
                          //                           boxShadow: const [
                          //                             BoxShadow(
                          //                               color: Colors
                          //                                   .black12, //color of shadow
                          //                               spreadRadius:
                          //                                   2, //spread radius
                          //                               blurRadius:
                          //                                   5, // blur radius
                          //                               offset: Offset(
                          //                                   0,
                          //                                   2), // changes position of shadow
                          //                               //first paramerter of offset is left-right
                          //                               //second parameter is top to down
                          //                             )
                          //                           ],
                          //                         ),

                          //                         child: Column(
                          //                           mainAxisSize:
                          //                               MainAxisSize
                          //                                   .min,
                          //                           children: [
                          //                             Row(
                          //                               children: [
                          //                                 IconButton(
                          //                                     onPressed:
                          //                                         () {
                          //                                       _bookmarkCategoryController.BookmarkCategory.length >
                          //                                               0
                          //                                           ? Get
                          //                                               .dialog(
                          //                                               AlertDialog(
                          //                                                 title: Text('Add To Bookmarks.'.tr),
                          //                                                 content: Column(
                          //                                                   mainAxisSize: MainAxisSize.min,
                          //                                                   children: [
                          //                                                     SizedBox(
                          //                                                       height: size.height * .2,
                          //                                                       width: size.width * .6,
                          //                                                       child: ListView.builder(
                          //                                                           shrinkWrap: true,
                          //                                                           itemCount: _bookmarkCategoryController.BookmarkCategory.length,
                          //                                                           itemBuilder: (context, ind) {
                          //                                                             return Container(
                          //                                                               padding: const EdgeInsets.symmetric(horizontal: 20),
                          //                                                               // margin: const EdgeInsets.symmetric(horizontal: 20),
                          //                                                               alignment: Alignment.center,
                          //                                                               decoration: BoxDecoration(
                          //                                                                 color: Colors.white,
                          //                                                                 borderRadius: BorderRadius.circular(0),
                          //                                                                 boxShadow: const [
                          //                                                                   BoxShadow(
                          //                                                                     color: Colors.black12, //color of shadow
                          //                                                                     spreadRadius: 1, //spread radius
                          //                                                                     blurRadius: 0, // blur radius
                          //                                                                     offset: Offset(0, 0), // changes position of shadow
                          //                                                                   )
                          //                                                                 ],
                          //                                                               ),
                          //                                                               width: size.width * .4,
                          //                                                               height: 40,
                          //                                                               child: InkWell(
                          //                                                                 onTap: () async {
                          //                                                                   var status = await _bookmarkProductAddController.addBookmarkProduct(_homeController.tokenGlobal, _bookmarkCategoryController.BookmarkCategory[ind].id, subProduct.id);
                          //                                                                   if (status == 200) {
                          //                                                                     setState(() {
                          //                                                                       getGroceryProducts();
                          //                                                                       status;
                          //                                                                     });
                          //                                                                     Get.back();
                          //                                                                     // Navigator.of(context).pop();
                          //                                                                     Get.to(GroceryProduct());
                          //                                                                     // Get.snackbar('Success'.tr, 'Product Added To Bookmark'.tr);
                          //                                                                     print("objectss" + _bookmarkCategoryController.BookmarkCategory[ind].id.toString());
                          //                                                                   }
                          //                                                                 },
                          //                                                                 child: Row(
                          //                                                                   children: [
                          //                                                                     const Icon(Icons.list),
                          //                                                                     const SizedBox(width: 20),
                          //                                                                     Text(
                          //                                                                       _bookmarkCategoryController.BookmarkCategory[ind].name,
                          //                                                                       style: const TextStyle(color: Colors.black, fontSize: 15),
                          //                                                                       textAlign: TextAlign.center,
                          //                                                                     ),
                          //                                                                     const Spacer(),
                          //                                                                   ],
                          //                                                                 ),
                          //                                                               ),
                          //                                                             );
                          //                                                           }),
                          //                                                     )
                          //                                                   ],
                          //                                                 ),
                          //                                                 // actions: [],
                          //                                               ),
                          //                                               barrierDismissible: false,
                          //                                             )
                          //                                           : Get
                          //                                               .dialog(
                          //                                               AlertDialog(
                          //                                                 title: Text('Add Bookmarks Category'.tr),
                          //                                                 content: Column(
                          //                                                   mainAxisSize: MainAxisSize.min,
                          //                                                   children: [
                          //                                                     TextFormField(
                          //                                                       controller: _categoryController,
                          //                                                       decoration: InputDecoration(
                          //                                                         hintText: 'Category Name'.tr,
                          //                                                       ),
                          //                                                     ),
                          //                                                   ],
                          //                                                 ),
                          //                                                 actions: [
                          //                                                   Row(
                          //                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                                                     children: [
                          //                                                       TextButton(
                          //                                                         onPressed: () {
                          //                                                           Get.back();
                          //                                                         },
                          //                                                         child: Text('Cancel'.tr),
                          //                                                       ),
                          //                                                       TextButton(
                          //                                                         onPressed: () async {
                          //                                                           var statusCode = await _bookmarkCategoryController.addBookmarkCategory(_homeController.tokenGlobal, _categoryController.text);

                          //                                                           if (statusCode == 200) {
                          //                                                             _categoryController.clear();
                          //                                                             // Get.back();

                          //                                                             Get.back();
                          //                                                             // Get.snackbar('Success'.tr, 'Category Added'.tr);
                          //                                                           } else {
                          //                                                             Get.back();
                          //                                                             Get.snackbar('Error'.tr, 'Category Not Added'.tr);
                          //                                                           }
                          //                                                           setState(() {});
                          //                                                         },
                          //                                                         child: Text('Add'.tr),
                          //                                                       ),
                          //                                                     ],
                          //                                                   ),
                          //                                                 ],
                          //                                               ),
                          //                                               barrierDismissible: false,
                          //                                             ).then((value) =>
                          //                                               setState(() {}));

                          //                                       // var message =
                          //                                       //     await _addtoBookmarksController
                          //                                       //         .addToBookmarks(
                          //                                       //             userId,
                          //                                       //             data[index].id,
                          //                                       //             "grocery",
                          //                                       //             tokenp);

                          //                                       // if (message != null) {
                          //                                       //   Get.snackbar(
                          //                                       //       "Product Added to Bookmarks",
                          //                                       //       message);
                          //                                       // } else {
                          //                                       //   print("Not Added");
                          //                                       // }
                          //                                     },
                          //                                     icon: subProduct.bookmark !=
                          //                                             true
                          //                                         ?
                          //                                         //  _bookmarkCategoryController
                          //                                         //                 .BookmarkCategory[productItem]
                          //                                         //             [
                          //                                         //             "bookmark"] ==
                          //                                         //                productsItems[itemIndex]
                          //                                         //         ['bookmark'] ==
                          //                                         // true
                          //                                         // ? Icon(
                          //                                         //     Icons
                          //                                         //         .favorite,
                          //                                         //     color: Color
                          //                                         //         .fromARGB(
                          //                                         //             255,
                          //                                         //             255,
                          //                                         //             1,
                          //                                         //             1),
                          //                                         //     size: 30,
                          //                                         //   )
                          //                                         // : Icon(
                          //                                         //     Icons
                          //                                         //         .favorite_border_outlined,
                          //                                         //     color: Colors
                          //                                         //         .black,
                          //                                         //     size: 30,
                          //                                         //   ),
                          //                                         //  _bookmarkProductAddController
                          //                                         //             .addBookmarkProduct ==
                          //                                         //         true
                          //                                         //     ?
                          //                                         // subProduct
                          //                                         //         .bookmark
                          //                                         //     ? const Icon(
                          //                                         //         FontAwesome
                          //                                         //             .book_bookmark,
                          //                                         //         color: Colors
                          //                                         //             .blue,
                          //                                         //         size: 18,
                          //                                         //       )
                          //                                         //     :
                          //                                         Icon(
                          //                                             Icons.favorite_outline,
                          //                                             color: Color.fromARGB(255, 0, 0, 0),
                          //                                             size: 18,
                          //                                           )
                          //                                         : Icon(
                          //                                             Icons.favorite,
                          //                                             color: Color.fromARGB(255, 255, 1, 1),
                          //                                             size: 30,
                          //                                           )),
                          //                                 const Spacer(),
                          //                                 Text(
                          //                                   subProduct
                          //                                       .marketPrice
                          //                                       .toString(),
                          //                                   textAlign:
                          //                                       TextAlign
                          //                                           .center,
                          //                                 ),
                          //                                 const SizedBox(
                          //                                   width: 5,
                          //                                 ),
                          //                                 SizedBox(
                          //                                     width: size
                          //                                             .width *
                          //                                         .01),
                          //                               ],
                          //                             ),

                          //                             Stack(
                          //                               children: [
                          //                                 Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .symmetric(
                          //                                     horizontal:
                          //                                         10,
                          //                                   ),
                          //                                   child: Image
                          //                                       .network(
                          //                                     // Appurl.baseURL+'${data[index].image}' ??
                          //                                     Appurl.baseURL +
                          //                                         '${subProduct.image}',
                          //                                     fit: BoxFit
                          //                                         .cover,
                          //                                     width: MediaQuery.of(context)
                          //                                             .size
                          //                                             .width *
                          //                                         .43,
                          //                                     height: MediaQuery.of(context)
                          //                                             .size
                          //                                             .height *
                          //                                         .16,
                          //                                   ),
                          //                                 ),
                          //                                 subProduct.offPrice ==
                          //                                         0
                          //                                     ? SizedBox()
                          //                                     : Positioned(
                          //                                         top:
                          //                                             0,
                          //                                         right:
                          //                                             0,
                          //                                         child:
                          //                                             Container(
                          //                                           height:
                          //                                               45,
                          //                                           width:
                          //                                               45,
                          //                                           color:
                          //                                               Colors.yellow,
                          //                                           child:
                          //                                               Text(
                          //                                             "${subProduct.ar_off_price}% off",
                          //                                             textAlign: TextAlign.center,
                          //                                             style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300, color: Colors.red),
                          //                                           ),
                          //                                         ))
                          //                               ],
                          //                             ),
                          //                             // SizedBox(
                          //                             //   height: size.height * .02,
                          //                             // ),
                          //                             Row(
                          //                               children: [
                          //                                 SizedBox(
                          //                                     width: size
                          //                                             .width *
                          //                                         .03),
                          //                                 Column(
                          //                                   crossAxisAlignment:
                          //                                       CrossAxisAlignment
                          //                                           .start,
                          //                                   mainAxisAlignment:
                          //                                       MainAxisAlignment
                          //                                           .center,
                          //                                   children: [
                          //                                     Text(
                          //                                       subProduct
                          //                                           .name,
                          //                                       style:
                          //                                           const TextStyle(
                          //                                         fontSize:
                          //                                             12,
                          //                                         fontWeight:
                          //                                             FontWeight.w500,
                          //                                         color:
                          //                                             Colors.black,
                          //                                       ),
                          //                                       textAlign:
                          //                                           TextAlign.start,
                          //                                     ),
                          //                                     Text(
                          //                                       "${subProduct.pricee} " +
                          //                                           "kr".tr,
                          //                                       style:
                          //                                           const TextStyle(
                          //                                         fontSize:
                          //                                             18,
                          //                                         fontWeight:
                          //                                             FontWeight.bold,
                          //                                         color:
                          //                                             Colors.black,
                          //                                       ),
                          //                                     ),
                          //                                   ],
                          //                                 ),
                          //                               ],
                          //                             ),

                          //                             SizedBox(
                          //                                 height:
                          //                                     size.height *
                          //                                         .01),
                          //                             subProduct != null
                          //                                 ? GroceryCount(
                          //                                     index:
                          //                                         index2,
                          //                                     // userId: userId,
                          //                                     productId:
                          //                                         subProduct
                          //                                             .id,
                          //                                     price: subProduct
                          //                                         .price,
                          //                                   )
                          //                                 : const Center(
                          //                                     child: Center(
                          //                                         child: SpinKitFadingCircle(
                          //                                     color: Colors
                          //                                         .black,
                          //                                   ))),

                          //                             SizedBox(
                          //                                 height: 5),
                          //                           ],
                          //                         ),
                          //                         // height: 147,
                          //                         // width: ,
                          //                       ),
                          //                     ),
                          //                   );
                          //                 }),
                          //           )
                          //         ],
                          //       );
                          //     }))

                          : Container()
                    ],
                  ),
                ),
        ),

        // bottomNavigationBar: const GroceryNav(),
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
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => GroceryProduct()),
              // );
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
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.shopping_cart),
                ),
                title: Text("Cart Screen".tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(Icons.shopping_bag)),
                title: Text("home-grocery".tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                title: Text("Bookmarks".tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile".tr),
                activeColor: Colors.white),
          ],
        ),
      ),
    ));
  }

  // SizedBox categorisUiDesing() {
  //   return SizedBox(
  //     height: 100,
  //     child: ListView.builder(
  //         itemCount: groceryAllProduct.data.length,
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return InkWell(
  //             onTap: () {
  //               selectIndex = index;
  //               // getProductbyId(groceryAllProduct.data[index].id.toString());
  //               setState(() {
  //                 getProductbyId(groceryAllProduct.data[index].id.toString());
  //               });
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 width: 85,
  //                 decoration: BoxDecoration(
  //                   color: selectIndex == index
  //                       ? Colors.blueAccent
  //                       : Colors.white24,
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Image.network(
  //                       Appurl.baseURL + groceryAllProduct.data[index].image,
  //                       height: 45,
  //                       width: 45,
  //                       fit: BoxFit.cover,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(1.0),
  //                       child: Text(groceryAllProduct.data[index].name,
  //                           style: const TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.normal)),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  late SubItemModel subItemModel;
  bool isClicked = false;
  bool isproductByIdLoading = false;
  Future<void> _showMyDialog() async {
    print("object");
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "You don't have",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "access for",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "SVCRAFT SHOP",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    _showaccessbegged();
                  },
                  child: const Text(
                    "Get Access",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                )
              ],
            ));
      },
    );
  }

  Future<void> _showaccessbegged() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Card(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Your request in review\nplease wait!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  void getGroceryProducts() async {
    setState(() {
      isLoading = true;
    });
    var url = Appurl.baseURL + "api/groceries/category/all";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    http.Response response =
        await http.get(Uri.parse(url), headers: headersForAuth);
    // print("Response:::::::${response.body}");
    if (response.statusCode == 200) {
      setState(() {});
      var data = groceryAllProductFromJson(response.body);
      groceryAllProduct = data;
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error",
          response.body.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void getProductbyId(String id) async {
    setState(() {
      isproductByIdLoading = true;
    });
    var url = Appurl.baseURL + "api/groceries/v2/category/$id";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      if (response.statusCode == 200) {
        setState(() {});
        var res = subItemModelFromJson(response.body);

        subItemModel = res;
      } else {
        print('Product not found');
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error",
          e.toString());
    }
    setState(() {
      isproductByIdLoading = false;
      isClicked = true;
    });
  }
}
