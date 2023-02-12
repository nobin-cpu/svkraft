import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/view/address_page.dart';
import 'package:sv_craft/constant/color.dart';

class MyAddressScreen extends StatefulWidget {
  MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final GetAddressController _getAddressController =
      Get.put(GetAddressController());
  HomeController _homeController = Get.put(HomeController());
  var Address;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 500), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var address =
        await _getAddressController.getAddress(_homeController.tokenGlobal);
    if (address != null) {
      setState(() {
        Address = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("My Address"),
        backgroundColor: Appcolor.primaryColor,
        elevation: 0,
      ),
      body: Address != null
          ? Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${Address.name}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.primaryColor),
                              ),
                              const Spacer(),
                              // TextButton(
                              //     onPressed: () {
                              //       // Navigator.push(
                              //       //     context,
                              //       //     MaterialPageRoute(
                              //       //         builder: (context) => AddressScreen()));
                              //     },
                              //     child: Text(
                              //       'Edit',
                              //       style: TextStyle(
                              //           color: Appcolor.primaryColor,
                              //           fontSize: 16),
                              //     ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.08,
                              ),
                              Container(
                                width: size.width * 0.7,
                                child: Text(
                                  '${Address!.house}, ${Address!.colony}, ${Address!.city}, ${Address!.area}, ${Address!.address}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${Address!.phone}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Appcolor.primaryColor),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.email_outlined,
                          //       color: Colors.blue,
                          //     ),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     const Text(
                          //       'user@gmail.com',
                          //       style: TextStyle(
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.normal,
                          //           color: Appcolor.primaryColor),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddressScreen(
                                                  from: "address",
                                                )));
                                  },
                                  child: Text('Edit Address')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    ));
  }
}
