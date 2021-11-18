import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_form_styles.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SetUpUserView extends StatefulWidget {
  SetUpUserView({Key? key}) : super(key: key);

  @override
  State<SetUpUserView> createState() => _SetUpUserViewState();
}

class _SetUpUserViewState extends State<SetUpUserView> {
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final positionController = TextEditingController();

  @override
  void dispose() {
    dateOfBirthController.dispose();
    genderController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SetupUserViewModel>.reactive(
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
                                  controller: firstNameController,
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
                                  controller: lastNameController,
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
                                GestureDetector(
                                  onTap: () => model
                                      .setBirthDateValue(dateOfBirthController),
                                  child: TextFormField(
                                    controller: dateOfBirthController,
                                    enabled: false,
                                    validator: (value) => model.validatorService
                                        .validateDate(value!),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        errorBorder: TextFormStyles.errorBorder,
                                        errorStyle: TextStyles.errorTextStyle,
                                        disabledBorder:
                                            TextFormStyles.normalBorder,
                                        hintText: 'MM/DD/YYYY',
                                        labelText: 'Date of Birth*',
                                        // disabledBorder: ,
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
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () =>
                                      model.setGenderValue(genderController),
                                  child: TextFormField(
                                    controller: genderController,
                                    validator: (value) => model.validatorService
                                        .validateGender(value!),
                                    textInputAction: TextInputAction.next,
                                    enabled: false,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        errorBorder: TextFormStyles.errorBorder,
                                        errorStyle: TextStyles.errorTextStyle,
                                        disabledBorder:
                                            TextFormStyles.normalBorder,
                                        hintText: 'Your Gender',
                                        labelText: 'Gender*',
                                        // disabledBorder: ,
                                        labelStyle: TextStyles.tsBody1(
                                            color: Palettes.kcNeutral1),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Palettes.kcBlueMain1,
                                        )),
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => model
                                      .setPositionValue(positionController),
                                  child: TextFormField(
                                    controller: positionController,
                                    enabled: false,
                                    validator: (value) => model.validatorService
                                        .validatePosition(value!),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                        errorBorder: TextFormStyles.errorBorder,
                                        errorStyle: TextStyles.errorTextStyle,
                                        disabledBorder:
                                            TextFormStyles.normalBorder,
                                        hintText:
                                            'Your Position in the company',
                                        labelText: 'Position*',
                                        // disabledBorder: ,
                                        labelStyle: TextStyles.tsBody1(
                                            color: Palettes.kcNeutral1),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Palettes.kcBlueMain1,
                                        )),
                                  ),
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