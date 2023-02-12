import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/grocery/model/search_product_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GrocerySearchController extends GetxController {
  Future<List<GrocerySearchedProductData>?> getGrocerySearchProduct(
      String textToken, name) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      var url = Appurl.baseURL + "api/groceries/search/$name";
      // var url = Appurl.baseURL + "api/groceries/search";

      http.Response response = await http.get(Uri.parse(url), headers: headersForAuth);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final marketSearch = grocerySearchedProductFromJson(response.body);

        // print('proooooooooooooooooooo ${marketSearch.data}');
        // print(marketCategory.data[1].categoryName);s
        return marketSearch.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
