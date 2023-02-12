import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:sv_craft/constant/api_link.dart';

import '../../profile/controller/get_profile_con.dart';
import '../model/message.dart';

class ChatScreen extends StatefulWidget {
  String? name;
  String? receiverUid;
  ChatScreen({super.key, this.name, this.receiverUid});

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = false;
  final GetProfileController profileController =
      Get.put(GetProfileController());
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Message _message;
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  late CollectionReference _collectionReference;
  late DocumentSnapshot documentSnapshot;
  var listItem;
  late String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  late StreamSubscription<DocumentSnapshot> subscription;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });

    _messageController = TextEditingController();

    setState(() {
      isLoading = false;
    });
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;

      listScrollController.jumpTo(position);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addMessageToDb(Message message) async {
    Map<String, dynamic> map = {
      "senderUid": profileController.userProfileModel.value.data!.id.toString(),
      "receiverUid": widget.receiverUid,
      "message": message.message,
      "timestamp": message.timestamp,
      "photoUrl": profileController.userProfileModel.value.data!.image,
    };

    print("Map Data::::::: ${map}");
    _collectionReference = firebaseFirestore
        .collection("messages")
        .doc(profileController.userProfileModel.value.data!.id.toString())
        .collection(widget.receiverUid.toString());

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = firebaseFirestore
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(
            profileController.userProfileModel.value.data!.id.toString());

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _messageController.text = "";
  }

  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listScrollController.hasClients) {
        final position = listScrollController.position.maxScrollExtent;

        listScrollController.jumpTo(position);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  StreamBuilder(
                    stream: firebaseFirestore
                        .collection('messages')
                        .doc(profileController.userProfileModel.value.data!.id
                            .toString())
                        .collection(widget.receiverUid.toString())
                        .orderBy('timestamp', descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return SizedBox(
                          child: ListView.builder(
                            controller: listScrollController,
                            shrinkWrap: true,
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(10.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var snapshotData = snapshot.data!.docs[index];
                              // snapshotData['senderUid'] == _senderuid
                              return Container(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (snapshotData['senderUid'] ==
                                          profileController
                                              .userProfileModel.value.data!.id
                                              .toString()
                                      ? Alignment.topRight
                                      : Alignment.topLeft),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (snapshotData['senderUid'] ==
                                              profileController.userProfileModel
                                                  .value.data!.id
                                                  .toString()
                                          ? Colors.blue[200]
                                          : Colors.grey.shade200),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      snapshotData['message'],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      height: 60,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_photo_alternate)),
                          Expanded(
                            child: TextFormField(
                              validator: (String? input) {
                                if (listScrollController.hasClients) {
                                  final position = listScrollController
                                      .position.maxScrollExtent;

                                  listScrollController.jumpTo(position);
                                }
                                if (input!.isEmpty) {
                                  return "Please enter message";
                                }
                              },
                              controller: _messageController,
                              decoration: const InputDecoration(
                                  hintText: "Write message...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                sendMessage();
                              }
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // chatMessagesListWidget(),
                  // const Divider(
                  //   height: 20.0,
                  //   color: Colors.black,
                  // ),

                  // const SizedBox(
                  //   height: 10.0,
                  // ),
                  // chatInputWidget(),
                ],
              ),
      ),
    );
  }

  void sendMessage() async {
    var text = _messageController.text;

    _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: profileController.userProfileModel.value.data!.id.toString(),
        message: text,
        name: profileController.userProfileModel.value.data!.name,
        photoUrl:
            profileController.userProfileModel.value.data!.image.toString(),
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');

    addMessageToDb(_message);
  }

  Future<DocumentSnapshot> getSenderPhotoUrl(String uid) {
    var senderDocumentSnapshot =
        firebaseFirestore.collection('users').doc(uid).get();
    return senderDocumentSnapshot;
  }

  Future<DocumentSnapshot> getReceiverPhotoUrl(String uid) {
    var receiverDocumentSnapshot =
        firebaseFirestore.collection('users').doc(uid).get();
    return receiverDocumentSnapshot;
  }
}
