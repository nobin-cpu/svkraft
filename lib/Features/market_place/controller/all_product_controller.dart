import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class AllProductController extends GetxController {
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    print(token);
    return token;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user-id');
    return userId;
  }

  String? tokenGlobal;

  Future<List<Datum>?> getCategoryProduct(String textToken, int id) async {
    try {
      var url = Appurl.baseURL + 'api/product/$id';
      print(url);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = allProductFromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
