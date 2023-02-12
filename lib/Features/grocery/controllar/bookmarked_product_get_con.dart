import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/bookmarked_product_get.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class BookmarkedProductGetController extends GetxController {
  Future<List<GetBookmarkProductData>?> getBookmarkProduct(
      String textToken, int id) async {
    try {
      var url = Appurl.baseURL+'api/grocery/bookmark-item/$id';

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final bookmarkProduct = getBookmarkProductFromJson(response.body);

        // print('proooooooooooooooooooo ${bookmarkProduct.data}');
        // print(marketCategory.data[1].categoryName);s
        return bookmarkProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
