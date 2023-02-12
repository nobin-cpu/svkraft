import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/model/sub_categoris_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import '../../../services/services.dart';
import 'dart:developer' as developer;

import '../../market_add_products/models/citys_model.dart';
import '../model/categoris_response_model.dart';

errorSnackBar({required String title, required String message}) {
  Get.snackbar(
      backgroundColor: Colors.red, colorText: Colors.white, title, message);
}

successSnackBar({required String title, required String message}) {
  Get.snackbar(
      backgroundColor: Colors.green, colorText: Colors.white, title, message);
}

class MarketCategoryController extends GetxController {
  Rx<CategorisResponseModel> categorisResponseModel =
      CategorisResponseModel().obs;
  Rx<SubCategorisModel> subCategorisItems = SubCategorisModel().obs;
  Rx<CitysModel> cityModels = CitysModel().obs;
  RxBool isLoading = false.obs;
  RxString selectedCategoris = "Select".obs;
  RxString selectedCategoriID = "".obs;
  RxString selectedSubCategoris = "".obs;
  RxString selectedChildCategori = "".obs;
  RxString selectedTypeOfAds = "".obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedModelDate = "".obs;
  RxString selectedMilage = "".obs;
  RxString selectedGearBox = "".obs;
  RxString selectedFuel = "".obs;
  RxString selectedCarType = "".obs;
  RxString selectedBikeType = "".obs;
  RxString selectedCity = ''.obs;
  RxString speedList = ''.obs;

  List<String> typeofAds = [
    "Sold",
    "Exchange",
    "For Rent",
    "Want to Rent",
    "Copes",
  ];
  List<String> listOfGearBox = [
    "Auto",
    "Menual",
  ];
  List<String> listOfFuel = [
    "Bensin",
    "Diesel",
    "Hybrid",
    "El",
  ];
  List<String> listOfBikes = [
    "Standard",
    "Cruiser",
    "Touring",
    "Sports",
    "Off-road",
    "Dual-purpose",
  ];
  List<String> listOfCarTypes = [
    "Smabil",
    "Sedan",
    "Halvkombi",
    "Kombi",
    "Coupe",
    "Cab",
    "SUV",
    "Faniljebuss",
    "Yrkesfordon",
  ];
  List<String> milageList = [
    "0-500",
    "501-1000",
    "1001-1500",
    "1501-2000",
    "2001-2500",
    "2501-3000",
    "3001-3500",
    "3501-4000",
    "4001-4500",
    "4501-5000",
    "5001-5500",
    "5501-6000",
    "6001-6500",
    "6501-7000",
    "7001-7500",
    "7501-8000",
    "8001-8500",
    "8501-9000",
    "9001-9500",
    "10000"
  ];
  List<String> speed = [
    "0-50",
    "50-100",
    "100-150",
    "150-200",
  ];

  Future<List<mCategory>?> getmarketCategoryProduct(String textToken) async {
    try {
      const url = Appurl.baseURL + "api/product/category";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);
      if (response.statusCode == 200) {
        final marketCategory = marketCategoryFromJson(response.body);
        return marketCategory.data;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void getSubCategoris() async {
    isLoading.value = true;
    const url = Appurl.baseURL + "api/product/v3/category-all";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    http.Response response =
        await http.get(Uri.parse(url), headers: headersForAuth);
    // developer.log(response.body);
    if (response.statusCode == 200) {
      var data = SubCategorisModel.fromJson(jsonDecode(response.body));

      subCategorisItems.value = data;
      isLoading.value = false;
    } else {
      errorSnackBar(title: "response faild", message: response.body.toString());
    }
  }

  void typeofAdsValue(value) {
    selectedTypeOfAds.value = value;
  }

  void selectedCategorisValue(value) {
    selectedCategoris.value = value;
  }

  void selectedSubcategorisValue(value) {
    selectedSubCategoris.value = value;
  }

  void selectedChildCategorisValue(value) {
    selectedChildCategori.value = value;
  }

  void selectedCategoriIdValue(value) {
    selectedCategoriID.value = value;
  }

  void getModelDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030));

    developer.log(pickedDate!.year.toString());
    selectedModelDate.value = pickedDate.year.toString();
  }

  void milageValue(value) {
    selectedMilage.value = value;
  }

  void gearBoxValue(value) {
    selectedGearBox.value = value;
  }

  void fuelValue(value) {
    selectedFuel.value = value;
  }

  void speedValue(value) {
    speedList.value = value;
  }

  void carTypeValue(value) {
    selectedCarType.value = value;
  }

  void bikeTyepvlaue(value) {
    selectedBikeType.value = value;
  }

  void getcitys() async {
    try {
      const url = Appurl.baseURL + "api/get-cities";

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);
      print("responseOFCityrs:::::========:${response.body}");

      if (response.statusCode == 200) {
        var data = CitysModel.fromJson(jsonDecode(response.body));
        cityModels.value = data;
      } else {
        print('City not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void selectedCitryValue(value) {
    selectedCity.value = value;
  }
}
