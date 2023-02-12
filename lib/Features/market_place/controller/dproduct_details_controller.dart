import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/model/product_details.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';

import '../../../constant/api_link.dart';
import '../../../main.dart';
import '../model/market_model.dart';
import 'dart:developer' as dev;

class ProductDetailsController extends GetxController {
  Rx<MarketPlaceModel> marketPlaceModel = MarketPlaceModel().obs;
  RxBool isLoading = false.obs;

  getMarketPlaceModel(String textToken, String id) async {
    isLoading.value = true;
    try {
      var url = Appurl.baseURL + "api/product/v2/find/$id";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final data = MarketPlaceModel.fromJson(jsonDecode(response.body));
        dev.log("marketData$data");
       return data.data;
        isLoading.value = false;
      } else {
        errorSnackBar(
            title: jsonDecode(response.body)['success'],
            message: jsonDecode(response.body)['message']);
        return null;
      }
    } catch (e) {
      print('Try exception ${e.toString()}');
      return null;
    }
  }

  getAllProduct(String token, String id) {}
}
