import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/get_bookamrk_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class BookmarkController extends GetxController {
  addBookmarkProduct(String textToken, productId) async {
    try {
      print('productId = $productId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response = await http.post(
          Uri.parse(Appurl.baseURL+'api/marketplace/add-to-bookmark'),
          body: {
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
removeBookmarkProduct(String textToken, productId) async {
    try {
      print('productId = $productId');SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response = await http.get(
          Uri.parse(Appurl.baseURL+'api/marketplace/bookmark-item/delete/$productId'),
         
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $getTOken',
          });

      if (response.statusCode == 200) {
        print('Bookmark Product removed');
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<GetMarketBoomarkData>?> getBookmarkProduct(
      String textToken) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      const url = Appurl.baseURL+'api/marketplace/bookmark-item/show';

      http.Response response = await http.get(Uri.parse(url), headers:headersForAuth);

      if (response.statusCode == 200) {
        final marketBookmark = getMarketBoomarkFromJson(response.body);
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
