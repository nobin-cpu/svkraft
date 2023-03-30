
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/view/fillter_produtc.dart';


import '../../market_add_products/view/components/categoris_items_components.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class FilterBoxScreen extends StatefulWidget {
  const FilterBoxScreen({Key? key}) : super(key: key);

  @override
  State<FilterBoxScreen> createState() => _FilterBoxScreenState();
}

class _FilterBoxScreenState extends State<FilterBoxScreen> {
  final MarketCategoryController marketCategoryController =
      Get.put(MarketCategoryController());
  final CategorisItemsComponetns categorisItemsComponetns =
      CategorisItemsComponetns();

  @override
  void initState() {
    super.initState();
    marketCategoryController.getSubCategoris();
  }

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market'),
      ),
      // body:

      //  Container(
      //   child: Obx(() => marketCategoryController.isLoading == true
      //       ? const Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : Obx(() => Container(
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 10, vertical: 10),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Text(
      //                     "Categoris and Types",
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w700, fontSize: 18),
      //                   ),
      //                   const SizedBox(height: 10),
      //                   Card(
      //                     child: SizedBox(
      //                       width: double.infinity,
      //                       child: Align(
      //                         alignment: Alignment.topLeft,
      //                         child: TextButton.icon(
      //                           icon: const Icon(Icons.category_outlined),
      //                           label: Padding(
      //                             padding: const EdgeInsets.only(left: 10),
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 const Text(
      //                                   "Categori",
      //                                   style: TextStyle(
      //                                       fontWeight: FontWeight.w600),
      //                                 ),
      //                                 const SizedBox(height: 6),
      //                                 Text(
      //                                   marketCategoryController
      //                                       .selectedSubCategoris.value,
      //                                   style: const TextStyle(
      //                                       fontWeight: FontWeight.w600,
      //                                       color: Colors.black),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           onPressed: () {
      //                             // Get.defaultDialog(
      //                             //   radius: 2,
      //                             //   title: "Categoris",
      //                             //   contentPadding: const EdgeInsets.all(2),
      //                             //   content: SizedBox(
      //                             //     height:
      //                             //         MediaQuery.of(context).size.height *
      //                             //             0.7,
      //                             //     width:
      //                             //         MediaQuery.of(context).size.width *
      //                             //             0.9,
      //                             //     child: SingleChildScrollView(
      //                             //       child: categorisItemsComponetns
      //                             //           .subCategorisMethod(),
      //                             //     ),
      //                             //   ),
      //                             // );
      //                           },
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(height: 12),
      // Card(
      //     child: SizedBox(
      //         width: double.infinity,
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: TextButton.icon(
      //             icon: const Icon(Icons.merge_type),
      //             label: Column(
      //               crossAxisAlignment:
      //                   CrossAxisAlignment.start,
      //               children: [
      //                 const Text(
      //                   "Type of Ads",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600),
      //                 ),
      //                 const SizedBox(height: 6),
      //                 DropdownButton<String>(
      //                   value: marketCategoryController
      //                       .selectedTypeOfAds.value,
      //                   style: const TextStyle(
      //                       fontWeight: FontWeight.w600,
      //                       color: Colors.black),
      //                   onChanged: (String? value) {
      //                     marketCategoryController
      //                         .typeofAdsValue(value);
      //                   },
      //                   items: marketCategoryController
      //                       .typeofAds
      //                       .map<DropdownMenuItem<String>>(
      //                           (String value) {
      //                     return DropdownMenuItem<String>(
      //                       value: value,
      //                       child: Text(value),
      //                     );
      //                   }).toList(),
      //                 ),
      //               ],
      //             ),
      //             onPressed: () {},
      //           ),
      //         ))),
      // const SizedBox(height: 10),
      // Card(
      //   child: SizedBox(
      //       width: double.infinity,
      //       child: Align(
      //           alignment: Alignment.topLeft,
      //           child: TextButton.icon(
      //             icon: const Icon(Icons.ads_click_sharp),
      //             label: Padding(
      //               padding:
      //                   const EdgeInsets.only(left: 10),
      //               // child: Column(
      //               //   crossAxisAlignment:
      //               //       CrossAxisAlignment.start,
      //               //   children: [
      //               //     const Text(
      //               //       "Advertisement",
      //               //       style: TextStyle(
      //               //           fontWeight: FontWeight.w600),
      //               //     ),
      //               //     const SizedBox(height: 6),
      //               //     DropdownButton<String>(
      //               //       value: marketCategoryController
      //               //           .selectedadvertisement.value,
      //               //       style: const TextStyle(
      //               //           fontWeight: FontWeight.w600,
      //               //           color: Colors.black),
      //               //       onChanged: (String? value) {
      //               //         marketCategoryController
      //               //             .selectedadvertisementValue(
      //               //                 value);
      //               //       },
      //               //       items: marketCategoryController
      //               //           .advertisement
      //               //           .map<
      //               //                   DropdownMenuItem<
      //               //                       String>>(
      //               //               (String value) {
      //               //         return DropdownMenuItem<String>(
      //               //           value: value,
      //               //           child: Text(value),
      //               //         );
      //               //       }).toList(),
      //               //     ),
      //               //   ],
      //               // ),
      //             ),
      //             onPressed: () {},
      //           ))),
      // ),
      // const SizedBox(height: 10),
      // // Card(
      // //     child: SizedBox(
      // //         width: double.infinity,
      // //         child: Align(
      // //           alignment: Alignment.topLeft,
      // //           child: TextButton.icon(
      // //             icon: const Icon(Icons.ads_click_sharp),
      // //             label: Padding(
      // //               padding:
      // //                   const EdgeInsets.only(left: 10),
      // //               child: Column(
      // //                 crossAxisAlignment:
      // //                     CrossAxisAlignment.start,
      // //                 children: [
      // //                   const Text(
      // //                     "Sortering",
      // //                     style: TextStyle(
      // //                         fontWeight: FontWeight.w600),
      // //                   ),
      // //                   const SizedBox(height: 6),
      // //                   DropdownButton<String>(
      // //                     value: marketCategoryController
      // //                         .selectedsortering.value,
      // //                     style: const TextStyle(
      // //                         fontWeight: FontWeight.w600,
      // //                         color: Colors.black),
      // //                     onChanged: (String? value) {
      // //                       marketCategoryController
      // //                           .selectedsorteringValue(
      // //                               value);
      // //                     },
      // //                     items: marketCategoryController
      // //                         .sortering
      // //                         .map<
      // //                                 DropdownMenuItem<
      // //                                     String>>(
      // //                             (String value) {
      // //                       return DropdownMenuItem<String>(
      // //                         value: value,
      // //                         child: Text(value),
      // //                       );
      // //                     }).toList(),
      //                   //                   ),
      //                   //                 ],
      //                   //               ),
      //                   //             ),
      //                   //             onPressed: () {},
      //                   //           ),
      //                   //         ))),
      //                 ],
      //               ),
      //             ),
      //           ))),
      // ),
      // bottomNavigationBar: Container(
      //     height: 80, color: Colors.white, child: Text("data")
      // Obx(
      //   () => Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Container(
      //               child: ElevatedButton.icon(
      //                   style: ButtonStyle(
      //                       backgroundColor:
      //                           MaterialStateProperty.all(Colors.red)),
      //                   onPressed: () {
      //                     marketCategoryController.resetCategoris();
      //                   },
      //                   icon: const Icon(
      //                       Icons.settings_backup_restore_outlined),
      //                   label: const Text("Reset")),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Container(
      //               child: ElevatedButton.icon(
      //                   style: ButtonStyle(
      //                       backgroundColor:
      //                           MaterialStateProperty.all(Colors.green)),
      //                   onPressed: () {
      //                     marketCategoryController.categorisResponseModel
      //                                 .value.message ==
      //                             null
      //                         ? errorSnackBar(
      //                             title: "Faild",
      //                             message: "No record found")
      //                         : Get.to(CategoriFoundScreen());
      //                   },
      //                   icon: const Icon(Icons.screen_search_desktop_sharp),
      //                   label: Text(
      //                     marketCategoryController.categorisResponseModel
      //                                 .value.message ==
      //                             null
      //                         ? "No records found"
      //                         : marketCategoryController
      //                             .categorisResponseModel.value.message
      //                             .toString(),
      //                     style: const TextStyle(color: Colors.white),
      //                   )),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),),

      body: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * .070,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 36, 26, 89)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saljes i hela Sverige',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                        size: 25,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 8,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .080,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Saljes i hela Sverige',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.info_outline,
                              color: Colors.black,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_box_outline_blank_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Saljes i hela Sverige',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .070,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 36, 26, 89)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Saljes i hela Sverige',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        setState(() {
                          Get.to(() => DropDownDemoItem());
                        });
                      }),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'KATEGORI',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Alla',
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
                    InkWell(
                      onTap: (() {}),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TYP AV ANNONOS',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Saljes',
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
                    InkWell(
                      onTap: (() {}),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ANNONSOR',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Alla',
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
                    InkWell(
                      onTap: (() {}),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .060,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SORTARING',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Senaste',
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
                    Container(
                      height: MediaQuery.of(context).size.height * .070,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 36, 26, 89)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Visa endast',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_box_outline_blank_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Saljes i hela Sverige',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.to(FillterProdutcShow());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .085,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 36, 26, 89)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Visa 30 annonser',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .010,
            )
          ],
        ),
      ),
    );
  }
}

