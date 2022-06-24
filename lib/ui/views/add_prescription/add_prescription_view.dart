import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/add_prescription/add_prescription_view_model.dart';
import 'package:dentalapp/ui/widgets/prescription_item_card/prescription_item_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class AddPrescriptionView extends StatelessWidget {
  final Patient patient;
  const AddPrescriptionView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPrescriptionViewModel>.reactive(
      viewModelBuilder: () => AddPrescriptionViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Prescription'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.addPrescriptionItem(),
            label: const Text('Add Prescription Item')),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => model.savePrescription(patient.id),
                      child: const Text('Save'))),
            ],
          )
        ],
        body: Form(
          key: model.addPrescriptionFormKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            children: [
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
                      labelText: 'Prescription date*',
                      labelStyle:
                          TextStyles.tsBody1(color: Palettes.kcNeutral1),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color: Palettes.kcBlueMain1,
                      )),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'List of Direction',
                    style: TextStyles.tsButton2(),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Divider(
                      height: 2,
                      color: Palettes.kcPurpleMain,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              model.prescriptionItem.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => PrescriptionItemCard(
                        prescriptionItem: model.prescriptionItem[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(height: 5),
                      itemCount: model.prescriptionItem.length,
                    )
                  : Container(
                      color: Colors.grey.shade200,
                      height: 200,
                      child: const Center(child: Text('No Directions')),
                    ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
