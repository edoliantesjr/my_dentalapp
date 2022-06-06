import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentCard extends StatelessWidget {
  final Payment payment;
  final VoidCallback onViewReceiptTap;
  const PaymentCard(
      {Key? key, required this.payment, required this.onViewReceiptTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Procedure Subtotal: ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        payment.dentalNoteSubTotal.toCurrency!,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine Subtotal: ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        payment.medicineSubTotal.toCurrency!,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount Paid: ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        payment.totalAmount.toString().toCurrency!,
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 17,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Date: ',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd()
                            .add_jm()
                            .format(payment.paymentDate.toDateTime()!),
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            InkWell(
              onTap: () => onViewReceiptTap(),
              child: Container(
                height: 40,
                padding: EdgeInsets.all(8),
                width: double.maxFinite,
                color: Colors.grey.shade100,
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('View Receipt'),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
