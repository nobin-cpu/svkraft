import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/grocery/model/product_model.dart';
import 'package:sv_craft/Features/market_place/view/chatbox.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details.dart';

class Sellerdetils extends StatefulWidget {
  final String sellerId, sellerName, sellerNumber, sellerImage, email;
  const Sellerdetils({
    super.key,
    required this.sellerId,
    required this.sellerName,
    required this.sellerNumber,
    required this.sellerImage,
    required this.email,
  });

  @override
  State<Sellerdetils> createState() => _SellerdetilsState();
}

class _SellerdetilsState extends State<Sellerdetils> {
  final GetProfileController getProfileController =
      Get.put(GetProfileController());
  Future viewOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response = await http.get(
        Uri.parse(Appurl.sellerProduct + widget.sellerId),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)['product'];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? viewall_experience;
  @override
  void initState() {
    viewall_experience = viewOffers();
    print(widget.sellerId);
    print(widget.sellerImage);
    print(widget.sellerName);
    print(widget.sellerNumber);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 150.0,
                width: double.infinity,
                child: Image.asset(
                  "images/user.png",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .0,
                    top: MediaQuery.of(context).size.height * .007),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .20,
                  ),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    child: Column(
                      children: [
                        widget.sellerImage != ""
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor:
                                      Color.fromARGB(255, 169, 169, 169),
                                  backgroundImage: NetworkImage(
                                      Appurl.baseURL + widget.sellerImage),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundColor:
                                      Color.fromARGB(255, 187, 187, 187),
                                  child: Icon(
                                    Icons.person,
                                    size: 45,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.sellerName.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .07,
                              width: MediaQuery.of(context).size.width * .3,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // final Uri webURl = Uri.parse(Appurl.baseURL +
                                  //     "chat-room/${getProfileController.userProfileModel.value.data!.id}/" +
                                  //     widget.sellerId);

                                  // if (!await launchUrl(webURl)) {
                                  //   throw 'Could not launch $webURl';
                                  // }
                                  Get.to(Chatbox(
                                    userId: int.parse(widget.sellerId) != null
                                        ? int.parse(widget.sellerId)
                                        : 0,
                                    image: Appurl.baseURL +
                                                widget.sellerImage !=
                                            null
                                        ? Appurl.baseURL + widget.sellerImage
                                        : "0",
                                    name: widget.sellerName != null
                                        ? widget.sellerName.toString()
                                        : "0",
                                    email: widget.email != null
                                        ? widget.email.toString()
                                        : "0",
                                    phone: widget.sellerNumber != null
                                        ? widget.sellerNumber.toString()
                                        : "0",
                                  ));
                                },
                                child: Text(
                                  "Massage",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 0, 139, 186),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .07,
                              width: MediaQuery.of(context).size.width * .3,
                              child: ElevatedButton(
                                onPressed: () {
                                  launch("tel://${widget.sellerNumber}");
                                },
                                child: Text(
                                  "Call",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 0, 139, 186),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          FutureBuilder(
            future: viewall_experience,
            builder: (_, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      child: GridView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width:
                                        MediaQuery.of(context).size.width * .46,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => Detailss(
                                              Id: snapshot.data[index]["id"]
                                                  .toString(),
                                              productId: snapshot.data[index]
                                                      ["product_id"]
                                                  .toString(),
                                            ));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          Appurl.baseURL +
                                              snapshot.data[index]["image"][0]
                                                  ["file_path"],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => Detailss(
                                              Id: snapshot.data[index]["id"]
                                                  .toString(),
                                              productId: snapshot.data[index]
                                                      ["product_id"]
                                                  .toString(),
                                            ));
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index]
                                                ["product_name"]),
                                            Text(snapshot.data[index]["price"]
                                                    .toString() +
                                                "kr".tr)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.height * .09,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                );
              } else {
                return Text("No productt found");
              }
            },
          ),
        ],
      ),
    )));
  }
}
