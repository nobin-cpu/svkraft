import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/history_controller.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../../home/controller/home_controller.dart';
import '../controllar/bookmark_add_product.dart';
import '../controllar/bookmark_category_con.dart';
import '../controllar/category_controller.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final GroceryCategoryController groceryCategoryController =
      Get.put(GroceryCategoryController());
  final BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  final BookmarkProductAddController _bookmarkProductAddController =
      Get.put(BookmarkProductAddController());
  final HomeController _homeController = Get.put(HomeController());

  final TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final HistoryController offferController = HistoryController();
    offferController.getOffersFromInternet();
    return Scaffold(
      appBar: AppBar(
        title: Text("Offers".tr),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: offferController.isLoading.value
                ? ShimmerEffect.listSimmerEffect()
                : ListView.builder(
                    itemCount: offferController.offerModel.value.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var offerProducts =
                          offferController.offerModel.value.data![index];

                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 8,
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      Appurl.baseURL + offerProducts.image,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          offerProducts.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Market price :".tr +
                                              " ${offerProducts.marketPrice}",
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          "Offers".tr +
                                              " : " +
                                              offerProducts.offPrice,
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Offer price : ".tr +
                                            offerProducts.ar_price +
                                            "kr".tr),
                                      ],
                                    )
                                  ],
                                ),
                                offerProducts != null
                                    ? GroceryCount(
                                        index: index,
                                        // userId: userId,
                                        productId: offerProducts.id,
                                        price:
                                            double.parse(offerProducts.price),
                                      )
                                    : const Center(
                                        child: Center(
                                            child: SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )),
    );
  }
}
