import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/cart/model/delete_item.dart';

import '../../../constant/api_link.dart';

class CartItemDeleteController extends GetxController {
  Future<DeleteCartItem?> cartItemDelete(
      String textToken, int userId, int productId, String type) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      var url = Appurl.baseURL+'api/cart/delete/$userId/$productId/$type';

      http.Response response = await http.get(Uri.parse(url), headers:headersForAuth);
      print(response.statusCode);
      
      if (response.statusCode == 200) {
       
        final marketSearch = deleteCartItemFromJson(response.body);

        // print('proooooooooooooooooooo ${marketSearch.data}');
        // print(marketCategory.data[1].categoryName);s
        return marketSearch;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
