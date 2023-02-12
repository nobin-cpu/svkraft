import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/api_link.dart';

class BookmarkProductAddController extends GetxController {
  addBookmarkProduct(String textToken, listId, productId) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      print('listId = $listId' + 'productId = $productId');
      http.Response response = await http.post(
          Uri.parse(Appurl.baseURL+'api/grocery/add-to-bookmark'),
          body: {
            'list_id': listId.toString(),
            'product_id': productId.toString(),
          },
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $getTOken',
          });

      if (response.statusCode == 200) {
        print('Bookmark Product Added');
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
