import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/constant/api_link.dart';
import '../../../market_place/controller/category_controller.dart';
import '../../../market_place/model/sub_categoris_model.dart';
import '../../controller/add_product_con.dart';
import 'dart:developer' as developer;

import '../categoris_import_screen.dart';

class CategorisItemsComponents extends StatelessWidget {
  const CategorisItemsComponents({super.key});

  @override
  Widget build(BuildContext context) {
    final MarketCategoryController marketCategoryController =
        Get.put(MarketCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Categoris".tr),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: marketCategoryController
                    .subCategorisItems.value.data!.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var categoris = marketCategoryController
                      .subCategorisItems.value.data![index];
                  return Material(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (categoris.subcategory!.isEmpty) {
                                  Get.back();
                                  marketCategoryController
                                      .selectedCategorisValue(
                                          categoris.category!);

                                  marketCategoryController
                                      .selectedSubCategoris.value = "";
                                  marketCategoryController
                                      .selectedChildCategori.value = "";
                                } else {
                                  Get.off(
                                      SubCategorisScreen(
                                        subcategory: categoris.subcategory!,
                                        title: categoris.category.toString(),
                                      ),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                }
                                marketCategoryController
                                    .selectedCategoriIdValue(
                                        categoris.id.toString());
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            Appurl.baseURL +
                                                categoris.icon.toString(),
                                            height: 20,
                                            width: 20,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            categoris.category.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      categoris.subcategory!.isEmpty
                                          ? Container()
                                          : const Icon(
                                              Icons.arrow_right,
                                              color: Colors.black,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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

class SubCategorisScreen extends StatefulWidget {
  final List<Subcategory> subcategory;
  final String title;

  const SubCategorisScreen(
      {super.key, required this.subcategory, required this.title});

  @override
  State<SubCategorisScreen> createState() => _SubCategorisScreenState();
}

class _SubCategorisScreenState extends State<SubCategorisScreen> {
  final MarketCategoryController marketCategoryController =
      Get.put(MarketCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title.toString())),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.subcategory.length,
                itemBuilder: (context, index) {
                  var subCategoris = widget.subcategory[index];
                  return Material(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (subCategoris.childCategory!.isEmpty) {
                                  Get.back();

                                  marketCategoryController
                                      .selectedCategorisValue(widget.title);
                                  marketCategoryController
                                      .selectedSubcategorisValue(
                                          subCategoris.name!);
                                  marketCategoryController
                                      .selectedChildCategori.value = "";
                                } else {
                                  Get.off(
                                      ChildCategorisScreen(
                                        childCategory:
                                            subCategoris.childCategory!,
                                        title: subCategoris.name.toString(),
                                        categorisName: widget.title,
                                      ),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                          subCategoris.name.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      subCategoris.childCategory!.isEmpty
                                          ? Container()
                                          : const Icon(
                                              Icons.arrow_right,
                                              color: Colors.black,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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

class ChildCategorisScreen extends StatefulWidget {
  final List<ChildCategory> childCategory;
  final String title;
  final String categorisName;

  const ChildCategorisScreen(
      {super.key,
      required this.childCategory,
      required this.title,
      required this.categorisName});

  @override
  State<ChildCategorisScreen> createState() => _ChildCategorisScreenState();
}

class _ChildCategorisScreenState extends State<ChildCategorisScreen> {
  final MarketCategoryController marketCategoryController =
      Get.put(MarketCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.childCategory.length,
                itemBuilder: (context, index) {
                  var childCategoris = widget.childCategory[index];
                  return Material(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.off(const AddMarketProductScreen(),
                                    transition: Transition.leftToRightWithFade);
                                marketCategoryController.selectedCategorisValue(
                                    widget.categorisName);
                                marketCategoryController
                                    .selectedSubcategorisValue(widget.title);
                                marketCategoryController
                                    .selectedChildCategorisValue(
                                        childCategoris.name);
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      childCategoris.name.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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

class CategorisItemsComponetns {
  final MarketCategoryController marketCategoryController =
      Get.put(MarketCategoryController());
  List images = [];

// this is nested dropdown list for select Categoris items

  categorisImagesUpload(context) {
    AddProductController addProductController = Get.put(AddProductController());
    Size size = MediaQuery.of(context).size;
    return Obx(() => SizedBox(
          height: 220,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery1();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: addProductController.imagesFiles1.value == ""
                                ? SizedBox(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(addProductController
                                        .imagesFiles1.value),
                                    fit: BoxFit.cover,
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery2();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: addProductController.imagesFiles2.value == ""
                                ? SizedBox(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(addProductController
                                        .imagesFiles2.value),
                                    fit: BoxFit.cover,
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery3();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: addProductController.imagesFiles3.value == ""
                                ? SizedBox(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(addProductController
                                        .imagesFiles3.value),
                                    fit: BoxFit.cover,
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              //next////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery4();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: Center(
                                child:
                                    addProductController.imagesFiles4.value ==
                                            ""
                                        ? SizedBox(
                                            height: size.height * 0.1,
                                            width: size.width * 0.2,
                                            child: const Center(
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            File(addProductController
                                                .imagesFiles4.value),
                                            fit: BoxFit.cover,
                                            height: size.height * 0.1,
                                            width: size.width * 0.2,
                                          )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery5();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: Center(
                                child:
                                    addProductController.imagesFiles5.value ==
                                            ""
                                        ? SizedBox(
                                            height: size.height * 0.1,
                                            width: size.width * 0.2,
                                            child: const Center(
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            File(addProductController
                                                .imagesFiles5.value),
                                            fit: BoxFit.cover,
                                            height: size.height * 0.1,
                                            width: size.width * 0.2,
                                          )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addProductController.getImageFromMGallery6();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            color: Colors.black,
                            child: addProductController.imagesFiles6.value == ""
                                ? SizedBox(
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(addProductController
                                        .imagesFiles6.value),
                                    fit: BoxFit.cover,
                                    height: size.height * 0.1,
                                    width: size.width * 0.2,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  adsOfTypeUI(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.typeofAds.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var typeofAds = marketCategoryController.typeofAds[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.typeofAdsValue(typeofAds);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(typeofAds),
                ),
              ),
            );
          }),
    );
  }

  citrySelectUi(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.cityModels.value.data!.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var citys = marketCategoryController.cityModels.value.data![index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.selectedCitryValue(citys.name);
                print(marketCategoryController.selectedCity.value);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(citys.name.toString()),
                ),
              ),
            );
          }),
    );
  }

  milageUI(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.milageList.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var milageList = marketCategoryController.milageList[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.milageValue(milageList);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(milageList),
                ),
              ),
            );
          }),
    );
  }

  gearBoxUI(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.listOfGearBox.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var listOfGearBox = marketCategoryController.listOfGearBox[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.gearBoxValue(listOfGearBox);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(listOfGearBox),
                ),
              ),
            );
          }),
    );
  }

  fuelUI(context) {
    return Container(
      child: ListView.builder(
          itemCount: marketCategoryController.listOfFuel.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var listOfFuel = marketCategoryController.listOfFuel[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.fuelValue(listOfFuel);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(listOfFuel),
                ),
              ),
            );
          }),
    );
  }

  carTypeUi(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.listOfCarTypes.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var listOfCarTypes = marketCategoryController.listOfCarTypes[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.carTypeValue(listOfCarTypes);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(listOfCarTypes),
                ),
              ),
            );
          }),
    );
  }

  bikeTypesUi(context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: marketCategoryController.listOfBikes.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var listOfBikes = marketCategoryController.listOfBikes[index];
            return GestureDetector(
              onTap: () {
                marketCategoryController.bikeTyepvlaue(listOfBikes);
                Get.back();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(listOfBikes),
                ),
              ),
            );
          }),
    );
  }
}
