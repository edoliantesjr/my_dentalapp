import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:dentalapp/models/procedure/procedure.dart';

class Payment {
  final String payment_id;
  final String appointment_id;
  final List<Procedure?>? procedures;
  final List<Medicine?>? medicines;
  final String subTotal;
  final String total;

  const Payment({
    required this.payment_id,
    required this.appointment_id,
    this.procedures,
    this.medicines,
    required this.subTotal,
    required this.total,
  });
}
