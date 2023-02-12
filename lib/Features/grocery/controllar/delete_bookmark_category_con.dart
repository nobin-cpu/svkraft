import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class DeleteBookmarkCategoryController extends GetxController {
  bookmarCategoryItemDelete(String textToken, int categoryId) async {
    try {
      var url = Appurl.baseURL+'api/bookmark-list/delete/$categoryId';

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);

      if (response.statusCode == 200) {
        print("Deleted bookmark category");
        return response.statusCode;
      } else {
        print('Error');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
