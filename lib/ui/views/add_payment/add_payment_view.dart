import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:dentalapp/ui/widgets/payment_dental_note_card/payment_dental_note_card.dart';
import 'package:dentalapp/ui/widgets/payment_medicine_card/payment_medicine_card.dart';
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
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Payment'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
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
                  offset: const Offset(0, 2), // changes position of shadow
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
                        'Total Payment',
                        style: TextStyles.tsHeading5(),
                      ),
                      Text(
                        '${model.totalAmountFinal}'.toCurrency!,
                        style: const TextStyle(
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
                onTap: () => model.savePaymentInfo(
                  paymentType: model.paymentTypeTxtController.text,
                  dentist: model.dentistTxtController.text,
                  totalAmountFinal: model.totalAmountFinal,
                  patientId: patient.id,
                  dentalNoteSubTotal: model.dentalNoteSubTotal,
                  medicineSubTotal: model.medicineSubTotal,
                  selectedMedicine: model.selectedMedicines,
                  selectedNotes: model.selectedDentalNotes,
                  patient_name: patient.fullName,
                ),
                child: Container(
                  height: double.maxFinite,
                  color: Palettes.kcPurpleMain,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Save Payment',
                    style: TextStyles.tsButton1(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: model.addPaymentFormKey,
          child: Scrollbar(
            radius: const Radius.circular(40),
            thickness: 8,
            interactive: true,
            child: SafeArea(
              bottom: true,
              top: false,
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: PatientCard(
                      image: patient.image,
                      name: patient.fullName,
                      phone: patient.phoneNum,
                      address: patient.address,
                      dateCreated: patient.dateCreated!,
                      birthDate: DateFormat.yMMMd()
                          .format(patient.birthDate.toDateTime()!),
                      age: AgeCalculator.age(patient.birthDate.toDateTime()!,
                              today: DateTime.now())
                          .years
                          .toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
                            const SizedBox(width: 4),
                            const Expanded(
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
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => model.showSelectPaymentType(),
                          child: TextFormField(
                            controller: model.paymentTypeTxtController,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (value) => model.validatorService
                                .validatePaymentType(value!),
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Payment Method',
                                labelText: 'Payment Type*',
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () => model.selectDate(),
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
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: model.remarksTxtController,
                          textInputAction: TextInputAction.done,
                          maxLines: 3,
                          maxLength: 80,
                          decoration: const InputDecoration(
                            hintText: 'Type here',
                            labelText: 'Remark & Notes (Optional)',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                                fontSize: 20, color: Palettes.kcNeutral1),
                            enabledBorder: TextBorderStyles.normalBorder,
                            focusedBorder: TextBorderStyles.focusedBorder,
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notes or Procedures',
                              style: TextStyles.tsButton1(),
                            ),
                            ActionChip(
                              label: const Text(
                                  0 <= 0 ? 'Select Dental Note' : 'Add more'),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                              labelStyle:
                                  TextStyles.tsBody2(color: Colors.white),
                              backgroundColor: Palettes.kcBlueMain1,
                              tooltip: 'Select Dental Note',
                              onPressed: () =>
                                  model.selectDentalNote(patient.id),
                            )
                          ],
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: model.selectedDentalNotes.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) =>
                                      PaymentDentalNoteCard(
                                          dentalNote:
                                              model.selectedDentalNotes[index],
                                          patientID: patient.id),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: model.selectedDentalNotes.length)
                              : const SizedBox(
                                  height: 100,
                                  child:
                                      Center(child: Text('No Notes Selected'))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Medicine',
                              style: TextStyles.tsButton1(),
                            ),
                            ActionChip(
                              label:
                                  const Text(0 <= 0 ? 'Select Medicine' : 'Add more'),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                              labelStyle:
                                  TextStyles.tsBody2(color: Colors.white),
                              backgroundColor: Palettes.kcBlueMain1,
                              tooltip: 'Select Medicine',
                              onPressed: () =>
                                  model.selectMedicines(patient.id),
                            ),
                          ],
                        ),
                        model.selectedMedicines.isNotEmpty
                            ? Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) =>
                                        PaymentMedicineCard(
                                            medicine:
                                                model.selectedMedicines[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 4),
                                    itemCount: model.selectedMedicines.length),
                              )
                            : Container(
                                height: 50,
                                width: double.maxFinite,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Text('No Medicine Selected'),
                              ),
                        const SizedBox(height: 6),
                        Container(
                          height: 8,
                          color: Colors.grey.shade200,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          color: Colors.grey.shade50,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Dental Note Sub Total:',
                                      style: TextStyles.tsHeading5(),
                                    ),
                                  ),
                                  Text(
                                    '${model.dentalNoteSubTotal.toString().toCurrency}',
                                    style: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Medicine Sub Total:',
                                      style: TextStyles.tsHeading5(),
                                    ),
                                  ),
                                  Text(
                                    '${model.medicineSubTotal}'.toCurrency!,
                                    style: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Total Amount:',
                                        style: TextStyles.tsHeading5(),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        enabled:
                                            model.dentalNoteSubTotal == 0 &&
                                                model.medicineSubTotal == 0,
                                        controller:
                                            model.totalAmountTxtController,
                                        onChanged: (value) =>
                                            model.onTotalAmountTextEdit(value),
                                        validator: (value) => model
                                            .validatorService
                                            .validatePrice(value!),
                                        enableInteractiveSelection: false,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          fillColor: Colors.white,
                                          filled: true,
                                          constraints: const BoxConstraints(
                                              maxHeight: 60, minHeight: 60),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                  color:
                                                      Colors.deepOrangeAccent)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: const BorderSide(
                                                color: Colors.deepOrangeAccent,
                                                width: 2),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2),
                                          ),
                                          errorStyle: const TextStyle(
                                              color: Colors.red, height: 0),
                                          hintText: 'Set Amount',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 8,
                          color: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
