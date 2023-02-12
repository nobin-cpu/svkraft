import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';
import '../../market_place/messaging/database.dart';
import '../../profile/controller/get_profile_con.dart';
import 'chat_screen.dart';
import 'helf_funtion.dart';

class RecentChats extends StatefulWidget {
  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  final GetProfileController profileController =
      Get.put(GetProfileController());
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> usersList = [];
  late final CollectionReference _collectionReference;

  @override
  void initState() {
    super.initState();

    _collectionReference = firebaseFirestore.collection("users");
    _subscription = _collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        usersList = datasnapshot.docs;
        print("Users List ${usersList.length}");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text("All Users"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {},
            )
          ],
        ),
        body: usersList != null
            ? Container(
                child: ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: ((context, index) {
                    print(
                        "${Appurl.baseURL + usersList[index]['photoUrl'].toString()}");
                    return Card(
                      child: usersList[index]['userid'] ==
                              profileController.userProfileModel.value.data!.id
                                  .toString()
                          ? Container()
                          : ListTile(
                              leading: usersList[index]['photoUrl'] != "null"
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          Appurl.baseURL +
                                              usersList[index]['photoUrl']
                                                  .toString()),
                                    )
                                  : const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          "https://media.istockphoto.com/photos/businessman-silhouette-as-avatar-or-default-profile-picture-picture-id476085198?b=1&k=20&m=476085198&s=612x612&w=0&h=Ov2YWXw93vRJNKFtkoFjnVzjy_22VcLLXZIcAO25As4="),
                                    ),
                              title: Text(usersList[index]['name'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              subtitle:
                                  Text("Id : " + usersList[index]['userid'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      )),
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              name: usersList[index]['name']
                                                  .toString(),
                                              receiverUid: usersList[index]
                                                      ['userid']
                                                  .toString(),
                                            )));
                              }),
                            ),
                    );
                  }),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
