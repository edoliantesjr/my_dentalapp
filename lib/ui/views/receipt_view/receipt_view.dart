import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/views/receipt_view/receipt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import '../../../models/payment/payment.dart';

class ReceiptView extends StatelessWidget {
  final Payment payment;
  const ReceiptView({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReceiptViewModel>.nonReactive(
      viewModelBuilder: () => ReceiptViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Payment Complete'),
        ),
        body: Screenshot(
          controller: model.screenShotController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Palettes.kcBlueMain1,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => model.downloadReceipt(
                              MediaQuery.of(context).devicePixelRatio),
                          icon: Icon(Icons.download),
                          label: Text('Download'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.green,
                        ),
                        Text(
                          'Successfully Recorded the payment of patient',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '${payment.patient_name}',
                            style: TextStyle(
                              color: Palettes.kcDarkerBlueMain1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        payment.dentalNote!.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Text('Dental Notes'),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    text: payment
                                                        .dentalNote![index]
                                                        .procedure
                                                        .procedureName,
                                                    children: [
                                                      TextSpan(
                                                        text: ' @tooth#' +
                                                            payment
                                                                .dentalNote![
                                                                    index]
                                                                .selectedTooth,
                                                      )
                                                    ],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Text(payment.dentalNote![index]
                                                  .procedure.price!
                                                  .toString()
                                                  .toCurrency!),
                                            ],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.dentalNote!.length),
                                ],
                              )
                            : Container(),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 4),
                        payment.medicineList!.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Medicines'),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    text: payment
                                                        .medicineList![index]
                                                        .medicineName,
                                                    children: [
                                                      TextSpan(
                                                          text: ' @' +
                                                              payment
                                                                  .medicineList![
                                                                      index]
                                                                  .price
                                                                  .toString()
                                                                  .toCurrency!)
                                                    ],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              Text('x' +
                                                  payment
                                                      .medicineList![index].qty
                                                      .toString()),
                                            ],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Divider(height: 1),
                                      itemCount: payment.medicineList!.length),
                                ],
                              )
                            : Container(),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dental Note SubTotal: '),
                            Text(payment.dentalNoteSubTotal
                                .toString()
                                .toCurrency!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Medicine SubTotal: '),
                            Text(payment.medicineSubTotal
                                .toString()
                                .toCurrency!),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount Due: '),
                              Text(payment.totalAmount.toString().toCurrency!),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Ref. No.: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                TextSpan(
                                    text: payment.payment_id,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal))
                              ])),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Image.asset(
                            'assets/icons/logo-blue-circle.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Center(child: Text('Maglinte Dental Clinic')),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  ClipPath(
                    clipper: MultipleRoundedCurveClipper(),
                    child: Container(
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
