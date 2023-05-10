import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

import '../../controllar/cart_count.dart';

class GroceryCount extends StatefulWidget {
  const GroceryCount({
    Key? key,
     required this.index,
    required this.productId,
    required this.price,
  }) : super(key: key);

  final int index;
  final int productId;
  final double price;

  @override
  State<GroceryCount> createState() => _GroceryCountState();
}

class _GroceryCountState extends State<GroceryCount> {
  final Cartcontrollerofnav _cartControllers = Get.put(Cartcontrollerofnav());
  final arabicNumber = ArabicNumbers();
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  final HomeController _homeController = Get.put(HomeController());
  var count = 0;
  var price = 0.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              count > 1 ? count-- : count = 0;
              // if (count > 1) {
              //   count--;
              // } else if (count == 0) {
              //   count = count;
              // }
              price = widget.price * count;
            });
            if (count >= 0) {
              var addResponce = await _addToCartController.addTocart(
                _homeController.userId,
                widget.productId,
                "grocery",
                count,
                price.toInt(),
                _homeController.tokenGlobal,
              );
            }
            _cartControllers.onInit();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.primaryColor,
              borderRadius: BorderRadius.circular(100),
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
            width: 35,
            height: 35,
            child: const Text(
              '-',
              style: TextStyle(color: Colors.white, fontSize: 25),
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
              color: Appcolor.primaryColor,
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
              arabicNumber.convert(count),
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () async {
            setState(() {
              count++;
              price = widget.price * count;
              print(price);
            });
            if (count > 0) {
              var addResponce = await _addToCartController.addTocart(
                _homeController.userId,
                widget.productId,
                "grocery",
                count,
                price.toInt(),
                _homeController.tokenGlobal,
              );

              print('Message from ui ${addResponce}');

              //delayed
              // Future.delayed(Duration(microseconds: 500), () {
              //   Navigator.pop(context);
              // });
            }
            _cartControllers.onInit();
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Appcolor.primaryColor,
              borderRadius: BorderRadius.circular(100),
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
            width: 35,
            height: 35,
            child: const Text(
              '+',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
