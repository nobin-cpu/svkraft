import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class SpecialAllProductController extends GetxController {
  Future<List<SpecialAllProductData>?> getSpecialAllProduct(
      String textToken, int id) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      print('product id $id');
      var url = Appurl.baseURL+"api/special-day/$id";

      http.Response response = await http.get(Uri.parse(url), headers:headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = specialAllProductFromJson(response.body);

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
