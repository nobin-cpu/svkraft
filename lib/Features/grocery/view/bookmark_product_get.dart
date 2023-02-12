import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmarked_product_get_con.dart';
import 'package:sv_craft/Features/grocery/controllar/delete_bookmark_proudct.dart';
import 'package:sv_craft/Features/grocery/model/bookmarked_product_get.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/constant/api_link.dart';

class BookmarkProductGetScreen extends StatefulWidget {
  const BookmarkProductGetScreen(
      {Key? key, required this.id, required this.name})
      : super(key: key);
  final int id;
  final String name;

  @override
  State<BookmarkProductGetScreen> createState() =>
      _BookmarkProductGetScreenState();
}

class _BookmarkProductGetScreenState extends State<BookmarkProductGetScreen> {
  BookmarkedProductGetController bookmarkedProductGetController =
      Get.put(BookmarkedProductGetController());
  HomeController _homeController = Get.put(HomeController());
  DeleteBookmarkProductController _deleteBookmarkProductController =
      Get.put(DeleteBookmarkProductController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<GetBookmarkProductData>?>(
                future: bookmarkedProductGetController.getBookmarkProduct(
                    _homeController.tokenGlobal, widget.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData && snapshot.data == null) {
                    return Center(
                      child: Center(child: Text("No Product Found".tr)),
                      // Center(
                      //     child: Center(
                      //         child: const SpinKitFadingCircle(
                      //   color: Colors.black,
                      // ))),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      //snapshot.data!.isEmpty
                      return Center(child: Text("No Product Found".tr));
                    } else {
                      final data = snapshot.data;
                      return Container(
                        // height: MediaQuery.of(context).size.height * .9,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 10),
                          itemCount: data!.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: .48,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            //color: Colors.green,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, //color of shadow
                                  spreadRadius: 2, //spread radius
                                  blurRadius: 5, // blur radius
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                )
                              ],
                            ),

                            child: Column(
                              children: [
                                // SizedBox(height: size.height * .01),
                                Row(
                                  children: [
                                    // SizedBox(width: size.width * .01),
                                    IconButton(
                                        onPressed: () async {
                                          var statusCode =
                                              await _deleteBookmarkProductController
                                                  .bookmarkProductDelete(
                                                      _homeController
                                                          .tokenGlobal,
                                                      data[index].bookmarkId);
                                          if (statusCode == 200) {
                                            setState(() {});
                                          } else {
                                            Get.snackbar('Error'.tr,
                                                'Category Not Deleted'.tr);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                    const Spacer(),
                                    Text(
                                      data[index].groceryItem.marketPrice,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(width: size.width * .01),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Image.network(
                                        '${Appurl.baseURL}${data[index].groceryItem.image}',
                                        // AppImage.carouselImages[index],
                                        fit: BoxFit.cover,
                                        width: size.width * .35,
                                        height: size.height * .17,
                                      ),
                                    ),
                                    data[index].groceryItem.offPrice == 0
                                        ? SizedBox()
                                        : Positioned(
                                            top: 20,
                                            right: 0,
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              color: Colors.yellow,
                                              child: Text(
                                                "${data[index].groceryItem.ar_off_price.toString()}% off",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red),
                                              ),
                                            ))
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * .01,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data[index].groceryItem.name,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "${data[index].groceryItem.ar_price} " +
                                              "kr".tr,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: size.width * .4,
                                          child: Text(
                                            data[index].groceryItem.description,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                        // Text(
                                        //   "also the leap into electronic",
                                        //   style: TextStyle(
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Colors.black,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                                data != null
                                    ? GroceryCount(
                                        index: index,
                                        productId: data[index].groceryItem.id,
                                        price: (data[index].groceryItem.price)
                                            .toDouble(),
                                      )
                                    : const Center(
                                        child: Center(
                                            child: SpinKitFadingCircle(
                                        color: Colors.black,
                                      ))),
                              ],
                            ),
                            // height: 147,
                            // width: ,
                          ),
                        ),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    ));
  }
}
