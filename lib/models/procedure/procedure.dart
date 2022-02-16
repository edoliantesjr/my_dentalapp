class Procedure {
  //todo: To modify in the future

  final String? id;
  final String procedureName;
  final String price;
  final dynamic dateCreated;

  const Procedure(
      {this.id,
      required this.procedureName,
      required this.price,
      this.dateCreated});

  Map<String, dynamic> toJson({String? id, required dynamic dateCreated}) {
    return {
      'id': id,
      'procedureName': this.procedureName,
      'price': this.price,
      'dateCreated': dateCreated
    };
  }

  factory Procedure.fromJson(Map<String, dynamic> map) {
    return Procedure(
        id: map['id'] as String,
        procedureName: map['procedureName'] as String,
        price: map['price'] as String,
        dateCreated: map['dateCreated']);
  }
}
