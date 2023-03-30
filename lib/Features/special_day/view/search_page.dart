import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sv_craft/Features/special_day/controllar/search_con.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';

import '../../../constant/api_link.dart';
import '../../../constant/color.dart';
import '../../home/controller/home_controller.dart';
import 'package:http/http.dart' as http;

import '../../seller_profile/view/conto.dart';

class SpecialSearchPage extends StatefulWidget {
  SpecialSearchPage({
    super.key,
  });

  @override
  State<SpecialSearchPage> createState() => _SpecialSearchPageState();
}

class _SpecialSearchPageState extends State<SpecialSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final SepecialSearchController _specialSearchController =
      Get.put(SepecialSearchController());
  HomeController _homeController = Get.put(HomeController());

  Map<String, dynamic>? searchedData;

  getSpecialSearchProducts(String textToken, name) async {
    var response = await http.get(
        Uri.parse("http://svkraft.shop/api/special-day/search/$name"),
        headers: ServicesClass.headersForAuth);

    searchedData = Map<String, dynamic>.from(jsonDecode(response.body));

    print(' DATA ======================== $searchedData');
  }

  @override
  void initState() {
    print(searchedData);
    // TODO: implement initState
    super.initState();
    getSpecialSearchProducts("token", "name");
  }

  Widget _searchTextField() {
    return TextFormField(
      controller: _searchController,
      onChanged: (_) async {
        final searchProduct = await getSpecialSearchProducts(
            _homeController.tokenGlobal, _searchController.text);

        if (searchProduct != null) {
          setState(() {
            searchedData = searchProduct;
          });
        } else {
          Text("No Data");
        }
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
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

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(SpecialHomeScreen());
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: _searchTextField(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchedData == null
                ? Column(
                    children: [
                      SizedBox(
                        height: _size.height * .4,
                      ),
                      Center(child: Text('Search your product')),
                    ],
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    itemCount: searchedData!["data"].length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: .75,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) => Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38, //color of shadow
                            spreadRadius: 1, //spread radius
                            blurRadius: 1, // blur radius
                            offset: Offset(1, 1), // changes position of shadow
                          )
                        ],
                      ),

                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      id: searchedData!["data"][index]["id"],
                                      token: token,
                                    )),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Image.network(
                                Appurl.baseURL +
                                    '${searchedData!["data"][index]["image"]}',
                                fit: BoxFit.contain,
                                height: 180,
                                width: 170,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${searchedData!["data"][index]["price"].toString()} ' +
                                          "kr".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: _size.width * .2,
                                    child: Text(
                                      '${searchedData!["data"][index]["name"].toString()}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    ));
  }
}
