import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Procedure extends Equatable {
  final String? id;
  final String procedureName;
  final String? price;
  final dynamic dateCreated;

  Procedure(
      {this.id, required this.procedureName, this.price, this.dateCreated});

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
        price: (map['price']) != null ? map['price'] : '',
        dateCreated: map['dateCreated']);
  }

  final currency = NumberFormat("#,##0.00", "en_PH");
  String? get priceToCurrency {
    if (this.price != '') {
      return ' ₱${currency.format(double.tryParse(this.price ?? '0'))}';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props =>
      [id, procedureName, price, priceToCurrency, dateCreated];
}
