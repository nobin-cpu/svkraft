import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/model/sub_item_model.dart';

import '../../Features/bookmarks/controller/add_to_bookmarks_con.dart';
import '../../Features/grocery/controllar/all_product_controller.dart';
import '../../Features/grocery/controllar/bookmark_category_con.dart';
import '../../Features/grocery/controllar/searched_product_con.dart';
import '../../Features/grocery/controllar/sub_category_controller.dart';
import '../../Features/market_place/controller/all_product_controller.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductController>(() => AllProductController());
    Get.lazyPut<GroceryAllProductController>(
        () => GroceryAllProductController());
    Get.lazyPut<GrocerySearchController>(() => GrocerySearchController());
    Get.lazyPut<AddtoBookmarksController>(() => AddtoBookmarksController());
    Get.lazyPut<BookmarkCategoryController>(() => BookmarkCategoryController());
    Get.lazyPut<GrocerySubCategoryController>(
        () => GrocerySubCategoryController());
    Get.lazyPut<SubItemModel>(() => SubItemModel(
        data: subItemModel.data, message: 'Succsess', success: true));
  }

  late SubItemModel subItemModel;
}
