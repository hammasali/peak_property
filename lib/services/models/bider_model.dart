import 'package:cloud_firestore/cloud_firestore.dart';

class BidersModel {
  String? price, image, uid;
  Timestamp? createdAt;

  BidersModel({this.price, this.image, this.createdAt, this.uid});

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'image': image,
      'createdAt': createdAt,
      'uid': uid,
    };
  }

  factory BidersModel.fromMap(Map<String, dynamic> map) {
    return BidersModel(
      price: map['price'] as String,
      image: map['image'] as String,
      uid: map['uid'] as String,
    );
  }
}
