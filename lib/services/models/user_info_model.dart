import 'package:image_picker/image_picker.dart';

class UserInfoModel {
  String? name, email, createdAt, phoneNo, username, aboutUser;
  XFile? profilePhoto;

  UserInfoModel(
      {this.name,
      this.email,
      this.createdAt,
      this.phoneNo,
      this.username,
      this.aboutUser,
      this.profilePhoto});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'phoneNo': phoneNo,
      'username': username,
      'aboutUser': aboutUser,
    };
  }
  Map<String, dynamic> toMapUpdateProfile() {
    return {
      'name': name,
      'phoneNo': phoneNo,
      'username': username,
      'aboutUser': aboutUser,
    };
  }
  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as String,
      phoneNo: map['phoneNo'] as String,
      username: map['username'] as String,
      aboutUser: map['aboutUser'] as String,
      profilePhoto: map['profilePhoto'] as XFile,
    );
  }
}
