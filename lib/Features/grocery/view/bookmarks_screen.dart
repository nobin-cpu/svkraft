import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/controllar/category_controller.dart';
import 'package:sv_craft/Features/grocery/controllar/delete_bookmark_category_con.dart';
import 'package:sv_craft/Features/grocery/model/bookmark_category_model.dart';
import 'package:sv_craft/Features/grocery/model/category_model.dart';
import 'package:sv_craft/Features/grocery/view/bookmark_product_get.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';

class GroceryBookmarks extends StatefulWidget {
  GroceryBookmarks({Key? key}) : super(key: key);

  @override
  State<GroceryBookmarks> createState() => _GroceryBookmarksState();
}

class _GroceryBookmarksState extends State<GroceryBookmarks> {
  // final String token;
  BookmarkCategoryController _bookmarkCategoryController =
      Get.put(BookmarkCategoryController());
  HomeController _homeController = Get.put(HomeController());
  DeleteBookmarkCategoryController _deleteBookmarkCategoryController =
      Get.put(DeleteBookmarkCategoryController());

  TextEditingController _categoryController = TextEditingController();

  // Generate a massive list of dummy products
  final myProducts = List<String>.generate(10, (i) => 'Product $i');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GroceryProduct()));
        return Future.value(false);
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('Add Bookmarks Category'.tr),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          hintText: 'Category Name'.tr,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'.tr),
                        ),
                        TextButton(
                          onPressed: () async {
                            var statusCode = await _bookmarkCategoryController
                                .addBookmarkCategory(
                                    _homeController.tokenGlobal,
                                    _categoryController.text);

                            if (statusCode == 200) {
                              _categoryController.clear();
                              Get.back();
                              Get.snackbar('Success'.tr, 'Category Added'.tr);
                            } else {
                              Get.back();
                              Get.snackbar('Error'.tr, 'Category Not Added'.tr);
                            }
                          },
                          child: Text('Add'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            title: Text('Grocery Bookmarks'.tr),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: FutureBuilder<List<BookmarkCategoryData>?>(
              future: _bookmarkCategoryController
                  .getBookmarkCategory(_homeController.tokenGlobal),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No Category Found'.tr));
                  } else {
                    final data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12, //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 0, // blur radius
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                )
                              ],
                            ),
                            width: size.width,
                            height: 60,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookmarkProductGetScreen(
                                              id: data[index].id,
                                              name: data[index].name)),
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.list),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    data[index].name,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        Get.dialog(
                                          AlertDialog(
                                            title: Text(
                                                'Delete Bookmarks Category'.tr),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [],
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Cancel'.tr),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      var statusCode =
                                                          await _deleteBookmarkCategoryController
                                                              .bookmarCategoryItemDelete(
                                                                  _homeController
                                                                      .tokenGlobal,
                                                                  data[index]
                                                                      .id);
                                                      if (statusCode == 200) {
                                                        setState(() {});
                                                        Get.back();

                                                        _bookmarkCategoryController
                                                                .BookmarkCategory
                                                            .clear();

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
                                                    child: Text('Confirm'.tr),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          barrierDismissible: false,
                                        );
                                        // var statusCode =
                                        //     await _deleteBookmarkCategoryController
                                        //         .bookmarCategoryItemDelete(
                                        //             _homeController.tokenGlobal,
                                        //             data[index].id);
                                        // if (statusCode == 200) {
                                        //   setState(() {});
                                        //   Get.snackbar(
                                        //       'Success', 'Category Deleted');
                                        // } else {
                                        //   Get.snackbar(
                                        //       'Error', 'Category Not Deleted');
                                        // }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }
              })),
    );
  }
}
