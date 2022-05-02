class BidersModel {
  String? price, image, createdAt;

  BidersModel({this.price, this.image, this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'image': image,
      'createdAt': createdAt,
    };
  }

  factory BidersModel.fromMap(Map<String, dynamic> map) {
    return BidersModel(
      price: map['price'] as String,
      image: map['image'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
