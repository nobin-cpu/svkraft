import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GroceryFilterPage extends StatelessWidget {
  GroceryFilterPage({super.key});

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text("data"),
                    // Text("${groceryAllProduct[2]["data"]["name"]}"),
                  ),
                )),
            Expanded(flex: 9, child: Container()),
          ],
        ),
      ),
    );
  }

  late Map<String, dynamic> groceryAllProduct;
  getGroceryProducts() async {
    isLoading = true;

    var url = Appurl.baseURL + "api/groceries/category/all";

    http.Response response =
        await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);
    // print("Response:::::::${response.statusCode}");
    if (response.statusCode == 200) {
      var data = Map<String, dynamic>.from(jsonDecode(response.body));
      groceryAllProduct = data;
      print(groceryAllProduct);
    } else {}

    isLoading = false;
  }

  @override
  void initState() {
    initState();
    getGroceryProducts();
  }
}
