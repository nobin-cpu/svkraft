import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/view/details.dart';

import 'package:sv_craft/Features/seller_profile/controller/seller_profile_con.dart';
import 'package:sv_craft/Features/seller_profile/models/seller_profile_model.dart';
import 'package:sv_craft/Features/seller_profile/controller/show_all_product.dart';
import 'package:sv_craft/constant/color.dart';

import '../../../constant/api_link.dart';

class MyAdds extends StatefulWidget {
  const MyAdds({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAdds> createState() => _MyAddsState();
}

class _MyAddsState extends State<MyAdds> {
  HomeController _homeController = Get.put(HomeController());
  ShowAllProductController _showAllProductController =
      Get.put(ShowAllProductController());

  OnlyProfile _showSellerProfileController = Get.put(OnlyProfile());
  var _selectedIndex = 1;

  SellerProfile? sellerProfile;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 00), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var profile = await _showSellerProfileController.getAllProduct(
        _homeController.tokenGlobal, _homeController.userId.toString());
    if (profile != null) {
      setState(() {
        sellerProfile = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Appcolor.primaryColor,
        elevation: 0,
        title: Text(
          "My Ads".tr,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: sellerProfile != null
          ? SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                // Card(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.black.withOpacity(.8),
                //       borderRadius: BorderRadius.circular(10),
                //       image: DecorationImage(
                //         // colorFilter: ColorFilter.mode(
                //         //     Colors.grey.withOpacity(.8), BlendMode.dstATop),
                //         image: AssetImage('images/sellercover.jpeg'),
                //         fit: BoxFit.cover,
                //         //Add color opacity
                //       ),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 20, vertical: 10),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             width: size.width * .30,
                //             height: size.height * .15,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQo5X1qxa__quYvEMWsc-qDiEB_L9tEdFUlKJicLc&s"),
                //                     fit: BoxFit.cover)),
                //           ),
                //           SizedBox(
                //             width: size.width * .05,
                //           ),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(height: size.height * .02),
                //               Text(
                //                 sellerProfile.user.name,
                //                 style: TextStyle(
                //                     fontSize: 24,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w700),
                //               ),
                //               Text(
                //                 "Phone : " + sellerProfile.user.phone,
                //                 style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.w700),
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: size.height * .05,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Text(
                //     "Products to sell",
                //     style: TextStyle(fontSize: 22),
                //   ),
                // ),
                // SizedBox(
                //   height: size.height * .02,
                // ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 30),
                  itemCount: sellerProfile?.product?.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: .79,
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
                          color: Colors.black12, //color of shadow
                          spreadRadius: 1, //spread radius
                          blurRadius: 1, // blur radius
                          offset: Offset(1, 1), // changes position of shadow
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
                              builder: (context) => Detailss(
                                  Id: "${sellerProfile?.product?[index].id}",
                                  productId:
                                      "${sellerProfile?.product?[index].id}")),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Image.network(
                              Appurl.baseURL +
                                  '${sellerProfile?.product?[index].image?[0].filePath}',
                              fit: BoxFit.cover,
                              height: 180,
                              width: 170,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment
                              //         .spaceBetween,
                              children: [
                                Text(
                                    '${sellerProfile?.product![index].price} ' +
                                      "kr".tr,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 100.0,
                                  child: Text(
                                    sellerProfile!.product![index].productName
                                        .toString(),
                                    softWrap: false,
                                    style: TextStyle(
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
                )
              ],
            ))
          : const Center(child: SpinKitFadingCircle(color: Colors.black)),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Appcolor.primaryColor,
      //   selectedItemColor: Appcolor.iconColor,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: _selectedIndex,
      //   onTap: (int index) {
      //     setState(() {
      //       _selectedIndex = index;
      //       print(_selectedIndex);
      //       if (_selectedIndex == 0) {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => const HomeScreen()),
      //         );
      //       } else if (_selectedIndex == 1) {
      //         print("This is Market place");
      //       } else if (_selectedIndex == 2) {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => ProfileScreen()),
      //         );
      //       }
      //     });
      //   },
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag),
      //       label: 'Market Place',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
