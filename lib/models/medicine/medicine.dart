class Medicine {
  final String? id;
  final String medicineName;
  final String? brandName;
  final String price;
  final String? image;
  final dynamic dateCreated;

  Medicine(
      {this.id,
      required this.medicineName,
      required this.price,
      this.brandName,
      this.image,
      this.dateCreated});

  Map<String, dynamic> toJson(
      {String? id, required String image, required dynamic dateCreated}) {
    return {
      'id': id,
      'medicineName': this.medicineName,
      'price': this.price,
      'image': this.image,
      'brandName': this.brandName ?? 'Not Set',
      'dateCreated': dateCreated
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> map) {
    return Medicine(
        id: map['id'],
        image: map['image'],
        medicineName: map['medicineName'] as String,
        price: map['price'] as String,
        brandName: map['brandName'],
        dateCreated: map['dateCreated']);
  }
}
