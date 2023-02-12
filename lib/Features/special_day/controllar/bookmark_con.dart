import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/special_day/model/get_bookamrk_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class SpBookmarkController extends GetxController {
  addBookmarkProduct(String textToken, productId) async {
    try {
      // print('productId = $productId');
      http.Response response = await http.post(
          Uri.parse(Appurl.baseURL + 'api/special-day/add-to-bookmark'),
          body: {
            'product_id': productId.toString(),
          },
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $textToken',
          });

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GetSpecialBoomarkData>?> getSpecialBookmarkProduct(
      String textToken) async {
    try {
      const url = Appurl.baseURL+"api/special-day/bookmark-item/show";

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);
      print(response.toString());

      if (response.statusCode == 200) {
        final marketBookmark = getSpecialBoomarkFromJson(response.body);
        return marketBookmark.data;
      } else {
        print('Bookmark is Empty');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
