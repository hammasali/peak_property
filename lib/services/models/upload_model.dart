import 'dart:core';

import 'package:image_picker/image_picker.dart';

class UploadModel {
  String? state;
  String? city;
  String? address;
  String? preference;
  String? title;
  String? description;
  String? category;
  String? type;
  String? startPrice;
  String? endPrice;
  double? timeRange;
  String? bidTime;
  String? areaRange;
  String? areaType;
  String? bedrooms;
  String? bathrooms;
  String? createdAt;
  String? uid;
  String? docId;
  String? thumbnail;
  List<dynamic>? pickedFilesName;
  List<XFile>? pickedFile;

  UploadModel(
      {this.state,
      this.city,
      this.address,
      this.preference,
      this.title,
      this.description,
      this.category,
      this.type,
      this.startPrice,
      this.endPrice,
      this.timeRange,
      this.bidTime,
      this.areaRange,
      this.areaType,
      this.bedrooms,
      this.bathrooms,
      this.createdAt,
      this.pickedFilesName,
      this.uid,
      this.thumbnail,
      this.pickedFile,
      this.docId});

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'city': city,
      'uid': uid,
      'address': address,
      'preference': preference,
      'title': title,
      'description': description,
      'category': category,
      'type': type,
      'startPrice': startPrice,
      'endPrice': endPrice,
      'timeRange': timeRange,
      'bidTime' : bidTime,
      'areaRange': areaRange,
      'areaType': areaType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'createdAt': createdAt,
      'pickedFilesName': pickedFilesName,
    };
  }

  factory UploadModel.fromMap(Map<String, dynamic> map,
      [String? imageUrl, String? docId]) {
    return UploadModel(
        state: map['state'] as String,
        city: map['city'] as String,
        uid: map['uid'] as String,
        address: map['address'] as String,
        preference: map['preference'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        category: map['category'] as String,
        type: map['type'] as String,
        startPrice: map['startPrice'] as String,
        endPrice: map['endPrice'] as String,
        timeRange: map['timeRange'] as double,
        bidTime: map['bidTime'] as String,
        areaRange: map['areaRange'] as String,
        areaType: map['areaType'] as String,
        bedrooms: map['bedrooms'] as String,
        bathrooms: map['bathrooms'] as String,
        createdAt: map['createdAt'] as String,
        pickedFilesName: map['pickedFilesName'],
        thumbnail: imageUrl,
        docId: docId
        // pickedFile: map['pickedFile'] as List<XFile>,
        );
  }
}
