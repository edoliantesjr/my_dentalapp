import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:ticketview/ticketview.dart';

class ReceiptView extends StatelessWidget {
  final dynamic paymentId;
  const ReceiptView({Key? key, required this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Complete'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Palettes.kcBlueMain1,
        child: Center(
          child: TicketView(
            backgroundPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            backgroundColor: Color(0xFF8F1299),
            contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
            drawArc: false,
            triangleAxis: Axis.vertical,
            borderRadius: 6,
            drawDivider: true,
            trianglePos: .5,
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width - 80,
            ),
          ),
        ),
      ),
    );
  }
}
