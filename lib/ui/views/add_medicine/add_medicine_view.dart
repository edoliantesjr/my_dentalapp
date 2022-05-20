import 'dart:io';

import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_border_styles.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/add_medicine/add_medicine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class AddMedicineView extends StatefulWidget {
  const AddMedicineView({Key? key}) : super(key: key);

  @override
  State<AddMedicineView> createState() => _AddMedicineViewState();
}

class _AddMedicineViewState extends State<AddMedicineView> {
  final addMedicineFormKey = GlobalKey<FormState>();
  final medicineName = TextEditingController();
  final brandName = TextEditingController();
  final medicinePrice = TextEditingController();

  @override
  void dispose() {
    medicineName.dispose();
    brandName.dispose();
    medicinePrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMedicineViewModel>.reactive(
      viewModelBuilder: () => AddMedicineViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Medicine'),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (addMedicineFormKey.currentState!.validate()) {
                          model.addMedicine(
                              medicineName: medicineName.text,
                              brandName: brandName.text,
                              price: medicinePrice.text);
                        }
                      },
                      child: Text('Save'))),
            ],
          )
        ],
        body: Form(
          key: addMedicineFormKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      border: Border.all(color: Colors.grey.shade400, width: 4),
                    ),
                    child: model.selectedImage == null
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: SvgPicture.asset(
                                'assets/icons/Camera.svg',
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Image.file(
                            File(model.selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () => model.selectImage(),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    child: Text(
                      'Add Picture',
                      style: TextStyles.tsBody3(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: medicineName,
                validator: (value) =>
                    model.validatorService.validateMedicineName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Medicine Name',
                  labelText: 'Generic Name*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: brandName,
                validator: (value) =>
                    model.validatorService.validateBrandName(value!),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Brand Name',
                  labelText: 'Brand Name*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: medicinePrice,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    model.validatorService.validatePrice(value!),
                keyboardType: TextInputType.number,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  errorBorder: TextBorderStyles.errorBorder,
                  errorStyle: TextStyles.errorTextStyle,
                  hintText: 'Type Amount',
                  labelText: 'Amount Per Tab/bottle*',
                  // disabledBorder: ,
                  labelStyle: TextStyles.tsBody1(color: Palettes.kcNeutral1),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
