import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/constant/api_link.dart';

import '../../../main.dart';

class CategoriFoundScreen extends StatelessWidget {
  const CategoriFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketCategoryController marketCategoryController =
        Get.put(MarketCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categori found"),
      ),
      body: Container(
        child: marketCategoryController
                .categorisResponseModel.value.data!.isEmpty
            ? Center(
                child: Text(
                "Not records found",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ))
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: marketCategoryController
                    .categorisResponseModel.value.data!.length,
                itemBuilder: (context, index) {
                  var categorisFound = marketCategoryController
                      .categorisResponseModel.value.data![index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(MarketProductDetails(
                        id: categorisFound.productId!,
                      ));
                    },
                    child: Card(
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            Image.network(
                              Appurl.baseURL + categorisFound.image.toString(),
                              height: 80,
                              width: 130,
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(right: 13.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categorisFound.productName.toString(),
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF212121),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Price : " + "${categorisFound.price} kr",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF212121),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
