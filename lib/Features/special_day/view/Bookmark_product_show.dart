import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/grocery/controllar/delete_bookmark_proudct.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/bookmark_con.dart';
import 'package:sv_craft/Features/market_place/model/get_bookamrk_model.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/controllar/bookmark_con.dart';
import 'package:sv_craft/Features/special_day/model/get_bookamrk_model.dart';
import 'package:sv_craft/Features/special_day/view/product_details.dart';
import 'package:sv_craft/Features/special_day/view/widgets/special_drawer.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

class BookmarkedProductShow extends StatefulWidget {
  BookmarkedProductShow({Key? key}) : super(key: key);

  @override
  State<BookmarkedProductShow> createState() => _BookmarkedProductShowState();
}

class _BookmarkedProductShowState extends State<BookmarkedProductShow> {
  // final BookmarkController _bookmarkController = Get.put(BookmarkController());
  final HomeController _homeController = Get.put(HomeController());
  DeleteBookmarkProductController _deleteBookmarkProductController =
      Get.put(DeleteBookmarkProductController());
  SpBookmarkController _spBookmarkController = Get.put(SpBookmarkController());
  // var Product;

  // @override
  // initState() {
  //   super.initState();
  //   Future.delayed(Duration(microseconds: 10), () async {
  //     setTokenToVariable();
  //   });
  // }

  // Future<void> setTokenToVariable() async {
  //   var product = await _bookmarkController
  //       .getBookmarkProduct(_homeController.tokenGlobal);
  //   if (product != null) {
  //     setState(() {
  //       Product = product;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market filter page build");
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 143, 211, 231),
      appBar: AppBar(
        title: Text("Bookmarked Product".tr),
        backgroundColor: Appcolor.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: const Color.fromARGB(255, 143, 211, 231),
          child: FutureBuilder<List<GetSpecialBoomarkData>?>(
              future: _spBookmarkController
                  .getSpecialBookmarkProduct(_homeController.tokenGlobal),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                      child:
                          Center(child: ShimmerEffect.gridviewShimerLoader()));
                } else {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No Product Found'.tr));
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
                        childAspectRatio: .78,
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
                              offset:
                                  Offset(1, 1), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            )
                          ],
                        ),

                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        id: data[index].id,
                                        token: token,
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Image.network(
                                      '${Appurl.baseURL}${data[index].image}',
                                      fit: BoxFit.cover,
                                      height: size.height * 0.22,
                                      width: size.width * 0.45,
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          color: Colors.white,
                                          child: IconButton(
                                              onPressed: () async {
                                                var statusCode =
                                                    await _deleteBookmarkProductController
                                                        .bookmarkProductDelete(
                                                            _homeController
                                                                .tokenGlobal,
                                                            data[index]
                                                                .bookmarkId);
                                                if (statusCode == 200) {
                                                  setState(() {});
                                                  Get.snackbar(
                                                      'Success'.tr,
                                                      'Delete Bookmarks Category'
                                                          .tr);
                                                } else {
                                                  Get.snackbar(
                                                      'Error'.tr,
                                                      'Category Not Deleted'
                                                          .tr);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 24,
                                              ))))
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 110.0,
                                      child: Text(
                                        '${data[index].name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text('${data[index].price} ' + "kr".tr,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
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
      ),
    ));
  }
}
