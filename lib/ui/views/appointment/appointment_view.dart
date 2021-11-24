import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          'Appointments View',
          style: TextStyles.tsHeading1(),
        ),
      ),
    );
  }
}
