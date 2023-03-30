import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/market_search_controller.dart';
import 'package:sv_craft/Features/market_place/view/details.dart';
import 'package:sv_craft/Features/market_place/view/market_place.dart';

import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final MarketSearchController _maeketSearchController =
      Get.put(MarketSearchController());
  HomeController _homeController = Get.put(HomeController());
  final TextEditingController _searchController = TextEditingController();

  var searchedData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchItmes();
  }

  getSearchItmes() async {
    final searchProduct = await _maeketSearchController.getmarketSearchProduct(
        _homeController.tokenGlobal, _searchController.text);

    if (searchProduct != null) {
      setState(() {
        searchedData = searchProduct;
      });
    }
  }

  Widget _searchTextField() {
    return TextFormField(
      controller: _searchController,
      onChanged: (_) async {
        final searchProduct =
            await _maeketSearchController.getmarketSearchProduct(
                _homeController.tokenGlobal, _searchController.text);

        if (searchProduct != null) {
          setState(() {
            searchedData = searchProduct;
          });
        }
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: "search".tr,
        hintStyle: TextStyle(
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print("Search page build");
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(MarketPlace());
            },
            icon: Icon(Icons.arrow_back)),
        title: _searchTextField(),
        // actions: [
        //   CircleAvatar(
        //     radius: 18,
        //     backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.clear,
        //         color: Appcolor.iconColor,
        //         size: 20,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           // Future.delayed(
        //           //     Duration(microseconds: 200), () async {});
        //           //searchedData = null;
        //           // _searchBoolean = false;
        //           //       _isSearched = false;
        //           _searchController.text = "";
        //           // _searchController.clear();
        //         });
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchedData != null
                ? ListView.separated(
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        color: Color.fromARGB(198, 158, 158, 158),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    itemCount: searchedData.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Container(
                      // color: Colors.red,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailss(
                                    Id: searchedData[index].id.toString(),
                                    productId:
                                        searchedData[index].id.toString())),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .14,
                                    child: ClipRRect(
                                        child: Image.network(
                                          '${Appurl.baseURL}${searchedData[index].image[0].filePath}',
                                          fit: BoxFit.cover,
                                          height: 110,
                                          width: 130,
                                        ),
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 6),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            child: Text(
                                              searchedData[index].productName,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Row(
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                  "Fortag",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              color: Color.fromARGB(
                                                  255, 101, 101, 101),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Id:${searchedData[index].id}",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Text(
                                          "2022 . Automat .",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 6),
                                        child: Text(
                                            '${searchedData[index].price} ' +
                                                "kr".tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: _size.height * .4,
                      ),
                      Center(child: Text('Search your product'.tr)),
                    ],
                  )
          ],
        ),
      ),
    ));
  }
}
