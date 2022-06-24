import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesDateCard extends StatelessWidget {
  final double amount;
  final String title;
  final Function onTap;
  final Color borderColor;
  const SalesDateCard({
    Key? key,
    required this.amount,
    required this.title,
    required this.onTap,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      splashColor: Colors.blueAccent,
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                color: borderColor,
                width: 4,
              ))),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                  Text('$amount'.toCurrency!,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1.4,
                        color: borderColor,
                      )),
                  // Icon(
                  //   Icons.arrow_forward_ios_sharp,
                  //   color: borderColor,
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
