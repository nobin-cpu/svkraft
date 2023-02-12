import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/sub_category_controller.dart';
import 'package:sv_craft/Features/grocery/view/filter_product_show.dart';

import '../../../../constant/color.dart';

class FilterSubCatogory extends StatefulWidget {
  FilterSubCatogory({Key? key, required this.token, required this.id})
      : super(key: key);
  final String token;
  final int id;

  @override
  State<FilterSubCatogory> createState() => _FilterSubCatogoryState();
}

class _FilterSubCatogoryState extends State<FilterSubCatogory> {
  final GrocerySubCategoryController _grocerySubCategoryController =
      Get.put(GrocerySubCategoryController());

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'category $i');
  var list = [];
  // "Moviing",
  // "Assembly",
  // "Mounting",
  // "rice",
  // "Assistant",
  // "Delivery",
  // "pasta",
  // "Practice",
  // "Painting",
  // "Cleaning",
  // "Liffing"

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 0), () async {
      final subcategory = await _grocerySubCategoryController
          .getGrocerySubCategory(widget.token, widget.id);
      print(subcategory![0].name.toString());
      list.clear();
      if (subcategory != null) {
        setState(() {
          for (var task in subcategory) {
            list.add(task.name.toString());
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Product Subategories'),
      ),

      body: list != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: list != null
                  ? Wrap(
                      children: list
                          .map((f) => InkWell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  margin: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 10.0,
                                      bottom: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
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
                                  child: Text(
                                    '$f',
                                    style: const TextStyle(
                                      color: Appcolor.textColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterProductShow(
                                              subcategory: f,
                                              token: widget.token,
                                            )),
                                  );
                                },
                              ))
                          .toList(),
                    )
                  : Container(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),

      // : Center(child: CircularProgressIndicator()),

      // ListView.builder(
      //     itemCount: myProducts.length,
      //     itemBuilder: (context, index) {
      //       return Text('$category ${myProducts[index]}');
      //     }),
    );
  }
}
