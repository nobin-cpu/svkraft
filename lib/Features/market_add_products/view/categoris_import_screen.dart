import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_add_products/controller/add_product_con.dart';
import 'package:sv_craft/Features/market_add_products/view/components/categoris_items_components.dart';
import 'package:sv_craft/Features/market_add_products/view/success.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMarketProductScreen extends StatefulWidget {
  const AddMarketProductScreen({Key? key}) : super(key: key);

  @override
  State<AddMarketProductScreen> createState() => _AddMarketProductScreenState();
}

class _AddMarketProductScreenState extends State<AddMarketProductScreen> {
  bool? usersread = false;
  final _formKey = GlobalKey<FormState>();

  final MarketCategoryController marketCategoryController =
      Get.put(MarketCategoryController());
  final CategorisItemsComponetns categorisItemsComponetns =
      CategorisItemsComponetns();
  final TextEditingController headingController = TextEditingController();
  final TextEditingController speedcontoller = TextEditingController();
  final TextEditingController awardController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController registarationController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  @override
  void initState() {
    super.initState();
    marketCategoryController.getSubCategoris();
    marketCategoryController.getcitys();
  }

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Category city page build");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Product'.tr),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///
                        ///
                        ///There is First Image and requerd items selection
                        ///
                        ///

                        categorisItemsComponetns.categorisImagesUpload(context),
                        const SizedBox(height: 20),
                        Text(
                          "Categoris".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            Get.to(CategorisItemsComponents(),
                                transition: Transition.leftToRightWithFade);
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black38),
                                borderRadius: BorderRadius.circular(6)),
                            child: Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${marketCategoryController.selectedCategoris.value} > "),
                                      Text(
                                          "${marketCategoryController.selectedSubCategoris.value} > "),
                                      Text(
                                          "${marketCategoryController.selectedChildCategori.value}"),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Ad Type".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: Obx(() => TextFormField(
                                showCursor: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text(marketCategoryController
                                        .selectedTypeOfAds.value
                                        .toString()),
                                    hintText: marketCategoryController
                                        .selectedTypeOfAds.value
                                        .toString(),
                                    hintStyle: TextStyle(color: Colors.black)),
                                onTap: () {
                                  Get.defaultDialog(
                                    radius: 2,
                                    title: "Ad Type".tr,
                                    contentPadding: const EdgeInsets.all(2),
                                    content: SizedBox(
                                        height: size.height * 0.3,
                                        width: size.width * 0.9,
                                        child: SingleChildScrollView(
                                            child: categorisItemsComponetns
                                                .adsOfTypeUI(context))),
                                  );
                                },
                              )),
                        ),
                        Text(
                          "price".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: awardController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("price".tr),
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Heading".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text'.tr;
                              }
                              return null;
                            },
                            controller: headingController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Heading".tr),
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Text".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text'.tr;
                              }
                              return null;
                            },
                            controller: textController,
                            maxLines: 2,
                            maxLength: 60,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Text".tr),
                                hintStyle: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Obx(() => marketCategoryController
                                        .selectedTypeOfAds.value ==
                                    "Sold".tr ||
                                marketCategoryController
                                        .selectedTypeOfAds.value ==
                                    "For Rent"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "price".tr,
                                  //   style:
                                  //       TextStyle(fontWeight: FontWeight.w600),
                                  // ),
                                  // const SizedBox(height: 8),
                                  // SizedBox(
                                  //   height: 45,
                                  //   child: TextFormField(
                                  //     controller: awardController,
                                  //     keyboardType: TextInputType.number,
                                  //     decoration: InputDecoration(
                                  //         border: OutlineInputBorder(),
                                  //         label: Text("price".tr),
                                  //         hintStyle:
                                  //             TextStyle(color: Colors.black)),
                                  //   ),
                                  // ),
                                ],
                              )
                            : Container()),
                        const SizedBox(height: 20),
                        //
                        //
                        // if have car selected for this items will be show in the UI ,
                        //
                        //
                        Obx(() => marketCategoryController
                                    .selectedCategoris.value ==
                                "Vehicle"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Zip Code".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        controller: zipCodeController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Zip Code".tr),
                                            hintStyle:
                                                TextStyle(color: Colors.black)),
                                      )),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Reg No".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                      height: 45,
                                      child: TextFormField(
                                        controller: registarationController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Reg No".tr),
                                            hintStyle:
                                                TextStyle(color: Colors.black)),
                                      )),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Place".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: Obx(() => TextFormField(
                                          showCursor: false,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              label: Text(
                                                  marketCategoryController
                                                      .selectedCity.value
                                                      .toString()),
                                              hintText: marketCategoryController
                                                  .selectedCity.value
                                                  .toString(),
                                              hintStyle: const TextStyle(
                                                  color: Colors.black)),
                                          onTap: () {
                                            Get.defaultDialog(
                                              radius: 2,
                                              title: "Place".tr,
                                              contentPadding:
                                                  const EdgeInsets.all(2),
                                              content: SizedBox(
                                                  height: size.height * 0.3,
                                                  width: size.width * 0.9,
                                                  child: SingleChildScrollView(
                                                      child:
                                                          categorisItemsComponetns
                                                              .citrySelectUi(
                                                                  context))),
                                            );
                                          },
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Model".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: Obx(() => TextFormField(
                                          showCursor: false,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelStyle: const TextStyle(
                                                  color: Colors.black),
                                              label: Text(
                                                  marketCategoryController
                                                      .selectedModelDate.value
                                                      .toString()),
                                              hintText: marketCategoryController
                                                  .selectedModelDate.value
                                                  .toString(),
                                              hintStyle: const TextStyle(
                                                  color: Colors.black)),
                                          onTap: () {
                                            marketCategoryController
                                                .getModelDate(context);
                                          },
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Milage".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: Obx(() => TextFormField(
                                          showCursor: false,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              label: Text(
                                                  marketCategoryController
                                                      .selectedMilage.value
                                                      .toString()),
                                              hintText: marketCategoryController
                                                  .selectedMilage.value
                                                  .toString(),
                                              hintStyle: TextStyle(
                                                  color: Colors.black)),
                                          onTap: () {
                                            Get.defaultDialog(
                                              radius: 2,
                                              title: "Milage".tr,
                                              contentPadding:
                                                  const EdgeInsets.all(2),
                                              content: SizedBox(
                                                  height: size.height * 0.3,
                                                  width: size.width * 0.9,
                                                  child: SingleChildScrollView(
                                                      child:
                                                          categorisItemsComponetns
                                                              .milageUI(
                                                                  context))),
                                            );
                                          },
                                        )),
                                  ),
                                  Text(
                                    "Speed".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: speedcontoller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          label: Text("Speed".tr),
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Obx(() => marketCategoryController
                                                  .selectedCategoris.value ==
                                              "Vehicle" &&
                                          marketCategoryController
                                                  .selectedSubCategoris.value ==
                                              "Motorcycle"
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "GearBox".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                                height: 45,
                                                child: TextFormField(
                                                  showCursor: false,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelStyle: TextStyle(
                                                          color: Colors.black),
                                                      label: Text(
                                                          marketCategoryController
                                                              .selectedGearBox
                                                              .value
                                                              .toString()),
                                                      hintText:
                                                          marketCategoryController
                                                              .selectedGearBox
                                                              .value
                                                              .toString(),
                                                      hintStyle: TextStyle(
                                                          color: Colors.black)),
                                                  onTap: () {
                                                    Get.defaultDialog(
                                                      radius: 2,
                                                      title: "GearBox".tr,
                                                      contentPadding:
                                                          EdgeInsets.all(2),
                                                      content: SizedBox(
                                                          height:
                                                              size.height * 0.3,
                                                          width:
                                                              size.width * 0.9,
                                                          child: SingleChildScrollView(
                                                              child: categorisItemsComponetns
                                                                  .gearBoxUI(
                                                                      context))),
                                                    );
                                                  },
                                                )),
                                          ],
                                        )),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Fuel type".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: Obx(() => TextFormField(
                                          showCursor: false,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              labelStyle: const TextStyle(
                                                  color: Colors.black),
                                              label: Text(
                                                  marketCategoryController
                                                      .selectedFuel.value
                                                      .toString()),
                                              hintText: marketCategoryController
                                                  .selectedFuel.value
                                                  .toString(),
                                              hintStyle: const TextStyle(
                                                  color: Colors.black)),
                                          onTap: () {
                                            Get.defaultDialog(
                                              radius: 2,
                                              title: "Fuel type".tr,
                                              contentPadding: EdgeInsets.all(2),
                                              content: SizedBox(
                                                  height: size.height * 0.3,
                                                  width: size.width * 0.9,
                                                  child: SingleChildScrollView(
                                                      child:
                                                          categorisItemsComponetns
                                                              .fuelUI(
                                                                  context))),
                                            );
                                          },
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Brand".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: brandController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          label: Text("Brand".tr),
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "C.C".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: ccController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          label: Text("C.C".tr),
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Color".tr,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: colorController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          label: Text("Color".tr),
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Obx(
                                    () => marketCategoryController
                                                    .selectedCategoris.value ==
                                                "Vehicle" &&
                                            marketCategoryController
                                                    .selectedSubCategoris
                                                    .value ==
                                                "Motorcycles"
                                        ? Container()
                                        : SizedBox(
                                            height: 85,
                                            width: double.infinity,
                                            child: Obx(() => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Car Type".tr,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    TextFormField(
                                                      showCursor: false,
                                                      readOnly: true,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelStyle: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          label: Text(
                                                              marketCategoryController
                                                                  .selectedCarType
                                                                  .value
                                                                  .toString()),
                                                          hintText:
                                                              marketCategoryController
                                                                  .selectedCarType
                                                                  .value
                                                                  .toString(),
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                          radius: 2,
                                                          title: "Car Type".tr,
                                                          contentPadding:
                                                              EdgeInsets.all(2),
                                                          content: SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.3,
                                                              width:
                                                                  size.width *
                                                                      0.9,
                                                              child: SingleChildScrollView(
                                                                  child: categorisItemsComponetns
                                                                      .carTypeUi(
                                                                          context))),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ))),
                                  ),
                                  marketCategoryController
                                                  .selectedCategoris.value ==
                                              "Vehicle" &&
                                          marketCategoryController
                                                  .selectedSubCategoris.value ==
                                              "Motorcycles"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Bike Type".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              height: 45,
                                              width: double.infinity,
                                              child: Obx(() => TextFormField(
                                                    showCursor: false,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        label: Text(
                                                            marketCategoryController
                                                                .selectedBikeType
                                                                .value
                                                                .toString()),
                                                        hintText:
                                                            marketCategoryController
                                                                .selectedBikeType
                                                                .value
                                                                .toString(),
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    onTap: () {
                                                      Get.defaultDialog(
                                                        radius: 2,
                                                        title: "Bike Type".tr,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        content: SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.3,
                                                            width: size.width *
                                                                0.9,
                                                            child: SingleChildScrollView(
                                                                child: categorisItemsComponetns
                                                                    .bikeTypesUi(
                                                                        context))),
                                                      );
                                                    },
                                                  )),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  const SizedBox(height: 60),
                                ],
                              )
                            : Container()),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: usersread,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            usersread = value;
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "By creating account, you are agree to our".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                          ),
                          InkWell(
                            child: Text("Term and Conditions".tr),
                            onTap: () async {
                              final Uri webURl =
                                  Uri.parse(Appurl.baseURL + "terms");

                              if (!await launchUrl(webURl)) {
                                throw 'Could not launch $webURl';
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: loader == false
              ? ElevatedButton(
                  child: Text("Post".tr),
                  onPressed: () {
                    setState(() {
                      loader = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      uploadMarketCategoris();
                    } else {
                      errorSnackBar(
                        title: "Text field error".tr,
                        message: 'enter your valid form'.tr,
                      );
                    }
                  },
                )
              : SpinKitPouringHourGlass(
                  color: Color.fromARGB(255, 121, 170, 255)),
        ),
      ),
    );
  }

  void uploadMarketCategoris() async {
    AddProductController addProductController = Get.put(AddProductController());

    var headers = ServicesClass.headersForAuth;
    var request = http.MultipartRequest(
        'POST', Uri.parse(Appurl.baseURL + 'api/product/create'));

    if (marketCategoryController.selectedCategoris == "Vehicle" &&
        marketCategoryController.selectedSubCategoris != "Motorcycles") {
      request.fields.addAll({
        'category_id':
            marketCategoryController.selectedCategoriID.value.toString(),
        'category_name': marketCategoryController.selectedCategoris.value,
        'subCatagory_name': marketCategoryController.selectedSubCategoris.value,
        'childCatagory_name':
            marketCategoryController.selectedChildCategori.value,
        'product_name': headingController.text,
        'description': textController.text,
        'price': awardController.text,
        'adsType': marketCategoryController.selectedTypeOfAds.value,
        "gearbox": marketCategoryController.selectedGearBox.value,
        "model": marketCategoryController.selectedModelDate.value,
        "milage": marketCategoryController.selectedMilage.value,
        "cartType": marketCategoryController.selectedCarType.value,
        "fuel": marketCategoryController.selectedFuel.value,
        'location': marketCategoryController.selectedCity.value,
        'brand': brandController.text,
        'speeds': speedcontoller.text,
        'c.c': ccController.text,
        'color': colorController.text,
        'car_type': marketCategoryController.selectedCarType.value
      });
    } else if (marketCategoryController.selectedCategoris == "Vehicle" &&
        marketCategoryController.selectedSubCategoris == "Motorcycles") {
      request.fields.addAll({
        'category_id':
            marketCategoryController.selectedCategoriID.value.toString(),
        'category_name': marketCategoryController.selectedCategoris.value,
        'subCatagory_name': marketCategoryController.selectedSubCategoris.value,
        'childCatagory_name':
            marketCategoryController.selectedChildCategori.value,
        'product_name': headingController.text,
        'description': textController.text,
        'price': awardController.text,
        "bikeType": marketCategoryController.selectedBikeType.value,
        'adsType': marketCategoryController.selectedTypeOfAds.value,
        "gearbox": marketCategoryController.selectedGearBox.value,
        "model": marketCategoryController.selectedModelDate.value,
        "milage": marketCategoryController.selectedMilage.value,
        "fuel": marketCategoryController.selectedFuel.value,
        'location': marketCategoryController.selectedCity.value,
        'speeds': speedcontoller.text,
        'c.c': ccController.text,
        'color': colorController.text,
        'car_type': marketCategoryController.selectedCarType.value
      });
    } else {
      request.fields.addAll({
        'category_id':
            marketCategoryController.selectedCategoriID.value.toString(),
        'category_name': marketCategoryController.selectedCategoris.value,
        'product_name': headingController.text,
        'description': textController.text,
        'price': awardController.text,
        'subCatagory_name': marketCategoryController.selectedSubCategoris.value,
        'childCatagory_name':
            marketCategoryController.selectedChildCategori.value,
        'speeds': speedcontoller.text,
        'c.c': ccController.text,
        'color': colorController.text,
        'car_type': marketCategoryController.selectedCarType.value
      });
    }

    developer.log(addProductController.images.length.toString());

    //////send images
    ///
    for (int i = 0; i < addProductController.images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'image[]', addProductController.images[i]));
    }

    //

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);

    developer.log("Response :::: " + res.body);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      // successSnackBar(
      //     title: "Success".tr, message: "Post added successfully".tr);

      addProductController.imagesFiles1.value = '';
      addProductController.imagesFiles2.value = '';
      addProductController.imagesFiles3.value = '';
      addProductController.imagesFiles4.value = '';
      addProductController.imagesFiles5.value = '';
      addProductController.imagesFiles6.value = '';
      addProductController.images.clear();

      _popupDialog(context);
    } else {
      var data = jsonDecode(res.body);
      _popup(context);
      // errorSnackBar(
      //     title: "Status : ${data['success']}", message: data['message']);
    }
  }
}

void _popupDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff004d95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Success",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .02),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => HomeScreen());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.height * .06,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Color(0xff004d95),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      });
}

void _popup(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xff004d95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sorry you dont have post limit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * .02),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: MediaQuery.of(context).size.height * .06,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Color(0xff004d95),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      });
}
