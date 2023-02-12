import 'dart:convert';

import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/model/offer_model.dart';

import '../model/history_model.dart';

import 'package:http/http.dart' as http;
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';

class HistoryController extends GetxController {
  var historyModel = HistoryModel().obs;
  var offerModel = OfferModel().obs;
  var isLoading = false.obs;
  void getHistoryFromInternet() async {
    isLoading.value = true;
    try {
      var url = Appurl.baseURL + "api/order/history";

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        var data = HistoryModel.fromJson(jsonDecode(response.body));
        historyModel.value = data;
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    isLoading.value = false;
    update();
  }

  void getOffersFromInternet() async {
    isLoading.value = true;
    try {
      var url = Appurl.baseURL + "api/groceries/off-price";

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      if (response.statusCode == 200) {
        var data = OfferModel.fromJson(jsonDecode(response.body));
        offerModel.value = data;
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    isLoading.value = false;
    update();
  }
}
