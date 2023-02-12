import 'dart:convert';

import 'package:get/get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/app/constant/api_constant.dart';
import 'package:sv_craft/app/module/shops/models/slider_model.dart';
import 'package:sv_craft/app/network/network_calling.dart';
import 'package:sv_craft/app/service/api_service.dart';

class SliderController extends GetxController {
  var isLoading = false.obs;
  var items = <Datum>[].obs;
  var token = "".obs;
  final homeCon = Get.put(HomeController());

  @override
  void onInit() {
    setToken();
    getAllSlider();
    super.onInit();
  }

// TODO: Fetching all slider from our backend
  getAllSlider() async {
    isLoading(true);
    //TODO: TOKEN WILL BE UPDATED SOON
    var data = await ApiService().getSlider("sliders", token.value);
    print(token.value);
    if (data.data!.length > 0) {
      isLoading(false);
      items.clear();
      items.addAll(data.data!);
    }
  }

  void setToken() async {
    token.value = await homeCon.getToken();
    update();
  }
}
