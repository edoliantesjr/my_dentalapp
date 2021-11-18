import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SelectionDate extends StatelessWidget {
  const SelectionDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionDateViewModel>.reactive(
      viewModelBuilder: () => SelectionDateViewModel(),
      builder: (context, model, child) => Container(
        height: 280,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Palettes.kcHintColor))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: Get.back,
                    child: Text(
                      'Cancel',
                      style: TextStyles.tsButton1(color: Colors.red[700]),
                    ),
                  ),
                  TextButton(
                    onPressed: model.setReturnDate,
                    child: Text(
                      'Done',
                      style: TextStyles.tsButton1(color: Palettes.kcBlueMain1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (DateTime dateTime) =>
                  model.setSelectedDate(dateTime),
            ))
          ],
        ),
      ),
    );
  }
}
