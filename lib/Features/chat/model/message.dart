import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? senderUid;
  String? receiverUid;
  String? type;
  String? message;
  FieldValue? timestamp;
  String? photoUrl;
  String? name;

  Message(
      {this.senderUid,
      this.receiverUid,
      this.type,
      this.photoUrl,
      this.name,
      this.message,
      this.timestamp});
  Message.withoutMessage(
      {this.senderUid,
      this.receiverUid,
      this.type,
      this.name,
      this.timestamp,
      this.photoUrl});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUid;
    map['receiverUid'] = this.receiverUid;
    map['type'] = this.type;
    map['photoUrl'] = this.photoUrl;
    map['name'] = this.name;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Message fromMap(Map<String, dynamic> map) {
    Message _message = Message();
    _message.senderUid = map['senderUid'];
    _message.receiverUid = map['receiverUid'];
    _message.type = map['type'];
    _message.photoUrl = map['photoUrl'];
    _message.name = map['name'];
    _message.message = map['message'];
    _message.timestamp = map['timestamp'];
    return _message;
  }
}
