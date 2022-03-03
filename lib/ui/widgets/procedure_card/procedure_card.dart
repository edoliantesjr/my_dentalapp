import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ProcedureCard extends StatelessWidget {
  final String id;
  final String procedureName;
  final String? price;
  final VoidCallback? onTap;
  const ProcedureCard(
      {Key? key,
      required this.id,
      required this.procedureName,
      this.price,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
                ]),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  procedureName,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('Amnt. '),
                    Text(
                      price ?? 'Not Set',
                      style: TextStyles.tsBody2(color: Colors.deepOrange),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
