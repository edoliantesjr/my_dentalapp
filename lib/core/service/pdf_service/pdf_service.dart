import 'dart:typed_data';

import 'package:dentalapp/models/dental_certificate/dental_certificate.dart';
import 'package:dentalapp/models/payment/payment.dart';
import 'package:dentalapp/models/prescription/prescription.dart';

import '../../../models/patient_model/patient_model.dart';

abstract class PdfService {
//
  Future<Uint8List> printReceipt({required Payment payment});

  Future<Uint8List> printPrescription(
      {required Prescription prescription, required Patient patient});

  Future<Uint8List> printDentalCertificate(
      {required DentalCertificate dentalCertificate, required Patient patient});

  Future<void> savePdfFile(
      {required String fileName, required Uint8List byteList});
}
