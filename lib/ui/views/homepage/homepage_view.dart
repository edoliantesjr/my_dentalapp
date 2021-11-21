import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          'HomePage',
          style: TextStyles.tsHeading2(),
        ),
      ),
    );
  }
}
