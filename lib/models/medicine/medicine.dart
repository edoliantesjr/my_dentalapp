class Medicine {
  //todo: To modify in the future
  final int? id;
  final String medicineName;
  final String price;
  final String dateCreated;

  Medicine(
      {this.id,
      required this.medicineName,
      required this.price,
      required this.dateCreated});

  Map<String, dynamic> toJson({String? id, required dynamic dateCreated}) {
    return {
      'id': id,
      'medicineName': this.medicineName,
      'price': this.price,
      'dateCreated': dateCreated
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> map) {
    return Medicine(
        id: map['id'] as int,
        medicineName: map['medicineName'] as String,
        price: map['price'] as String,
        dateCreated: map['dateCreated']);
  }
}