//=========================DropDown Page================//

class DropDownDemoItem extends StatefulWidget {
  const DropDownDemoItem({super.key});

  @override
  State<DropDownDemoItem> createState() => _DropDownDemoItemState();
}

class _DropDownDemoItemState extends State<DropDownDemoItem> {
  final List<String> items = [
    'Business transfers',
    'Equipment & machinery',
    'Premises & properties',
    'Services',
  ];
  int selectIndex = 0;
  String? selectedValue;

  int selectIndex2 = 0;
  String? selectedValue2;
  final List<String> items2 = [
    'Computers & Video Game',
    'Phones & accessories',
    'Sound & image',
  ];
  int selectIndex3 = 0;
  String? selectedValue3;
  final List<String> items3 = [
    '	Tool',
    'Housewares & white goods',
    'Housewares & white goods',
    'Construction & garden',
  ];
  int selectIndex4 = 0;
  String? selectedValue4;
  final List<String> items4 = [
    'Private Services',
    '	Minisrty Job',
  ];
  int selectIndex5 = 0;
  String? selectedValue5;
  final List<String> items5 = [
    '	Miscellaneous',
    '	Requests',
  ];
  int selectIndex6 = 0;
  String? selectedValue6;
  final List<String> items6 = [
    "Children's articles & toys",
    "Children's clothes & shoes",
    '	Accessories & watches',
    '	Clothes shoes',
  ];
  int selectIndex7 = 0;
  String? selectedValue7;
  final List<String> items7 = [
    'Clothes shoes',
    'Leisure accommodation',
    'Farms',
    'Plots',
    'Terraced house',
    'Villas',
    'Apartments',
  ];
  int selectIndex8 = 0;
  String? selectedValue8;
  final List<String> items8 = [
    'Sports & leisure equipment',
    '	Music equipment',
    '	Hunting & fishing',
    '	Horses & equestrian sports',
    '	Hobbies & collectibles',
    '	Animal',
    'Bicycles',
    '	Books & student literature',
    'Experiences & fun',
  ];
  int selectIndex9 = 0;
  String? selectedValue9;
  final List<String> items9 = [
    'Sports & leisure equipment',
    'Phones & accessories',
    'Sound & image',
  ];

