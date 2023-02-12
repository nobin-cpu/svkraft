import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/category_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';

import '../model/see_all_model.dart';

class GroceryCategoryController extends GetxController {
  final Rx<SellAllModel> sellAllModel = SellAllModel().obs;
  final RxBool isLoading = false.obs;
  Future<List<GroceryCategoryData>?> getGroceryCategory(
      String textToken) async {
    try {
      const url = Appurl.baseURL + "api/groceries/category/all";

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);
      if (response.statusCode == 200) {
        final marketCategory = groceryCategoryFromJson(response.body);
        print('groceryCategory: ${marketCategory.data}');
        return marketCategory.data;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void getSeeAllProducts(String id) async {
    isLoading.value = true;
    var url = Appurl.baseURL + "api/groceries/bysubcategory/$id";
    try {
      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);
      if (response.statusCode == 200) {
        var data = SellAllModel.fromJson(jsonDecode(response.body));
        sellAllModel.value = data;
        print("SellallModel::::$sellAllModel");
        isLoading.value = false;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
