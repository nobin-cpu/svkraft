import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sv_craft/Features/chat/view/recent_chats.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:get/get.dart';
import '../../../constant/color.dart';

class FillterProdutcShow extends StatefulWidget {
  FillterProdutcShow({super.key});

  @override
  State<FillterProdutcShow> createState() => _FillterProdutcShowState();
}

class _FillterProdutcShowState extends State<FillterProdutcShow> {
  // var _selectedIndex = 2;
  // PageController? _pageController;

//=========== This Foe List View, it's Delete Wohen APIs Call ==============//
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N'
  ];

//============ This Foe Page View, it's Delete Wohen APIs Call ==========//
  PageController controller = PageController();

  var list = ["Home", "Services", "Work", "About"];

  var images = [
    'https://www.chevrolet.com/content/dam/chevrolet/na/us/english/portable-nav/small-vehicle-jellies/2022-corvette-3lt-gkz-colorizer.jpg?imwidth=960'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.search_outlined),
          title: Text("filter product".tr),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.filter_alt),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .098,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saljes i hela Sverige',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .005),
                            Text(
                              'Saljes i hela Sverige',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.list,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .020),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Saljes i hela Sverige hdish jandhsdb',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .020),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 36, 26, 89)),
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        pageSnapping: false,
                        controller: controller,
                        children: List.generate(list.length, (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 41, 13, 133),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    height: double.maxFinite,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(images[0]),
                                            fit: BoxFit.fill)),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: double.maxFinite,
                                    child: Column(
                                      children: [
                                        Text(
                                          list[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          list[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          list[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .020),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .2,
                          color: Color.fromARGB(255, 14, 12, 117),
                          child: ListTile(
                            leading: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(images[0]),
                                      fit: BoxFit.cover)),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Entry ${entries[index]}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Entry ${entries[index]}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Entry ${entries[index]}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Entry ${entries[index]}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // child: Container(
                        //   width: double.infinity,
                        //   height: MediaQuery.of(context).size.height * .2,
                        //   color: Color.fromARGB(255, 14, 12, 117),
                        //   child: ListTile(
                        //     leading: Container(
                        //       width: MediaQuery.of(context).size.width * .3,
                        //       height: double.maxFinite,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12),
                        //           image: DecorationImage(
                        //               image: NetworkImage(images[0]),
                        //               fit: BoxFit.fill)),
                        //     ),
                        //     title: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'Entry ${entries[index]}',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //         Text(
                        //           'Entry ${entries[index]}',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //         Text(
                        //           'Entry ${entries[index]}',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //         Text(
                        //           'Entry ${entries[index]}',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,
                        //               fontWeight: FontWeight.w500),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