  // List productsItems = [];
  // bool itmesLoading = false;

  // void getDataFromProductID() async {
  //   setState(() {
  //     itmesLoading = true;
  //   });
  //   try {
  //     var url = Appurl.baseURL + "/api/product/v3/category-all";

  //     http.Response response = await http.get(Uri.parse(url), headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     });

  //     devlog.log("esponse.body${response.body}");
  //     if (response.statusCode == 200) {
  //       // final allProduct = allProductFromJson(response.body);
  //       var pro = jsonDecode(response.body);

  //       List product = pro['data'];
  //       productsItems = product;
  //       print("product:::::$product");
  //     } else {
  //       print('================Product not found');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  //   setState(() {
  //     itmesLoading = false;
  //   });

  // }
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Katagoris'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/1.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Business Operations',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                                child: Image(
                              image: AssetImage('images/2.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Electronics',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items2
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                                child: Image(
                              image: AssetImage('images/3.png'),
                              fit: BoxFit.cover,
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'For The Home',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items3
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/4.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Job',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items4
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/5.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Miscellaneous',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items5
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/6.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Personally',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items6
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/7.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Residence',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items7
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/8.png'),
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Sparetime Hobby',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items8
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Row(
                          children: [
                            Container(
                                child: Image(
                              image: AssetImage('images/9.png'),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )),
                            Text(
                              'Vehicle',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                        items: items9
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
