import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/controller/get_profile_con.dart';

class messages extends StatefulWidget {
  String email;
  messages({required this.email});
  @override
  _messagesState createState() => _messagesState(email: email);
}

class _messagesState extends State<messages> {
  String email;
  _messagesState({required this.email});
  final GetProfileController getProfileController =
      Get.put(GetProfileController());
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
        child: StreamBuilder(
      stream: firebaseFirestore
          .collection('messages')
          .doc("groupChatId$email")
          .collection("groupChatId$email")
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return snapshot.data!.docs.length <= 0
                        ? Text("Message Not Found")
                        : snapshot.data.docs[index]['senderid'] ==
                                getProfileController
                                    .userProfileModel.value.data!.id
                            ? Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      color: Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Name : "
                                                "${snapshot.data.docs[index]['name']}"),
                                            Text("ID : "
                                                "${snapshot.data.docs[index]['receverid']}"),
                                            Text("Message : "
                                                "${snapshot.data.docs[index]['content']}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("ID : "
                                          "${snapshot.data.docs[index]['receverid']}"),
                                      Text("Message : "
                                          "${snapshot.data.docs[index]['content']}"),
                                    ],
                                  ),
                                ),
                              );
                  }),
            ),
          );
        }
      },
    ));
 
 
  }
}
