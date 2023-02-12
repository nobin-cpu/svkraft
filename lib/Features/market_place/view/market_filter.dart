import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/market_filter_controller.dart';
import 'package:sv_craft/Features/market_place/model/market_filter_model.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class MarketFilter extends StatefulWidget {
  MarketFilter({
    Key? key,
    required this.token,
    required this.cityName,
    required this.selectedCategory,
    required this.priceRange,
  }) : super(key: key);

  String token;
  String cityName;
  String selectedCategory;
  String? priceRange;

  @override
  State<MarketFilter> createState() => _MarketFilterState();
}

class _MarketFilterState extends State<MarketFilter> {
  final MarketFilterController _marketFilterController =
      Get.put(MarketFilterController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market filter page build");
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 143, 211, 231),
      appBar: AppBar(
        title: Text(widget.selectedCategory),
        backgroundColor: Color.fromARGB(255, 234, 236, 244),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(
            //   height: 2,
            // ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 245, 251),
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text('Price : ${widget.priceRange.toString()} ',
                      style: const TextStyle(
                          color: Appcolor.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(Icons.location_on_sharp, color: Appcolor.primaryColor),
                  Text(widget.cityName,
                      style: const TextStyle(
                          color: Appcolor.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),

            //filtered product
            Container(
              height: size.height,
              color: Color.fromARGB(255, 143, 211, 231),
              child: FutureBuilder<List<MarketFilterData>?>(
                  future: _marketFilterController.getFilterProduct(
                      widget.token,
                      widget.selectedCategory,
                      widget.cityName,
                      widget.priceRange),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                          child: Center(
                              child: const SpinKitFadingCircle(
                        color: Colors.black,
                      )));
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Product Found'));
                      } else {
                        var data = snapshot.data;
                        return GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 10),
                          itemCount: data!.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: .79,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            // color: Colors.red,
                            alignment: Alignment.center,
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

                            child: InkWell(
                              onTap: () {
                                Get.to(() => MarketProductDetails(
                                      id: data[index].id,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Image.network(
                                      '${Appurl.baseURL}${data[index].image[0].filePath}',
                                      fit: BoxFit.contain,
                                      height: 200,
                                      width: 180,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${data[index].price} kr',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: 110.0,
                                          child: Text(
                                            '${data[index].productName}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: const TextStyle(
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
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
