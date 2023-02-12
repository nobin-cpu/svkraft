import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/grocery/controllar/searched_product_con.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/grocery/view/see_all_products.dart';
import 'package:sv_craft/Features/grocery/view/widgets/grocery_count.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class GrocerySearchPage extends StatefulWidget {
  const GrocerySearchPage({super.key});

  @override
  State<GrocerySearchPage> createState() => _GrocerySearchPageState();
}

class _GrocerySearchPageState extends State<GrocerySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final GrocerySearchController _grocerySearchController =
      Get.put(GrocerySearchController());
  HomeController _homeController = Get.put(HomeController());

  var searchedData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchItmes();
  }

  getSearchItmes() async {
    final searchProduct =
        await _grocerySearchController.getGrocerySearchProduct(
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
            await _grocerySearchController.getGrocerySearchProduct(
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
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search'.tr,
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
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 135, 235, 157),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.off(GroceryProduct());
                },
                icon: Icon(Icons.arrow_back_ios)),
            title: _searchTextField(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                searchedData != null
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 10),
                        itemCount: searchedData.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: .79,
                          mainAxisSpacing: 40,
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
                                color: Colors.black38, //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 1, // blur radius
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              )
                            ],
                          ),

                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => SeeAllProductsScreen(
                              //                           title: productItem.title,
                              //                           id: productItem.id
                              //                               .toString(),
                              //   )),
                              // );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Image.network(
                                    '${Appurl.baseURL}${searchedData[index].image}',
                                    fit: BoxFit.contain,
                                    height: MediaQuery.of(context).size.height *
                                        .14,
                                    width: 170,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .06),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${searchedData[index].ar_pricee} ' +
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
                                          searchedData[index].name,
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
                                GroceryCount(
                                  index: 0,
                                  price: 100,
                                  productId: 0,
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
                          Center(child: Text('Search your product')),
                        ],
                      )
              ],
            ),
          ),
        ));
  }
}
