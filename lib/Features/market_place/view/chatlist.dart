import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:http/http.dart' as http;

import 'chatbox.dart';

class Chatlist extends StatefulWidget {
  const Chatlist({super.key});

  @override
  State<Chatlist> createState() => _ChatlistState();
}

class _ChatlistState extends State<Chatlist> {
  Future viewOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };

    var response =
        await http.get(Uri.parse(Appurl.chatlist), headers: requestHeaders);
    if (response.statusCode == 200) {
      print('Get post collected' + response.body);
      var userData1 = jsonDecode(response.body)["data"];

      return userData1;
    } else {
      print("post have no Data${response.body}");
    }
  }

  Future? chat;
  @override
  void initState() {
    chat = viewOffers();
    // print(widget.);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat list".tr),
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              FutureBuilder(
                future: chat,
                builder: (_, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Container(
                      child: ListView.separated(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              // Get.to(() => Detailss(
                              //       Id: snapshot.data[index]["product_id"]
                              //           .toString(),
                              //       productId: snapshot.data[index]
                              //               ["product_id"]
                              //           .toString(),
                              //     ));
                              // print("this is id  " +
                              //     snapshot.data[index]["id"].toString() +
                              //     "this is product_id  " +
                              //     snapshot.data[index]["product_id"]
                              //         .toString());
                              Get.to(() => Chatbox(
                                  userId: snapshot.data[index]["userId"],
                                  image: Appurl.baseURL +
                                      snapshot.data[index]["image"],
                                  name: snapshot.data[index]["name"],
                                  email: snapshot.data[index]["email"],
                                  phone: snapshot.data[index]["phone"]));
                            },
                            leading: CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height * .05,
                                backgroundImage: NetworkImage(
                                  Appurl.baseURL +
                                      snapshot.data[index]["image"],
                                )),
                            title: Text(snapshot.data[index]["name"]),
                            subtitle:
                                Text(snapshot.data[index]["last_message"]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    );
                  } else {
                    return Text("No productt found");
                  }
                },
              ),
            ],
          )),
    );
  }
}
