import 'dart:async';
import 'dart:convert';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';
import 'package:sv_craft/Features/grocery/controllar/cart_count.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/view/see_all_details.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/special_day/view/widgets/special_drawer.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:http/http.dart' as http;

class Seedetails2 extends StatefulWidget {
  final String title;
  final String id, image, price, token, prices;
  final description;
  final productid;

  const Seedetails2(
      {super.key,
      required this.title,
      required this.id,
      required this.image,
      required this.price,
      required this.token,
      required this.prices,
      this.description = false,
      this.productid});

  @override
  State<Seedetails2> createState() => _Seedetails2State();
}

class _Seedetails2State extends State<Seedetails2> {
  final GroceryCategoryController groceryCategoryController =
      Get.put(GroceryCategoryController());
  final arabicNumber = ArabicNumbers();
  Cartcontrollerofnav _cartControllers = Get.put(Cartcontrollerofnav());
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  HomeController _homeController = Get.put(HomeController());
  var count = 0;
  var totalPrice = 0;
  Future viewOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(
        Uri.parse(Appurl.groceryrelated + "/" + widget.id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["data"];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_exp;

  @override
  void initState() {
    viewall_exp = viewOffers();
    new Timer.periodic(
        Duration(milliseconds: 200),
        (Timer t) => setState(() {
              counting();
              count;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                          image:
                              NetworkImage('${Appurl.baseURL}${widget.image}'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          _cartControllers.onInit();
                          setState(() {
                            count > 0 ? count-- : count = 0;
                            totalPrice = (count * int.parse(widget.prices));
                          });
                        },
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
                                offset:
                                    Offset(0, 2), // changes position of shadow
                                //first paramerter of offset is left-right
                                //second parameter is top to down
                              )
                            ],
                          ),
                          width: 35,
                          height: 35,
                          child: const Text(
                            '-',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      counting(),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _cartControllers.onInit();
                          print(widget.price);
                          Timer(Duration(milliseconds: 200), (() {
                            setState(() {
                              counting();
                            });
                          }));
                          setState(() {
                            count++;
                            totalPrice =
                                count * int.parse(widget.price.toString());
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
                          width: 35,
                          height: 35,
                          child: const Text(
                            '+',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Text('Price'.tr + arabicNumber.convert(widget.price),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                  widget.description != null
                      ? Container(
                          width: double.infinity,
                          child: Text(widget.description ?? ""),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: size.width * .2,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //     "Total".tr +
                          //         arabicNumber.convert(totalPrice.toString()) +
                          //         "kr".tr,
                          //     style: TextStyle(
                          //         color: Colors.black87,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.normal)),
                          // // SizedBox(
                          //   width: size.width * .2,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * .25),
                            child: InkWell(
                              onTap: () async {
                                if (count > 0) {
                                  _cartControllers.onInit();

                                  var addResponce =
                                      await _addToCartController.addTocart(
                                    _homeController.userId,
                                    int.parse(widget.id),
                                    "grocery",
                                    count,
                                    totalPrice,
                                    widget.token,
                                  );
                                  addResponce != null
                                      ? Get.snackbar(
                                          "Cart added succesfully".tr,
                                          "",
                                          snackPosition: SnackPosition.TOP,
                                        )
                                      : "Cart didn't added";

                                  print('Message from ui ${addResponce}');

                                  //delayed
                                  Future.delayed(Duration(microseconds: 500),
                                      () {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12, //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 2, // blur radius
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    )
                                  ],
                                ),
                                width: 170,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Add to cart'.tr,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: viewall_exp,
                    builder: (_, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              child: GridView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .46,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => Seedetails(
                                                      title: snapshot
                                                          .data[index]
                                                              ["product_name"]
                                                          .toString(),
                                                      id: snapshot.data[index]
                                                              ["product_id"]
                                                          .toString(),
                                                      image: snapshot
                                                          .data[index]["image"]
                                                          .toString(),
                                                      price: snapshot
                                                          .data[index]["price"]
                                                          .toString(),
                                                      token: tokenp.toString(),
                                                      prices: snapshot
                                                          .data[index]["price"]
                                                          .toString(),
                                                      description: widget
                                                          .description
                                                          .toString(),
                                                    ));
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  Appurl.baseURL +
                                                      snapshot.data[index]
                                                              ["image"]
                                                          .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => Seedetails(
                                                      title: widget.title
                                                          .toString(),
                                                      id: widget.id.toString(),
                                                      image: widget.image
                                                          .toString(),
                                                      price: widget.price
                                                          .toString(),
                                                      token: tokenp,
                                                      prices: widget.prices
                                                          .toString(),
                                                      description: widget
                                                          .description
                                                          .toString(),
                                                    ));
                                              },
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data[index]
                                                            ["product_name"]
                                                        .toString()),
                                                    Text(snapshot.data[index]
                                                                ["price"]
                                                            .toString() +
                                                        "kr".tr)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: .77,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing:
                                      MediaQuery.of(context).size.height * .02,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        );
                      } else {
                        return Text("No productt found");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  counting() {
    return InkWell(
      onTap: () {
        // Timer(Duration(microseconds: 2), (() {
        //   setState(() {});
        // }));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12, //color of shadow
              spreadRadius: 2, //spread radius
              blurRadius: 5, // blur radius
              offset: Offset(0, 2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            )
          ],
        ),
        width: 50,
        height: 35,
        child: Text(
          arabicNumber.convert(count.toString()),
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
