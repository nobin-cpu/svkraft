import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/constant/api_link.dart';

import 'category_product.dart';

class SpecialDiscount extends StatefulWidget {
  final String id;
  const SpecialDiscount({super.key, required this.id});

  @override
  State<SpecialDiscount> createState() => _SpecialDiscountState();
}

class _SpecialDiscountState extends State<SpecialDiscount> {
  Future viewOffer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(Uri.parse(Appurl.specialdiscount + widget.id),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['data'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? discount;
  @override
  void initState() {
    discount = viewOffer();
    print(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Discount".tr),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: discount,
        builder: (_, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Get.to(ProductDetails(
                          id: snapshot.data[index]["id"],
                          token: token,
                        ));
                      },
                      leading: Container(
                        height: 100,
                        width: 100,
                        child: Image.network(
                          snapshot.data[index]["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(snapshot.data[index]["title"].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Old Price:".tr),
                              Text(
                                  snapshot.data[index]["old_price"].toString() +
                                      "kr".tr)
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Discount: ".tr,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data[index]["discount"].toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              Text(" %",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Off price:".tr),
                              Text(
                                  snapshot.data[index]["off_price"].toString() +
                                      "kr".tr),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Text("No productt found");
          }
        },
      ),
    );
  }
}
