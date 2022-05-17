import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../models/patient_model/patient_model.dart';
import 'add_payment_view_model.dart';

class AddPaymentView extends StatelessWidget {
  final Patient patient;
  const AddPaymentView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPaymentViewModel>.reactive(
      viewModelBuilder: () => AddPaymentViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Add Payment'),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () {
                  // todo
                },
                child: Text('Save')),
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: PatientCard(
                image: patient.image,
                name: patient.fullName,
                phone: patient.phoneNum,
                address: patient.address,
                dateCreated: patient.dateCreated!,
                birthDate:
                    DateFormat.yMMMd().format(patient.birthDate.toDateTime()!),
                age: AgeCalculator.age(patient.birthDate.toDateTime()!,
                        today: DateTime.now())
                    .years
                    .toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Payment Info',
                        style: TextStyles.tsHeading4(),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Divider(
                          color: Palettes.kcPurpleMain,
                          height: 3,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => model.showSelectDentist(),
                    child: TextFormField(
                      controller: model.dentistTxtController,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      validator: (value) =>
                          model.validatorService.validateDentist(value!),
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          errorBorder: TextBorderStyles.errorBorder,
                          errorStyle: TextStyles.errorTextStyle,
                          disabledBorder: TextBorderStyles.normalBorder,
                          hintText: 'Select Dentist',
                          labelText: 'Dentist In-Charge*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Palettes.kcBlueMain1,
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => model.showSelectPaymentType(),
                    child: TextFormField(
                      controller: model.paymentTypeTxtController,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      validator: (value) =>
                          model.validatorService.validatePaymentType(value!),
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          errorBorder: TextBorderStyles.errorBorder,
                          errorStyle: TextStyles.errorTextStyle,
                          disabledBorder: TextBorderStyles.normalBorder,
                          hintText: 'Payment Method',
                          labelText: 'Payment Type*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Palettes.kcBlueMain1,
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  GestureDetector(
                    // onTap: () =>
                    //     model.openDentistModal(dentistTxtController),
                    child: TextFormField(
                      controller: model.dateTxtController,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      validator: (value) =>
                          model.validatorService.validateDate(value!),
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          errorBorder: TextBorderStyles.errorBorder,
                          errorStyle: TextStyles.errorTextStyle,
                          disabledBorder: TextBorderStyles.normalBorder,
                          hintText: 'Select Date',
                          labelText: 'Date of Payment*',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Palettes.kcBlueMain1,
                          )),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notes or Procedures',
                        style: TextStyles.tsButton1(),
                      ),
                      ActionChip(
                        label: Text(0 <= 0 ? 'Select Dental Note' : 'Add more'),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        labelStyle: TextStyles.tsBody2(color: Colors.white),
                        backgroundColor: Palettes.kcBlueMain1,
                        tooltip: 'Select Dental Note',
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 100,
                    width: double.maxFinite,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: Text('No Notes Selected'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Medicine',
                        style: TextStyles.tsButton1(),
                      ),
                      ActionChip(
                        label: Text(0 <= 0 ? 'Select Medicine' : 'Add more'),
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        labelStyle: TextStyles.tsBody2(color: Colors.white),
                        backgroundColor: Palettes.kcBlueMain1,
                        tooltip: 'Select Medicine',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: Text('No Medicine Selected'),
                  ),
                  TextFormField(
                    // controller: dentistTxtController,
                    textInputAction: TextInputAction.next,
                    // validator: (value) => model.validatorService
                    //     .validateDentist(value!),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      errorBorder: TextBorderStyles.errorBorder,
                      errorStyle: TextStyles.errorTextStyle,
                      hintText: 'Net Amount',
                      labelText: 'Total Amount',
                      labelStyle:
                          TextStyles.tsBody1(color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
