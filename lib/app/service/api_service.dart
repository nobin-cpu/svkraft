import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/all_category_model.dart';
import 'package:sv_craft/app/constant/api_constant.dart';
import 'package:sv_craft/app/module/filter/model/filtering_products_model.dart';
import 'package:sv_craft/app/module/shops/models/slider_model.dart';
import 'package:sv_craft/services/services.dart';

class ApiService {
  var client = http.Client();

  Future<SliderModel> getSlider(String endpoint, String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    final response = await client.get(
        Uri.parse(ApiConstant.base_url + endpoint),
        headers: headersForAuth);
    if (response.statusCode == 200) {
      return sliderModelFromJson(response.body);
    } else {
      throw Exception("Failed to load Sliders");
    }
  }

  Future<AllCategoryModel> getCategory(String endpoint) async {SharedPreferences prefs = await SharedPreferences.getInstance();
  String? getTOken = prefs.getString('auth-token');
  Map<String, String> headersForAuth = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $getTOken',
  };
    final response = await client.get(
        Uri.parse(ApiConstant.base_url + endpoint),
        headers: headersForAuth);
    if (response.statusCode == 200) {
      return allCategoryModelFromJson(response.body);
    } else {
      throw Exception("Failed to load Sliders");
    }
  }

  Future<FilteringProductsModel> getFilteringProducts(
      String endpoint,
      String category,
      String subcategory,
      String chldcategory,
      String type,
      String ads,
      String sortering) async {
    final body = {
      'category': category,
      'subcategory': subcategory,
      'childcategory': chldcategory,
      'type': type,
      'ads': ads,
      'sortering ': sortering,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    final jsonString = json.encode(body);
    final response = await client.post(
        Uri.parse(ApiConstant.base_url + endpoint),
        headers: headersForAuth,
        body: jsonString);
    if (response.statusCode == 200) {
      return filteringProductsModelFromJson(response.body);
    } else {
      throw Exception("Failed to load Sliders");
    }
  }
}
