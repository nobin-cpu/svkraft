import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/bookmark_category_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class BookmarkCategoryController extends GetxController {
  var BookmarkCategory;
  //Get category list
  Future<List<BookmarkCategoryData>?> getBookmarkCategory(
      String textToken) async {
    try {
      const url = Appurl.baseURL+'api/bookmark-item';

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);

      final bookmarkCategory = bookmarkCategoryFromJson(response.body);
      return bookmarkCategory.data;

      // if (response.statusCode == 200) {
      //   final bookmarkCategory = bookmarkCategoryFromJson(response.body);
      //   print('Bookmark Category: ${bookmarkCategory.data}');
      //   return bookmarkCategory.data;
      // } else {
      //   print('Category not found');
      // }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Post category

  addBookmarkCategory(String textToken, name) async {
    try {
      http.Response response = await http
          .post(Uri.parse(Appurl.baseURL+'api/bookmark-item'), body: {
        'name': name,
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        print('Bookmark Category Added');
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
