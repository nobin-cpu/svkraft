import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/grocery/model/product_model.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/chatbox.dart';
import 'package:sv_craft/Features/market_place/view/reportuser.dart';
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
  final TextEditingController demo = TextEditingController(text: "block");
  Future blockuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.reportuser),
    );
    request.fields.addAll({
      'userId': widget.sellerId.toString(),
      'message': "block",
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          // saveprefs(data["bearer_token"]);
          // chat.clear();
          print(response.body.toString());
          setState(() {});
          Get.to(() => HomeScreen());
        } else {
          print("Fail! ");
          print(response.body.toString());

          return response.body;
        }
      });
    });
  }

  // saveprefs(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('token', token);
  // }

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

  Future reportuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.reportuser),
    );
    request.fields.addAll({
      'userId': widget.sellerId.toString(),
      'message': officer.toString(),
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          // saveprefs(data["data"]["bearer_token"]);
          // chat.clear();

          setState(() {});
          Get.to(HomeScreen());
        } else {
          print("Fail! ");
          print(response.body.toString());

          return response.body;
        }
      });
    });
  }

  saveprefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', token);
  }

  String officer = 'Violent content';
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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
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
                    left: size.width * .7, top: size.height * .02),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                Text("Report this user".tr),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                      "Select a reason below to report".tr),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 15),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .07,
                                    width: double.infinity,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(10),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        labelText: 'Select a reason',
                                        hintText: 'Choose Officer',
                                      ),
                                      dropdownColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      value: officer,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          officer = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Violent content',
                                        'Abbusive language',
                                        'potential violence',
                                        'Others'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // content:
                            // Text(
                            //     "Are you sure you want to report this user?"
                            //         .tr),
                            actions: <Widget>[
                              TextButton(
                                child: Text("YES".tr),
                                onPressed: () {
                                  // Get.to(() => Reportuser(
                                  //       id: widget.sellerId != null
                                  //           ? widget.sellerId.toString()
                                  //           : "0",
                                  //     ));
                                  reportuser();
                                },
                              ),
                              TextButton(
                                child: Text("NO".tr),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: size.height * .05,
                    width: size.width * .23,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 0, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.report,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Report".tr,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )),
                  ),
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
                    height: MediaQuery.of(context).size.height * .37,
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
                                  "Massage".tr,
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
                                  "Call".tr,
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
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Block this user".tr),
                                          content: Text(
                                              "Are you sure you want to Block this user?"
                                                  .tr),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("YES".tr),
                                              onPressed: () {
                                                blockuser();
                                                print(demo.text);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("NO".tr),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Block".tr,
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
                          childAspectRatio: .9,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing:
                              MediaQuery.of(context).size.height * .02,
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
