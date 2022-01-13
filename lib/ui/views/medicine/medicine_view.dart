import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MedicineView extends StatelessWidget {
  const MedicineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Medicine List',
          style: TextStyles.tsHeading3(color: Colors.white),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Text('+ Medicine'),
        onPressed: () {},
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
