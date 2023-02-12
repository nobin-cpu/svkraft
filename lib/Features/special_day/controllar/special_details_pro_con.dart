import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/special_day/model/special_pro_detals_m.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class SpecialDetailsProductController extends GetxController {
  Future<SpecialProductDetailsData?> getSpecialProductDetails(
      String textToken, int id) async {
    try {
      // print('tokennnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn $id   $textToken');
      const url = Appurl.baseURL+"api/special-day/find/";

      http.Response response = await http.get(Uri.parse('$url$id'), headers:ServicesClass.headersForAuth);
      // print(response.body);
      // print(response.statusCode);

      if (response.statusCode == 200) {
        // print("object");
        final productDetails = specialProductDetailsFromJson(response.body);
        // print("******");
        // print(productDetails.data);
        return productDetails.data;
      } else {
        print('Product Not Found');
        return null;
      }
    } catch (e) {
      print('Try exception ${e.toString()}');
      return null;
    }
  }
}
