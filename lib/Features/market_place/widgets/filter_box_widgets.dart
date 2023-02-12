import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/controller/filtering_controller.dart';
import 'package:sv_craft/app/module/filter/controller/filter_product_con.dart';
import 'package:sv_craft/app/module/filter/view/filter_product.dart';
import 'package:sv_craft/constant/api_link.dart';

class FilterBoxWidget extends StatefulWidget {
  @override
  State<FilterBoxWidget> createState() => _FilterBoxWidgetState();
}

class _FilterBoxWidgetState extends State<FilterBoxWidget> {
  bool _ischecked = false;
  bool _isbuttonactive = false;
  final filterCon = Get.put(FilteringController());

  final filterProductController = Get.put(FilterProductController());

  Future viewO(String categoryName, String SubcategoryName,
      String childCategoryName, String typeOfAds, String advertise) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(
        Uri.parse(Appurl.filteravail +
            categoryName +
            "/" +
            SubcategoryName +
            "/" +
            childCategoryName +
            "/" +
            typeOfAds +
            "/" +
            advertise),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["products"];
      setState(() {
        count = userData1;
      });
      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? view;

  @override
  void initState() {
    view = viewO(cN, sN, chN, tp, ad);

    super.initState();
  }

  var count = "0";
  var cN = "0";
  var sN = "0";
  var chN = "0";
  var tp = "0";
  var ad = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Markets".tr),
          centerTitle: true,
        ),
        body: Obx(() => Padding(
              padding: EdgeInsets.all(2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Location'.tr,
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 97, 97, 97),
                                            fontSize: 17,
                                          ),
                                        ),
                                        // Text(
                                        //   "Uttara",
                                        //   style: TextStyle(
                                        //     color: Colors.black,
                                        //     fontSize: 20,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.black,
                                      size: 25,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(_ischecked
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank),
                              onPressed: () {
                                setState(() {
                                  _ischecked = !_ischecked;
                                  _isbuttonactive = !_isbuttonactive;
                                });
                                print(_ischecked);
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Sold throughout Iraq".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "products category".tr,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 23, 23, 23),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            filterCon.fetchAllCategory();
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              child: filterCon.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: filterCon.categoryList.length,
                                      itemBuilder: (_, index) {
                                        var data =
                                            filterCon.categoryList[index];
                                        return Card(
                                          child: ListTile(
                                            title: Text('${data.category}'),
                                            onTap: () {
                                              filterCon.category.value =
                                                  data.category.toString();

                                              filterCon.selectedCatPosition
                                                  .value = index;
                                              filterCon.fetchSubcategory(index);
                                              cN = data.category.toString();
                                              viewO(cN, sN, chN, tp, ad);
                                              Navigator.of(context).pop();
                                            },
                                            leading: Image.network(
                                              Appurl.baseURL + '${data.icon}',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .1,
                                            ),
                                            trailing: Icon(
                                                Icons.arrow_drop_down_sharp),
                                          ),
                                        );
                                      },
                                    ),
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .070,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "categories".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    // Text(
                                    //   "categories".tr,
                                    //   style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 16,
                                    //   ),
                                    // ),
                                    Text(
                                      '${filterCon.category.value}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              child: filterCon.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          filterCon.subCategoryList.length,
                                      itemBuilder: (_, index) {
                                        var data =
                                            filterCon.subCategoryList[index];
                                        return Card(
                                          child: ListTile(
                                            title: Text('${data.name}'),
                                            onTap: () {
                                              print(data.name);
                                              filterCon.subcategory.value =
                                                  data.name.toString();
                                              filterCon.selectedSubCatPosition
                                                  .value = index;
                                              filterCon.fetchSubcategory(index);
                                              sN = data.name.toString();
                                              viewO(cN, sN, chN, tp, ad);
                                              Navigator.of(context).pop();
                                            },
                                            leading: Icon(Icons.list),
                                            trailing: Icon(
                                                Icons.arrow_drop_down_sharp),
                                          ),
                                        );
                                      },
                                    ),
                            ));
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .077,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "sub category".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    Text(
                                      '${filterCon.subcategory}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: (() {
                            Get.bottomSheet(Container(
                              color: Colors.white,
                              child: filterCon.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          filterCon.subChildCategoryList.length,
                                      itemBuilder: (_, index) {
                                        var data = filterCon
                                            .subChildCategoryList[index];
                                        return Card(
                                          child: ListTile(
                                            title: Text('${data.name}'),
                                            onTap: () {
                                              filterCon.childcategory.value =
                                                  data.name.toString();
                                              // filterCon.selectedSubCatPosition.value = index;
                                              chN = data.name.toString();
                                              viewO(cN, sN, chN, tp, ad);
                                              // filterCon.fetchChildSubcategory(index);
                                              Navigator.of(context).pop();
                                            },
                                            leading: Icon(Icons.list),
                                            trailing: Icon(
                                                Icons.arrow_drop_down_sharp),
                                          ),
                                        );
                                      },
                                    ),
                            ));
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .077,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "child category".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    Text(
                                      '${filterCon.childcategory}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        //TODO: Sortaring
                        InkWell(
                          onTap: (() {
                            Get.bottomSheet(Container(
                                height: 300,
                                padding: EdgeInsets.all(20),
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    child: Text(
                                      "Sorting".tr,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 26),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                        label: Text("Latest"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.sortaring.value = "Latest";
                                          tp = filterCon.sortaring.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text("Oldest"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.sortaring.value = "Oldest";
                                          tp = filterCon.sortaring.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                        label: Text("Cheapest"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.sortaring.value =
                                              "Cheapest";
                                          tp = filterCon.sortaring.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text("Most Expensive"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.sortaring.value =
                                              "Most Expensive";
                                          tp = filterCon.sortaring.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ))));
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .077,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Sorting".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    Text(
                                      '${filterCon.sortaring.value}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        //TODO Type of Ads
                        InkWell(
                          onTap: (() {
                            Get.bottomSheet(Container(
                                height: 300,
                                padding: EdgeInsets.all(20),
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    child: Text(
                                      'Type Of Ads:',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 26),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                        label: Text("Sold"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.typeofads.value = "Sold";
                                          ad = filterCon.typeofads.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text("Exchange"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.typeofads.value =
                                              "Exchange";
                                          ad = filterCon.typeofads.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                        label: Text("For Rent"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.typeofads.value =
                                              "For Rent";
                                          ad = filterCon.typeofads.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text("Want to rent"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.typeofads.value =
                                              "Want to rent";
                                          ad = filterCon.typeofads.value
                                              .toString();
                                          viewO(cN, sN, chN, tp, ad);
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ))));
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .077,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Type of Ads".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    Text(
                                      '${filterCon.typeofads.value}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        //TODO: Advertisements
                        InkWell(
                          onTap: (() {
                            Get.bottomSheet(Container(
                                height: 300,
                                padding: EdgeInsets.all(20),
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    child: Text(
                                      "Advertisement".tr,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FilterChip(
                                        label: Text("Private"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.advertisement.value =
                                              "Private";
                                          Get.back();
                                        },
                                      ),
                                      FilterChip(
                                        label: Text("Undertake"),
                                        selected: false,
                                        onSelected: (bool value) {
                                          filterCon.advertisement.value =
                                              "Undertake";
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ))));
                          }),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .077,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Advertisement".tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                    Text(
                                      '${filterCon.advertisement}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .95,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Visa endast',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * .08,
          width: MediaQuery.of(context).size.width * .9,
          child: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              
              filterProductController.getFilteringData(
                  filterCon.category.value,
                  filterCon.subcategory.value,
                  filterCon.childcategory.value,
                  filterCon.typeofads.value,
                  filterCon.advertisement.value,
                  filterCon.sortaring.value);
              Get.to(() => FilterProducts());
            },
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        count.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "advertisements".tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
