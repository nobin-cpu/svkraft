import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/grocery/model/all_product_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GroceryAllProductController extends GetxController {
  Future<List<GroceryAllProductData>?> getGroceryAllProduct(
      String textToken) async {

    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      const url = Appurl.baseURL + 'api/groceries/all';

      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      print("groceryAllProduct:::::" + response.body);
      if (response.statusCode == 200) {
        final allProduct = groceryAllProductFromJson(response.body);

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
