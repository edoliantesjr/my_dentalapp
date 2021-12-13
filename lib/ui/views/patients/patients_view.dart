import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Dental Patients',
          style: TextStyles.tsHeading3(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'Patients View',
            style: TextStyles.tsHeading1(),
          ),
        ),
      ),
    );
  }
}
