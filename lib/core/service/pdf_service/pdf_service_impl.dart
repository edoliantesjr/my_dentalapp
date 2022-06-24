import 'dart:io';
import 'dart:typed_data';

import 'package:dentalapp/core/service/pdf_service/pdf_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/payment/payment.dart';
import 'package:dentalapp/models/prescription/prescription.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/dental_certificate/dental_certificate.dart';
import '../../../models/patient_model/patient_model.dart';

class PdfServiceImp extends PdfService {
  @override
  Future<Uint8List> printDentalCertificate(
      {required DentalCertificate dentalCertificate,
      required Patient patient}) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Container(
          height: PdfPageFormat.a4.height,
          width: PdfPageFormat.a4.width,
          child: pw.Column(children: [
            pw.Text('Maglinte Dental Clinic',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                )),
            pw.Text('Poblacion, Bilar, Bohol',
                style: const pw.TextStyle(
                  fontSize: 13,
                )),
            pw.SizedBox(height: 25),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Dr. Lister Anthony Maglinte',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 13,
                            )),
                      ]),
                  pw.Text('Dental Surgeon',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      )),
                  pw.SizedBox(height: 4),
                ],
              ),
            ),
            pw.Divider(
              thickness: 2,
              color: PdfColor.fromHex("#000000"),
            ),
            pw.SizedBox(height: 20),
            pw.Align(
                child: pw.Text('DENTAL CERTIFICATE',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ))),
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Column(children: [
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('To whom it may concern:',
                          style: const pw.TextStyle(
                            fontSize: 12,
                          )),
                      pw.SizedBox(height: 8),
                      pw.Wrap(spacing: 4, runSpacing: 4, children: [
                        pw.Text('This is to certify that patient ',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text('${patient.firstName}, ${patient.lastName} ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text('has undergone the procedure - ',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text('${dentalCertificate.procedure.toUpperCase()} ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Text('on ',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.Text(
                            '${DateFormat.yMMMd().format(dentalCertificate.date.toDateTime()!).toUpperCase()}. ',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            )),
                      ]),
                    ],
                  ),
                ),
              ]),
            ),
            pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(4),
                        decoration: pw.BoxDecoration(
                            border: pw.Border(
                                bottom: pw.BorderSide(
                                    width: 1,
                                    color: PdfColor.fromHex("#000000")))),
                        child: pw.Text('DR. LISTER ANTHONY MAGLINTE'),
                      ),
                      pw.Text('SIGNATURE')
                    ])),
            pw.SizedBox(height: 20),
            pw.Divider(
              thickness: 2,
              color: PdfColor.fromHex("#000000"),
            ),
          ]),
        ),
      ),
    );

    return pdf.save();
  }

  @override
  Future<Uint8List> printPrescription(
      {required Prescription prescription, required Patient patient}) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(
            4 * PdfPageFormat.inch, 7 * PdfPageFormat.inch,
            marginAll: 0.2 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return pw.Container(
            height: PdfPageFormat.a4.height,
            width: PdfPageFormat.a4.width,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('Maglinte Dental Clinic',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 14,
                    )),
                pw.Text('Poblacion, Bilar, Bohol',
                    style: const pw.TextStyle(
                      fontSize: 13,
                    )),
                pw.SizedBox(height: 15),
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text('Dr. Lister Anthony Maglinte',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 13,
                                  )),
                            ]),
                        pw.Text('Dental Surgeon',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Text(
                            'Date: ${DateFormat.yMMMd().add_jm().format(prescription.date.toDateTime()!)}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            )),
                      ]),
                ),
                pw.Divider(
                  thickness: 2,
                  color: PdfColor.fromHex("#000000"),
                ),
                pw.Expanded(
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Patient Name: ${patient.fullName}'),
                        pw.Text('Address: ${patient.address}'),
                        pw.Text('Contact #: ${patient.phoneNum}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Rx',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 24,
                            )),
                        pw.ListView.separated(
                          itemBuilder: (context, index) => pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      prescription
                                          .prescriptionItems[index].inscription,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'Disp. ' +
                                          prescription.prescriptionItems[index]
                                              .subscription,
                                      style: const pw.TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    pw.Text(
                                      'Sig. ' +
                                          prescription.prescriptionItems[index]
                                              .signatura,
                                      style: const pw.TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ])),
                          separatorBuilder: (context, index) =>
                              pw.SizedBox(height: 5),
                          itemCount: prescription.prescriptionItems.length,
                        ),
                      ]),
                ),
                pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(4),
                            decoration: pw.BoxDecoration(
                                border: pw.Border(
                                    bottom: pw.BorderSide(
                                        width: 1,
                                        color: PdfColor.fromHex("#000000")))),
                            child: pw.Text('DR. LISTER ANTHONY MAGLINTE'),
                          ),
                          pw.Text('SIGNATURE')
                        ]))
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Future<Uint8List> printReceipt({required Payment payment}) {
    throw UnimplementedError();
  }

  // ignore: annotate_overrides
  Future<void> savePdfFile(
      {required String fileName, required Uint8List byteList}) async {
    final output = await getExternalStorageDirectory();
    var filePath = "${output!.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
