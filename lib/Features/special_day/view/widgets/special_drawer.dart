import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/special_day/view/category_product.dart';
import 'package:sv_craft/Features/special_day/view/widgets/alarm_system.dart';
import 'package:sv_craft/constant/api_link.dart';

import 'package:url_launcher/url_launcher.dart';


var tokenp;
var id;

List specialDrawerItem = [
  {
    "Name": "Special Day",
    "Icon": const Icon(Icons.local_activity),
  },
  {
    "Name": "Wallet",
    "Icon": const Icon(Icons.wallet_giftcard),
  },
  {
    "Name": "Flowers In Vases",
    "Icon": const Icon(Icons.favorite),
  },
  {
    "Name": "Flower & Chocolate",
    "Icon": const Icon(Icons.fastfood_outlined),
  },
  {
    "Name": "Gift Box",
    "Icon": const Icon(Icons.payment),
  },
  {
    "Name": "Privacy and Policy",
    "Icon": const Icon(Icons.support),
  },
  {
    "Name": "Help and Support",
    "Icon": const Icon(Icons.settings),
  },
  {
    "Name": "Call US",
    "Icon": const Icon(Icons.call),
  },
];

Widget buildDrawer(context) {
  return Drawer(
    child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: specialDrawerItem.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigatorRoutinDrawer(
                      specialDrawerItem[index]['Name'], context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            specialDrawerItem[index]["Icon"],
                            const SizedBox(width: 8),
                            Text(
                              "${specialDrawerItem[index]['Name']}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        color: Colors.black12,
                        height: 1,
                      )
                    ],
                  ),
                ),
              );
            })),
  );
}

void navigatorRoutinDrawer(String rountName, context) async {
  switch (rountName) {
    case "Special Day":
      {
        Get.to(AlarmScreen());
      }
      break;
    case "Wallet":
      {
        Get.to(CategoryProuctScreen(
          token: "token",
          id: 5,
        ));
      }
      break;

    case "Flowers In Vases":
      {
        Get.to(CategoryProuctScreen(
          token: "token",
          id: 2,
        ));
      }
      break;
    case "Flower & Chocolate":
      {
        Get.to(CategoryProuctScreen(
          token: "token",
          id: 1,
        ));
      }
      break;
    case "Gift Box":
      {
        Get.to(CategoryProuctScreen(
          token: "token",
          id: 3,
        ));
      }
      break;
    case "Call US":
      {
        print("Call Us");
      }
      break;
    case "Payment History":
      {}
      break;
    case "Logout":
      break;
    case "Privacy and Policy":
      {
        final Uri webURl = Uri.parse(Appurl.baseURL + "privacy-policy");

        if (!await launchUrl(webURl)) {
          throw 'Could not launch $webURl';
        }
      }
      break;
    case "Help and Support":
      {
        Get.bottomSheet(
          backgroundColor: Colors.transparent,
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Help And Support",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLength: 556,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Message',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 66, 125, 145))),
                          hintText: "Message here"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () {}, child: const Text("Send"))
                  ],
                ),
              )),
          isDismissible: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          enableDrag: false,
        );
      }
      break;

    default:
      {
        print("Defult");
      }
      break;
  }
}
