import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/model/all_category_model.dart';
import 'package:sv_craft/app/service/api_service.dart';

class FilteringController extends GetxController{
  var selectedCategory = "Select Category".obs;
  var isLoading = true.obs;
  var categoryList = <Category>[].obs;
  var subCategoryList = <Subcategory>[].obs;
  var subChildCategoryList = <ChildCategory>[].obs;
  final List<String> cStatusList = ['Checkin', 'CheckOut'];
  var category = "".obs;
  var subcategory = "".obs;
  var childcategory = "".obs;
  var sortaring = "".obs;
  var typeofads = "".obs;
  var advertisement = "".obs;
  var selectedCatPosition = 0.obs;
  var selectedSubCatPosition = 0.obs;
  var data ;


  @override
  void onInit() {
    fetchAllCategory();
    super.onInit();
  }

  void fetchAllCategory() async{
    data = await ApiService().getCategory("product/v3/category-all");
    if(data.data!.isNotEmpty)
      {
        isLoading(false);
        categoryList.clear();
        categoryList.addAll(data.data!);
      }
  }
  void fetchSubcategory(int position)async{
    if(data.data!.isNotEmpty)
    {
      isLoading(false);
      subCategoryList.clear();
      subCategoryList.addAll(data.data![position].subcategory!);
    }
  }

  void fetchChildSubcategory(int position)async{
    if(data.data!.isNotEmpty)
    {
      isLoading(false);
      subChildCategoryList.clear();
      subChildCategoryList.addAll(data.data![selectedCatPosition.value].subcategory![position].childCategory!);
    }
  }

}