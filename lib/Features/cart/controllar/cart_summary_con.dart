import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/cart/model/cart_summary.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GetCartSummaryController extends GetxController {
  Future<CartSummaryData?> getCartSummary(String textToken) async {
    try {
      print('Tokennnnnnnnnnnn $textToken');
      var url = Appurl.baseURL + 'api/cart/summary';

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = getCartSummaryFromJson(response.body);
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
