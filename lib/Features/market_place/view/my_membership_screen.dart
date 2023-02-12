import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/membership_controller.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

import '../../market_add_products/view/categoris_import_screen.dart';
import '../../profile/controller/get_profile_con.dart';
import '../model/subscription_model.dart';

class MySubscriptionScreen extends StatefulWidget {
  const MySubscriptionScreen({super.key});

  @override
  State<MySubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  final MemberShipController membershipController =
      Get.put(MemberShipController());

  @override
  void initState() {
    membershipController.getSubscriptionsModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetProfileController getProfileController =
        Get.put(GetProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription".tr),
      ),
      body: SizedBox(
        child: Obx(() =>
            // ignore: unrelated_type_equality_checks
            membershipController.isLoading == true
                ? ShimmerEffect.listSimmerEffect()
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          " ${membershipController.subscriptionModel.postLimit}  " +
                              "post left".tr,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "home-packages".tr,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: membershipController
                                .subscriptionModel.data.length,
                            itemBuilder: (context, index) {
                              var subscription = membershipController
                                  .subscriptionModel.data[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    PackageComponents(
                                      packageName: subscription.name,
                                      price: "${subscription.postNumber} " +
                                          "Post".tr,
                                      totalPurchased:
                                          "${subscription.price}  " + "kr".tr,
                                      onPress: () {
                                        getProfileController.userProfileModel
                                            .value.data!.postLimit = 20;
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              "Successfully Purchased".tr +
                                                  '${subscription.name}!'),
                                        );

                                        var snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              "Successfully Purchased".tr +
                                                  ' ${subscription.name}!'),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  )),
      ),
    );
  }
}

class PackageComponents extends StatelessWidget {
  final String price;
  final String totalPurchased;
  final String packageName;
  final VoidCallback onPress;

  const PackageComponents(
      {super.key,
      required this.price,
      required this.onPress,
      required this.totalPurchased,
      required this.packageName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Appcolor.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    packageName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            price,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            totalPurchased,
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: onPress,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 26),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Purchase".tr,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
