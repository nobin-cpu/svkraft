import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/sub_category_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class GrocerySubCategoryController extends GetxController {
  Future<List<GrocerySubCategoryData>?> getGrocerySubCategory(
      String textToken, int id) async {
    try {
      print("token: $textToken, id: $id");
      var url = Appurl.baseURL+"api/groceries/subcategory/$id";

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);
      if (response.statusCode == 200) {
        final marketCategory = grocerySubCategoryFromJson(response.body);
        print('grocerySubCategory: ${marketCategory.data[0].name}');
        return marketCategory.data;
      } else {
        print('Sub-Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
