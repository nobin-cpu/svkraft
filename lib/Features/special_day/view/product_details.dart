import 'dart:async';
import 'dart:convert';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/controllar/special_details_pro_con.dart';
import 'package:sv_craft/Features/special_day/model/special_pro_detals_m.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/Features/special_day/view/widgets/special_drawer.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/constant/shimmer_effects.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
    required this.token,
  }) : super(key: key);
  final int id;
  final String token;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final arabicNumber = ArabicNumbers();
  final SpecialDetailsProductController _specialDetailsProductController =
      Get.put(SpecialDetailsProductController());
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  HomeController _homeController = Get.put(HomeController());
  var details;
  var count = 0;
  var totalPrice = 0;
  // late int userId;
  var _selectedIndex = 2;
  PageController? _pageController;
  Future viewspecialrelated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(
        Uri.parse(Appurl.specialrelated + widget.id.toString()),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["data"];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? specialrelat;

  @override
  void initState() {
    super.initState();
    specialrelat = viewspecialrelated();
    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print('User id from details $userId');
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<SpecialProductDetailsData?>(
            future: _specialDetailsProductController.getSpecialProductDetails(
                widget.token, widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Center(
                        child: Center(
                            child: ShimmerEffect.gridviewShimerLoader())));
              } else {
                if (snapshot.data == null) {
                  return Center(
                      child: Center(
                          child: Center(
                              child: ShimmerEffect.gridviewShimerLoader())));
                } else {
                  final data = snapshot.data;
                  // print('Print from builder $data ');
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.35,
                          width: size.width,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  height: size.height * 55,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${Appurl.baseURL}${data!.image}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.name,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Html(
                                data: data.description,
                                style: {
                                  "html": Style(
                                    fontSize: FontSize(18.0),
                                    color: Colors.black87,
                                  ),
                                },
                              ),
                              Text('Quantity'.tr,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        count > 0 ? count-- : count = 0;
                                        totalPrice = (count * data.price);
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors
                                                .black12, //color of shadow
                                            spreadRadius: 2, //spread radius
                                            blurRadius: 5, // blur radius
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                            //first paramerter of offset is left-right
                                            //second parameter is top to down
                                          )
                                        ],
                                      ),
                                      width: 35,
                                      height: 35,
                                      child: const Text(
                                        '-',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 25),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors
                                                .black12, //color of shadow
                                            spreadRadius: 2, //spread radius
                                            blurRadius: 5, // blur radius
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                            //first paramerter of offset is left-right
                                            //second parameter is top to down
                                          )
                                        ],
                                      ),
                                      width: 50,
                                      height: 35,
                                      child: Text(
                                        arabicNumber.convert(count.toString()),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        count++;
                                        totalPrice = count * data.price;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors
                                                .black12, //color of shadow
                                            spreadRadius: 2, //spread radius
                                            blurRadius: 5, // blur radius
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                            //first paramerter of offset is left-right
                                            //second parameter is top to down
                                          )
                                        ],
                                      ),
                                      width: 35,
                                      height: 35,
                                      child: const Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .21,
                                  ),
                                  Text(
                                      "price".tr +
                                          arabicNumber.convert(data.ar_price) +
                                          "kr".tr,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "Total".tr +
                                          arabicNumber
                                              .convert(totalPrice.toString()) +
                                          "kr".tr,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal)),
                                  // SizedBox(
                                  //   width: size.width * .2,
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      if (count > 0) {
                                        var addResponce =
                                            await _addToCartController
                                                .addTocart(
                                          _homeController.userId,
                                          data.id,
                                          "special_day",
                                          count,
                                          totalPrice,
                                          widget.token,
                                        );
                                        addResponce != null
                                            ? Get.snackbar(
                                                "Cart added succesfully".tr,
                                                "",
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              )
                                            : "Cart didn't added";

                                        print('Message from ui ${addResponce}');

                                        //delayed
                                        Future.delayed(
                                            Duration(microseconds: 500), () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Appcolor.buttonColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors
                                                .black12, //color of shadow
                                            spreadRadius: 2, //spread radius
                                            blurRadius: 2, // blur radius
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                            //first paramerter of offset is left-right
                                            //second parameter is top to down
                                          )
                                        ],
                                      ),
                                      width: 170,
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Add to cart'.tr,
                                            style: TextStyle(
                                                color: Appcolor.textColor,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.shopping_cart,
                                            color: Colors.black,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * .90,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                          future: specialrelat,
                          builder: (_, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              return Container(
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Get.to(() => ProductDetails(
                                              id: snapshot.data[index]["id"],
                                              token: token,
                                            ));

                                        print(snapshot.data[index]["id"]
                                            .toString());
                                      },
                                      leading: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .05),
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .13,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                Appurl.baseURL +
                                                    snapshot.data[index]
                                                            ["image"]
                                                        .toString(),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      title: Text(snapshot.data[index]["name"]
                                          .toString()),
                                      subtitle: Text(snapshot.data[index]
                                              ["price"]
                                          .toString()),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("No Product Found".tr);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
            }),
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
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
}
