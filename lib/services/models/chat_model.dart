import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? senderId, receiverId, message, name, photo, time;
  Timestamp? timestamp;

  ChatModel(
      {this.senderId,
      this.receiverId,
      this.message,
      this.name,
      this.photo,
      this.time,
      this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'name': name,
      'photo': photo,
      'time': time,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      name: map['name'] as String,
      photo: map['photo'] as String,
      time: map['time'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
