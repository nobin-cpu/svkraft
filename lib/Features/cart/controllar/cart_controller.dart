import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/model/show_cart_model.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class CartController extends GetxController {
  var count = 0.obs;
  var singlePrice = 0.obs;
  var subTotal = 0.obs;

  Future<Data?> getCartProduct(String textToken, int userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      var url = Appurl.baseURL + 'api/cart/all/${userId}';

      http.Response response = await http.get(Uri.parse(url), headers:headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = checkoutFromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
