import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/history_controller.dart';
import 'package:sv_craft/Features/grocery/model/history_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  final arabicNumber = ArabicNumbers();
  @override
  Widget build(BuildContext context) {
    final HistoryController historyController = Get.put(HistoryController());
    historyController.getHistoryFromInternet();
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History".tr),
      ),
      body: Obx(() => SizedBox(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: historyController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount:
                        historyController.historyModel.value.data!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var historyProducts =
                          historyController.historyModel.value.data![index];
                      return GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: historyProducts.orderCode));
                          var snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              historyProducts.orderCode.toString() +
                                  "Successfully copied".tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Card(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order id:".tr +
                                                historyProducts.orderCode
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "kr".tr +
                                                " ${historyProducts.price}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(height: 8),
                                          Text("date".tr +
                                              ":  ${historyProducts.createdAt}")
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text(
                                            "Status".tr,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            historyProducts.status.toString(),
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 170,
                                    child: ListView.builder(
                                        itemCount: historyProducts
                                            .orderDetails!.grocery!.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          var groceryItems = historyProducts
                                              .orderDetails!.grocery!;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ordersSubItemsDesign(
                                                groceryItems, index),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ))),
    );
  }

  Card ordersSubItemsDesign(List<Grocery> groceryItems, int index) {
    return Card(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(Appurl.baseURL + groceryItems[index].image.toString(),
                fit: BoxFit.cover),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${groceryItems[index].name}",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "kr".tr + arabicNumber.convert(groceryItems[index].price),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Quantity'.tr +
                        arabicNumber.convert(groceryItems[index].quantity),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
