import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/profile/models/get_address_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GetAddressController extends GetxController {
  Future<Address?> getAddress(String textToken) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      print('product id $textToken');
      var url = Appurl.baseURL + 'api/shipping-address/get';

      http.Response response = await http.get(Uri.parse(url), headers:headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = getAddressFromJson(response.body);
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
