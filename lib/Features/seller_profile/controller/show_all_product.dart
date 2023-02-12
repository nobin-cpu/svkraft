import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/seller_profile/models/show_all_product.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class ShowAllProductController extends GetxController {
  Future<List<ShowAllProductData>?> getAllProduct(
      String textToken, dynamic sellerId) async {
    try {
      var url = Appurl.baseURL + "api/product/all/$sellerId";
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
        final allProduct = showAllProductFromJson(response.body);

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
