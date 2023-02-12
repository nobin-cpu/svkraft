import 'package:get/get.dart';
import 'package:sv_craft/app/module/filter/model/filtering_products_model.dart';
import 'package:sv_craft/app/service/api_service.dart';

class FilterProductController extends GetxController {
  var isLoading = false.obs;
  List <RealData> realdata = <RealData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getFilteringData(String category, String subcategory,
      String chldcategory, String type, String ads, String sortering) async {
    isLoading(true);
    var data = await ApiService().getFilteringProducts("product/filter",
        category, subcategory, chldcategory, type, ads, sortering);
    if (data.data!.isNotEmpty) {
      realdata.clear();
      realdata.addAll(data.data!);
      isLoading(false);
    }
    isLoading(false);
  }
}
