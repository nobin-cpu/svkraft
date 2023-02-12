import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/special_day/model/category_1.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';
import '../model/categoris_model.dart';

class SpecialCategoryController extends GetxController {
  var specialCategorisByIdModel = CategorisByIdModel().obs;
  RxBool isLoading = false.obs;
  Future<List<SpecialCategory1Datum>?> getCategory1Product(
      String textToken) async {
    try {SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
      var url = Appurl.baseURL + "api/special-day/category/all";

      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);
      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = specialCategory1FromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void getSpecialCategorisById(String id) async {
    isLoading.value = true;
    var url = Appurl.baseURL + "api/special-day/$id";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    http.Response response =
        await http.get(Uri.parse(url), headers: headersForAuth);

    // print(response.body);
    if (response.statusCode == 200) {
      var data = CategorisByIdModel.fromJson(jsonDecode(response.body));
      specialCategorisByIdModel.value = data;
      isLoading.value = false;
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error",
          response.body.toString());
    }
  }
}
