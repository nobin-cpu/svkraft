import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

class PaymentHistoryPage extends StatelessWidget {
  PaymentHistoryPage({super.key});

  List paymentList = [
    {
      "name": "Phone Payment",
      "date": "10 Oct 4:25pm",
      "icon": Icon(
        Icons.phone_android,
        size: 35,
        color: Colors.white,
      ),
      "payment": "70000 kr",
    },
    {
      "name": "Card Payment",
      "date": "15 Sep 1:25pm",
      "icon": Icon(Icons.card_giftcard_outlined, size: 35, color: Colors.white),
      "payment": "13000 kr",
    },
    {
      "name": "Saving Accaount",
      "date": "30 Oct 6:25am",
      "icon": Icon(Icons.wallet_outlined, size: 35, color: Colors.white),
      "payment": "1000000 kr",
    },
    {
      "name": "Trancfer Card Payment",
      "date": "20 Nov 8:35pm",
      "icon": Icon(Icons.card_membership, size: 35, color: Colors.white),
      "payment": "5000 kr",
    },
    {
      "name": "Saving Accaount",
      "date": "18 Aug 12:07am",
      "icon": Icon(Icons.wallet, size: 35, color: Colors.white),
      "payment": "200 kr",
    },
    {
      "name": "Phone Payment",
      "date": "3 Jul 9:55pm",
      "icon": Icon(Icons.phone_android, size: 35, color: Colors.white),
      "payment": "1000 kr",
    },
    {
      "name": "Trancfer Car Payment",
      "date": "10 Oct 10:15pm",
      "icon": Icon(Icons.card_giftcard, size: 35, color: Colors.white),
      "payment": "800 kr",
    },
    {
      "name": "Phone Payment",
      "date": "10 Dec 5:12am",
      "icon": Icon(Icons.phone_android_outlined, size: 35, color: Colors.white),
      "payment": "500 kr",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 135, 235, 157),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new)),
              title: Text("Transaction", style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.white),
              ),centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Text(
                          "21.12.2022",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Expanded(
                  flex: 9,
                  child: ListView.builder(
                    itemCount: paymentList.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return paymentList != null
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: double.infinity,
                                height: size.height * .12,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 142, 255, 146),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Card(
                                  color: Color.fromARGB(255, 179, 255, 181),
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: size.height * .10,
                                                width: size.width * .10,
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 128, 171, 130),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: paymentList[index]
                                                    ["icon"],
                                              ),
                                            )
                                          ],
                                        ),
                                        // SizedBox(
                                        //   width: size.width * 0.05,
                                        // ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "${paymentList[index]["name"]}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${paymentList[index]["date"]}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "${paymentList[index]["payment"]}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.05,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ShimmerEffect.gridviewShimerLoader();
                    }),
                  ),
                ),
              ],
            )));
  }
}
