import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles/palette_color.dart';

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
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 0), blurRadius: 1)
              ]),
          child: Row(
            children: [
              Container(
                  width: 5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Palettes.kcDarkerBlueMain1,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4)))),
              SizedBox(width: 4),
              Padding(
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
                ),
              ),
            ],
          )),
    );
  }
}
