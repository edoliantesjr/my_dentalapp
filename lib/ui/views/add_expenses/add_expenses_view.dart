import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../constants/font_name/font_name.dart';
import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_styles.dart';

class AddExpenseView extends StatelessWidget {
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Clinic Expenses'),
      ),
      bottomSheet: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
              color: Colors.grey.shade500,
              width: 1,
            )),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ]),
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total Expense Amount',
                      style: TextStyles.tsHeading5(),
                    ),
                    Text(
                      '99999'.toCurrency!,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                          fontFamily: FontNames.sfPro,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: double.maxFinite,
                color: Palettes.kcPurpleMain,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  'Save Expense',
                  style: TextStyles.tsButton1(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton.extended(
            onPressed: () {}, label: Text('Add Item')),
      ),
      body: Container(
        color: Colors.grey.shade50,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: ListView(
          children: [
            Row(
              children: [
                Text(
                  'List of Items',
                  style: TextStyles.tsButton2(),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Divider(
                    height: 2,
                    color: Palettes.kcPurpleMain,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              height: 200,
              child: Center(child: Text('No Items Added')),
            )
          ],
        ),
      ),
    );
  }
}
