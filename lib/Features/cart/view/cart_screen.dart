import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sv_craft/Features/cart/controllar/cart_controller.dart';
import 'package:sv_craft/Features/cart/controllar/check_out_con.dart';
import 'package:sv_craft/Features/cart/controllar/delete_item_con.dart';
import 'package:sv_craft/Features/cart/view/checkout_screen.dart';
import 'package:sv_craft/Features/grocery/controllar/cart_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/constant/api_link.dart';

import 'package:arabic_numbers/arabic_numbers.dart';
import '../../../constant/color.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cartcontrollerofnav _cartControllers = Get.put(Cartcontrollerofnav());
  final arabicNumber = ArabicNumbers();
  final HomeController _homeController = Get.put(HomeController());
  final CartController _cartController = Get.put(CartController());
  final GetProfileController _profileController =
      Get.put(GetProfileController());
  final CartItemDeleteController _cartItemDeleteController =
      Get.put(CartItemDeleteController());
  final GetAddressController _getAddressController =
      Get.put(GetAddressController());
  final CheckoutController _checkoutController = Get.put(CheckoutController());
  GetProfileController getProfileController = Get.put(GetProfileController());
  var cartData;
  // var totalPrice = 0.0;
  var _selectedIndex = 1;
  PageController? _pageController;

  var itemCount = 0;
  var Address;
  var totalPrice = 0;
  var profile = GetProfileController();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showOverlay = false;
      });
    });
    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        show = false;
      });
    });
    super.initState();
    getProfileController.getUserProfile(token);
    Future.delayed(Duration.zero, () async {
      setState(() {
        setTokenToVariable();
      });
    });

    Future.delayed(const Duration(microseconds: 500), () async {
      setState(() {});
    });
  }

  Future<void> setTokenToVariable() async {
    final data = await _cartController.getCartProduct(
        _homeController.tokenGlobal, _homeController.userId);
    if (data != null) {
      setState(() {
        cartData = data;
        print("CartItems:::::${cartData}");
      });
    }

    var addrs =
        await _getAddressController.getAddress(_homeController.tokenGlobal);
    if (addrs != null) {
      print("addrs:::::$addrs");
      setState(() {
        Address = addrs;
      });
    }
  }

  List select = [];
  List<bool> selected = <bool>[];
  getindex(int itemCount) {
    for (var i = 0; i < itemCount; i++) {
      selected.add(false);
    }
  }

  bool showOverlay = true;
  bool show = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: showOverlay == true
            ? AlertDialog(
                backgroundColor: Colors.grey.shade200.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height * .8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Center(
                            child: LoadingAnimationWidget.threeRotatingDots(
                                color: Color.fromARGB(255, 0, 83, 217),
                                size: size.height * .04))),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: cartData != null
                    ? cartData.grocery.length > 0 ||
                            cartData.special_day.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cartData.user.name,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Cart Screen".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),

                              cartData.grocery.length > 0
                                  ? Column(
                                      children: [
                                        Container(
                                          color: const Color.fromARGB(
                                              31, 134, 129, 129),
                                          height: 40,
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Grocery Products".tr,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        cartData.grocery.length > 0
                                            ? ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    cartData.grocery.length,
                                                itemBuilder: (context, index) {
                                                  var singleGroceryPrice =
                                                      cartData.grocery[index]
                                                              .price /
                                                          cartData
                                                              .grocery[index]
                                                              .quantity;

                                                  totalPrice =
                                                      cartData.totalPrice;

                                                  getindex(
                                                      cartData.grocery.length);
                                                  return Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SizedBox(
                                                              height: 50,
                                                              width: 70,
                                                              // color: Colors.redAccent,
                                                              child:
                                                                  Image.network(
                                                                '${Appurl.baseURL}${cartData.grocery[index].image}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            cartCardDesing(
                                                                size,
                                                                index,
                                                                singleGroceryPrice),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (cartData
                                                                        .grocery
                                                                        .length ==
                                                                    1) {
                                                                  var responce =
                                                                      await _cartItemDeleteController
                                                                          .cartItemDelete(
                                                                    _homeController
                                                                        .tokenGlobal,
                                                                    _homeController
                                                                        .userId,
                                                                    cartData
                                                                        .grocery[
                                                                            index]
                                                                        .id,
                                                                    'grocery',
                                                                  );

                                                                  if (responce !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      setTokenToVariable();
                                                                    });

                                                                    print(
                                                                        "Item deleted");
                                                                    _cartControllers
                                                                        .onInit();
                                                                  } else {
                                                                    setState(
                                                                        () {});
                                                                    print(
                                                                        "Item not deleted");
                                                                  }
                                                                  setState(() {
                                                                    cartData
                                                                        .grocery
                                                                        .length = 0;
                                                                  });
                                                                } else {
                                                                  var responce =
                                                                      await _cartItemDeleteController
                                                                          .cartItemDelete(
                                                                    _homeController
                                                                        .tokenGlobal,
                                                                    _homeController
                                                                        .userId,
                                                                    cartData
                                                                        .grocery[
                                                                            index]
                                                                        .id,
                                                                    'grocery',
                                                                  );

                                                                  if (responce !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      setTokenToVariable();
                                                                    });

                                                                    print(
                                                                        "Item deleted");
                                                                    _cartControllers
                                                                        .onInit();
                                                                  } else {
                                                                    setState(
                                                                        () {});
                                                                    print(
                                                                        "Item not deleted");
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              child:
                                                                  const SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_outline_outlined,
                                                                    color: Colors
                                                                        .deepPurple,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            cartCountMEthod(
                                                                index,
                                                                singleGroceryPrice),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : SizedBox(
                                                child: Text("grocery deleted"),
                                              ),
                                      ],
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text("grocery deleted"),
                                      ),
                                    ),

                              cartData.special_day.length > 0
                                  ? Column(
                                      children: [
                                        Container(
                                          color: const Color.fromARGB(
                                              31, 134, 129, 129),
                                          height: 40,
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Special Day Products".tr,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87),
                                              ),
                                              Spacer(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        cartData.special_day.length > 0
                                            ? ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    cartData.special_day.length,
                                                itemBuilder: (context, index) {
                                                  var singlespecial_dayPrice =
                                                      cartData
                                                              .special_day[
                                                                  index]
                                                              .price /
                                                          cartData
                                                              .special_day[
                                                                  index]
                                                              .quantity;

                                                  totalPrice =
                                                      cartData.totalPrice;

                                                  getindex(cartData
                                                      .special_day.length);
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Container(
                                                      // key: ValueKey(myProducts[index]),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 0),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 100,
                                                                  width:
                                                                      size.width /
                                                                          6,
                                                                  // color: Colors.redAccent,
                                                                  child: Image
                                                                      .network(
                                                                    '${Appurl.baseURL}${cartData.special_day[index].image}',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 100,
                                                                  width:
                                                                      size.width /
                                                                          2.8,
                                                                  //color: Colors.black87,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          cartData
                                                                              .special_day[index]
                                                                              .name,
                                                                          style: const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black54),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          "price".tr +
                                                                              arabicNumber.convert(singlespecial_dayPrice.toString()) +
                                                                              "kr".tr,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w300,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          31,
                                                                          145,
                                                                          140,
                                                                          140),
                                                                      width: 1,
                                                                    ),
                                                                  ),
                                                                  height: 74,
                                                                  width:
                                                                      size.width /
                                                                          5,
                                                                  //color: Colors.redAccent,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      //cartData.special_day[index].quantity.toString()
                                                                      Text(
                                                                          arabicNumber.convert(cartData
                                                                              .special_day[
                                                                                  index]
                                                                              .quantity
                                                                              .toString()),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                      const Spacer(),

                                                                      //////deeeeeeffffff
                                                                      /////frfff
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          cartData.special_day[index].quantity > 1
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      //Product count
                                                                                      cartData.special_day[index].quantity > 1 ? cartData.special_day[index].quantity = (cartData.special_day[index].quantity) - 1 : null;

                                                                                      //Item price total
                                                                                      cartData.special_day[index].price = cartData.special_day[index].quantity * singlespecial_dayPrice.toInt();

                                                                                      //  Total price
                                                                                      cartData.special_day[index].quantity >= 1 && cartData.totalPrice > 0 ? cartData.totalPrice = cartData.totalPrice - (cartData.special_day[index].price / cartData.special_day[index].quantity).toInt() : null;
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(
                                                                                      color: const Color.fromARGB(220, 245, 243, 243),
                                                                                      borderRadius: BorderRadius.circular(0),
                                                                                      boxShadow: const [
                                                                                        BoxShadow(
                                                                                          color: Colors.black12, //color of shadow
                                                                                          spreadRadius: 1, //spread radius
                                                                                          blurRadius: 0, // blur radius
                                                                                          offset: Offset(0, 0), // changes position of shadow
                                                                                          //first paramerter of offset is left-right
                                                                                          //second parameter is top to down
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                    width: 35,
                                                                                    height: 35,
                                                                                    child: const Text(
                                                                                      '-',
                                                                                      style: TextStyle(color: Colors.black54, fontSize: 20),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  child: Center(
                                                                                    child: Text(""),
                                                                                  ),
                                                                                ),
                                                                          const SizedBox(
                                                                            height:
                                                                                2,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                cartData.special_day[index].quantity = (cartData.special_day[index].quantity) + 1;

                                                                                //Item price total
                                                                                cartData.special_day[index].price = (cartData.special_day[index].price) + singlespecial_dayPrice.toInt();

                                                                                //Total price
                                                                                cartData.totalPrice = cartData.totalPrice + (cartData.special_day[index].price / cartData.special_day[index].quantity).toInt();

                                                                                print(cartData.totalPrice);
                                                                              });
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.all(5),
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                color: const Color.fromARGB(220, 245, 243, 243),
                                                                                borderRadius: BorderRadius.circular(0),
                                                                                boxShadow: const [
                                                                                  BoxShadow(
                                                                                    color: Colors.black12, //color of shadow
                                                                                    spreadRadius: 1, //spread radius
                                                                                    blurRadius: 0, // blur radius
                                                                                    offset: Offset(0, 0), // changes position of shadow
                                                                                    //first paramerter of offset is left-right
                                                                                    //second parameter is top to down
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              width: 35,
                                                                              height: 35,
                                                                              child: const Text(
                                                                                '+',
                                                                                style: TextStyle(color: Colors.black54, fontSize: 20),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 100,
                                                                  width:
                                                                      size.width /
                                                                          4,
                                                                  // color: Colors.blue,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          if (cartData.special_day.length ==
                                                                              1) {
                                                                            var responce =
                                                                                await _cartItemDeleteController.cartItemDelete(
                                                                              _homeController.tokenGlobal,
                                                                              _homeController.userId,
                                                                              cartData.special_day[index].id,
                                                                              'special_day',
                                                                            );

                                                                            if (responce !=
                                                                                null) {
                                                                              setState(() {});
                                                                              setTokenToVariable();

                                                                              print("Item deleted");
                                                                              _cartControllers.onInit();
                                                                            } else {
                                                                              setState(() {});
                                                                              print("Item not deleted");
                                                                            }
                                                                            setState(() {
                                                                              cartData.special_day.length = 0;
                                                                            });
                                                                          } else {
                                                                            var responce =
                                                                                await _cartItemDeleteController.cartItemDelete(
                                                                              _homeController.tokenGlobal,
                                                                              _homeController.userId,
                                                                              cartData.special_day[index].id,
                                                                              'special_day',
                                                                            );
                                                                            setState(() {});

                                                                            if (responce !=
                                                                                null) {
                                                                              setState(() {});
                                                                              setTokenToVariable();

                                                                              print("Item deleted");
                                                                              _cartControllers.onInit();
                                                                            } else {
                                                                              setState(() {});
                                                                              print("Item not deleted");
                                                                            }
                                                                          }
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons.delete),
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Text(
                                                                        arabicNumber.convert(cartData.special_day[index].price.toString()) +
                                                                            // "${cartData.special_day[index].price.toString()} " +
                                                                            "kr".tr,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.black54),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                })
                                            : SizedBox(
                                                child: Text(
                                                    "special cart deleted"),
                                              ),
                                      ],
                                    )
                                  : Container(
                                      child: Text("special cart deleted"),
                                    ),

                              const SizedBox(
                                height: 30,
                              ),

                              Container(
                                // padding: const EdgeInsets.symmetric(horizontal: 20),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12, //color of shadow
                                      spreadRadius: 1, //spread radius
                                      blurRadius: 0, // blur radius
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    )
                                  ],
                                ),
                                width: size.width,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.list_alt_outlined,
                                        color: Colors.black, size: 20),
                                    SizedBox(width: 10),
                                    Text(
                                      'Save to List'.tr,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // const CartListTile(text: 'Totalbelopp', price: '3711,01'),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12, //color of shadow
                                      spreadRadius: 1, //spread radius
                                      blurRadius: 0, // blur radius
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    )
                                  ],
                                ),
                                width: size.width,
                                height: 50,
                                child: Row(
                                  children: [
                                    Text(
                                      'Total amount'.tr,
                                      style: const TextStyle(
                                          color: Colors.black54, fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Spacer(),
                                    Text(
                                      arabicNumber
                                              .convert(cartData.totalPrice) +
                                          "kr".tr,
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 100),
                            ],
                          )
                        : SizedBox(
                            child: Padding(
                              padding: EdgeInsets.only(top: size.height * .5),
                              child: Center(
                                child: Text("No Product Found".tr),
                              ),
                            ),
                          )
                    : Padding(
                        padding: EdgeInsets.only(top: size.height * .5),
                        child: show == true
                            ? Center(child: CircularProgressIndicator())
                            : Center(
                                child: Text("No Product Found".tr),
                              ),
                      )),
        floatingActionButton: cartData == null
            ? SizedBox()
            : FloatingActionButton.extended(
                isExtended: true,
                onPressed: () async {
                  final bodyData = {
                    '"grocery"': json.encode(cartData.grocery ?? []),
                    '"special_day"': json.encode(cartData.special_day ?? []),
                    // "total_price": totalPrice,
                  };

                  // log('$bodyData $totalPrice');

                  var statusCode = await _checkoutController.checkout(
                      bodyData, totalPrice, _homeController.tokenGlobal);

                  if (statusCode == 200) {
                    print(totalPrice);
                    Get.to(() => CheckoutScreen());
                    // print(int.parse(getProfileController
                    //     .userProfileModel.value.data!.coins
                    //     .toString()));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Address != null

                    //     ||
                    //                 getProfileController.userProfileModel.value
                    //                         .data!.coins ==
                    //                     cartData.totalPrice
                    //             ? const CheckoutScreen()
                    //             : AddressScreen()))

                    // if (Address!.phone != null) {
                    //   // Get.to(() => AddressScreen());
                    //   print("if");
                    //   // if (int.parse(getProfileController
                    //   //         .userProfileModel.value.data!.coins
                    //   //         .toString()) !=
                    //   //     cartData.totalPrice) {
                    //   //   Get.defaultDialog(
                    //   //       title: "sorry coins not enough",
                    //   //       middleText: "purchase coins from here",
                    //   //       backgroundColor: Appcolor.primaryColor,
                    //   //       titleStyle: TextStyle(color: Colors.white),
                    //   //       middleTextStyle: TextStyle(color: Colors.white),
                    //   //       radius: 30,
                    //   //       actions: [
                    //   //         Center(
                    //   //           child: ElevatedButton(
                    //   //               onPressed: () {
                    //   //                 Get.to(() => HomeScreen());
                    //   //               },
                    //   //               child: Text("OK")),
                    //   //         )
                    //   //       ]);
                    //   // }

                    // } else {
                    //   // Get.to(() => CheckoutScreen());
                    //   print("else");
                    // }
                    ;
                  } else {
                    Get.snackbar('Error'.tr, 'Something went wrong'.tr);
                  }
                },
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Go to Checkout'.tr,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Total".tr +
                                  arabicNumber.convert(cartData.totalPrice) +
                                  "kr".tr,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Get.to(() => CartScreen());
            } else if (_selectedIndex == 2) {
              Get.to(BookmarkedProductScreen());
            } else if (_selectedIndex == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            }
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart'.tr),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: Icon(Icons.favorite_border_outlined),
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

  Row cartCountMEthod(int index, singleGroceryPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //cartData.grocery[index].quantity.toString()

        //////deeeeeeffffff
        /////frfff
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cartData.grocery[index].quantity > 1
                ? InkWell(
                    onTap: () {
                      setState(() {
                        //Product count
                        cartData.grocery[index].quantity > 1
                            ? cartData.grocery[index].quantity =
                                (cartData.grocery[index].quantity) - 1
                            : null;

                        //Item price total
                        cartData.grocery[index].price =
                            cartData.grocery[index].quantity *
                                singleGroceryPrice.toInt();

                        //Total price
                        cartData.grocery[index].quantity >= 1 &&
                                cartData.totalPrice > 0
                            ? cartData.totalPrice = cartData.totalPrice -
                                (cartData.grocery[index].price /
                                        cartData.grocery[index].quantity)
                                    .toInt()
                            : null;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade200.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: 30,
                      height: 30,
                      child: const Center(
                        child: Text(
                          '-',
                          style:
                              TextStyle(color: Colors.deepPurple, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  arabicNumber
                      .convert(cartData.grocery[index].quantity.toString()),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  cartData.grocery[index].quantity =
                      (cartData.grocery[index].quantity) + 1;

                  //Item price total
                  cartData.grocery[index].price =
                      (cartData.grocery[index].price) +
                          singleGroceryPrice.toInt();

                  //Total price
                  cartData.totalPrice = cartData.totalPrice +
                      (cartData.grocery[index].price /
                              cartData.grocery[index].quantity)
                          .toInt();

                  print(cartData.totalPrice);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade200.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                width: 30,
                height: 30,
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Container cartCardDesing(Size size, int index, singleGroceryPrice) {
    return Container(
      height: 70,
      width: size.width / 2.8,
      //color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cartData.grocery[index].name,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "price".tr +
                  arabicNumber.convert(singleGroceryPrice.toString()) +
                  "kr".tr,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
