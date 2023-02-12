import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';
import 'package:sv_craft/main.dart';

import '../../home/controller/home_controller.dart';

import '../../seller_profile/controller/seller_profile_con.dart';
import '../../seller_profile/controller/show_all_product.dart';
import '../../seller_profile/models/seller_profile_model.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  HomeController homeController = Get.put(HomeController());

  OnlyProfile sellercon =
      Get.put(OnlyProfile ());
   SellerProfile?  sellerProfile;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setTokenToVariable();
  }

  Future<void> setTokenToVariable() async {
    setState(() {
      isLoading = true;
    });

    var profile = await sellercon.getAllProduct(
        homeController.tokenGlobal, mainUserID.toString());
            print("ADsInitial::::::::");
    if (profile != null) {
      setState(() {
        // print("profile $profile");
        // var data  = SellerProfile.fromJson(jsonDecode(profile));
        sellerProfile = profile;
        // print("sellerProfile::::::${sellerProfile.product}:::");
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Ads"),
      ),
      body: isLoading
          ? ShimmerEffect.listSimmerEffect()
          : sellerProfile!.product!.isEmpty
              ? Center(
                  child: Text(
                    "You don't have product.",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : Container(
                  child: ListView.builder(
                      itemCount: sellerProfile!.product!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 1, // blur radius
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                )
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                Appurl.baseURL +
                                                    '${sellerProfile!.product![index].image![0].filePath}',
                                              ))),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text("${sellerProfile!.product?.length}"
                                              ,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                              '${sellerProfile!.product![index].price} Kr',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      }),
                ),
    );
  }
}
