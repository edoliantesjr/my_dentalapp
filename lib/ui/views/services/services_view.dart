import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          'Services View',
          style: TextStyles.tsHeading1(),
        ),
      ),
    );
  }
}
