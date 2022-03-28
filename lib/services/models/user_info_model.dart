class UserInfoModel {
  String? name, email, createdAt, phoneNo, description, gender, profilePhoto;

  UserInfoModel(
      {this.name,
      this.email,
      this.createdAt,
      this.description,
      this.phoneNo,
      this.gender,
      this.profilePhoto});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'phoneNo': phoneNo,
      'description': description,
      'gender': gender,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as String,
      phoneNo: map['phoneNo'] as String,
      description: map['description'] as String,
      gender: map['gender'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }
}
