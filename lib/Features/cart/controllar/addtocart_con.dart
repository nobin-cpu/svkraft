import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/api_link.dart';

class AddtocartController extends GetxController {
  addTocart(int userId, int productId, String type, int quantity, int price,
      String textToken) async {SharedPreferences prefs = await SharedPreferences.getInstance();
  String? getTOken = prefs.getString('auth-token');
  Map<String, String> headersForAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $getTOken',
  };
    try {
      http.Response response =
          await http.post(Uri.parse(Appurl.baseURL+'api/cart/add'), body: {
        'user_id': userId.toString(),
        'product_id': productId.toString(),
        'type': type.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return data['message'];
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
