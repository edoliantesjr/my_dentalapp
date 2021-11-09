import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'setup_user_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'firstName'),
  FormTextField(name: 'lastName'),
  FormDropdownField(name: 'gender', items: [
    StaticDropdownItem(title: 'Male', value: 'Male'),
    StaticDropdownItem(title: 'Female', value: 'Female'),
  ])
])
class SetUpUserView extends StatelessWidget with $SetUpUserView {
  SetUpUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupUserViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      viewModelBuilder: () => SetupUserViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          persistentFooterButtons: [
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (model.setupFormKey.currentState!.validate()) {}
                },
                child: Text('Save'),
              ),
            )
          ],
          body: SafeArea(
            child: Container(
              color: Palettes.kcBlueMain1,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Palettes.kcLightGreyAccentColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/Camera.svg',
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //Form for Setup Info
                    Expanded(
                      child: Form(
                          key: model.setupFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                TextFormField(
                                  validator: (value) => model.validatorService
                                      .validateFirstName(value!),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Your first name',
                                    labelText: 'First Name*',
                                    labelStyle: TextStyles.tsBody1(
                                        color: Palettes.kcNeutral1),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) => model.validatorService
                                      .validateLastName(value!),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your last name',
                                    labelText: 'Last Name*',
                                    labelStyle: TextStyles.tsBody1(
                                        color: Palettes.kcNeutral1),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) => model.validatorService
                                      .validateDate(value!),
                                  textInputAction: TextInputAction.next,
                                  onTap: () => model.selectDateOfBirth(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now()),
                                  controller: model.dateOfBirth,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                      hintText: 'MM/DD/YYYY',
                                      labelText: 'Date of Birth*',
                                      labelStyle: TextStyles.tsBody1(
                                          color: Palettes.kcNeutral1),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      suffixIcon: SvgPicture.asset(
                                        'assets/icons/Calendar.svg',
                                        color: Palettes.kcBlueMain1,
                                        fit: BoxFit.scaleDown,
                                      )),
                                ),
                                SizedBox(height: 10),
                                DropdownButtonFormField<String>(
                                  value: model.genderValue,
                                  validator: (value) => model.validatorService
                                      .validateGender(value ?? ''),
                                  iconEnabledColor: Palettes.kcBlueMain1,
                                  elevation: 1,
                                  decoration: InputDecoration(
                                    hintText: 'Your Gender',
                                    labelText: 'Gender*',
                                    labelStyle: TextStyles.tsBody1(
                                        color: Palettes.kcNeutral1),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  onChanged: (value) => model.setGender(value!),
                                  items: GenderValueToTitleMap.keys
                                      .map((value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                              GenderValueToTitleMap[value]!)))
                                      .toList(),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Setup User Information!',
          style: TextStyles.tsHeading2(),
        ),
      ],
    );
  }
}
