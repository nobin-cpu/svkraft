import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/bookmark_con.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';

import '../../../constant/api_link.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);
  final int categoryId;
  final String categoryName;

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final HomeController _homeController = Get.put(HomeController());
  final BookmarkController _bookmarkController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryName),
              centerTitle: true,
            ),
            body: FutureBuilder<List<Datum>?>(
                future: _allProductController.getCategoryProduct(
                    _homeController.tokenGlobal, widget.categoryId),
                builder: (context, snapshot) {
                  // print(
                  //     'matchCategory ${snapshot.data![0].category.categoryName}');

                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Container(),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Product Found'));
                    } else {
                      final data = snapshot.data;

                      return Column(
                        children: [
                          // Container(
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 10),
                          //     child: Row(
                          //       children: [
                          //         Text(widget.categoryName,
                          //             style: const TextStyle(
                          //                 color: Colors.black,
                          //                 fontSize: 22,
                          //                 fontWeight: FontWeight.normal)),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 30),
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
                                  )
                                ],
                              ),

                              child: InkWell(
                                onTap: () {
                                  print("${data[index].id}");
                                  Get.to(() => MarketProductDetails(
                                        id: data[index].id,
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Image.network(
                                            data[index].image![0].filePath !=
                                                    null
                                                ? Appurl.baseURL +
                                                    '${data[index].image![0].filePath}'
                                                : "",
                                            fit: BoxFit.cover,
                                            height: 180,
                                            width: 170,
                                          ),
                                        ),
                                        Positioned(
                                            top: 5,
                                            left: 0,
                                            child: Container(
                                                height: 30,
                                                width: 30,
                                                color: Colors.white,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      var status =
                                                          await _bookmarkController
                                                              .addBookmarkProduct(
                                                                  _homeController
                                                                      .tokenGlobal,
                                                                  data[index]
                                                                      .id);

                                                      if (status == 200) {
                                                        Get.snackbar('Success',
                                                            'Product Added To Bookmark');
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      FontAwesome.bookmark,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ))))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Row(
                                        children: [
                                          Text('${data[index].price} Kr',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: size.width * .2,
                                            child: Text(
                                              data[index]
                                                  .productName
                                                  .toString(),
                                              softWrap: false,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16.0),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                })));
  }
}
