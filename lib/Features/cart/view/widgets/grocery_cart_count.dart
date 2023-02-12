import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/cart/controllar/addtocart_con.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/constant/color.dart';

class GroceryCartCount extends StatefulWidget {
  const GroceryCartCount({
    Key? key,
    required this.index,
    required this.productId,
    required this.price,
    required this.count,
    required this.category,
  }) : super(key: key);

  final int index;
  final int productId;
  final double price;
  final int count;
  final String category;

  @override
  State<GroceryCartCount> createState() => _GroceryCountState();
}

class _GroceryCountState extends State<GroceryCartCount> {
  CartScreen cartScreen = CartScreen();
  final AddtocartController _addToCartController =
      Get.put(AddtocartController());
  final HomeController _homeController = Get.put(HomeController());
  int count = 0;
  double price = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            setState(() {
              widget.count > 0 ? count = widget.count - 1 : count = 0;
              price = widget.price * count;
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
                // Navigator.pop(context);
              });
            });
            if (count > 0) {
              var addResponce = await _addToCartController.addTocart(
                _homeController.userId,
                widget.productId,
                widget.category,
                count,
                price.toInt(),
                _homeController.tokenGlobal,
              );

              //delayed
              // Future.delayed(Duration(microseconds: 500), () {
              //   Navigator.pop(context);
              // });

            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 245, 243, 243),
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
        ),
        SizedBox(
          height: 2,
        ),
        InkWell(
          onTap: () async {
            setState(() {
              count = widget.count + 1;
              price = widget.price * count;

              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              });
            });
            if (count > 0) {
              var addResponce = await _addToCartController.addTocart(
                _homeController.userId,
                widget.productId,
                widget.category,
                count,
                price.toInt(),
                _homeController.tokenGlobal,
              );

              //delayed
              // Future.delayed(Duration(microseconds: 500), () {
              //   Navigator.pop(context);
              // });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(220, 245, 243, 243),
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
    );
  }
}
