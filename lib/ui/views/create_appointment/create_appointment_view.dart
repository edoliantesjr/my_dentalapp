import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_border_styles.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/create_appointment/create_appointment_view_model.dart';
import 'package:dentalapp/ui/views/select_patient/select_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class CreateAppointmentView extends StatefulWidget {
  final Patient patient;
  const CreateAppointmentView({required this.patient, Key? key})
      : super(key: key);

  @override
  State<CreateAppointmentView> createState() => _CreateAppointmentViewState();
}

class _CreateAppointmentViewState extends State<CreateAppointmentView> {
  final createAppointmentFormKey = GlobalKey<FormState>();

  final dateTxtController = TextEditingController();
  final startTimeTxtController = TextEditingController();
  final endTimeTxtController = TextEditingController();
  final dentistTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();

  @override
  void dispose() {
    dateTxtController.dispose();
    startTimeTxtController.dispose();
    endTimeTxtController.dispose();
    dentistTxtController.dispose();
    remarksTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAppointmentViewModel>.reactive(
        viewModelBuilder: () => CreateAppointmentViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Add Schedule',
                  style: TextStyles.tsHeading3(color: Colors.white),
                ),
              ),
              persistentFooterButtons: [
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: model.navigationService.pop,
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Save'))),
                  ],
                )
              ],
              body: Form(
                key: createAppointmentFormKey,
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    children: [
                      Divider(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Patient Info',
                            style: TextStyles.tsHeading3(),
                            textAlign: TextAlign.center,
                          )),
                      SelectPatientCard(
                        image: widget.patient.image,
                        name: widget.patient.fullName,
                        phone: widget.patient.phoneNum,
                        address: widget.patient.address,
                        birthDate: widget.patient.birthDate,
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => model.selectDate(dateTxtController),
                        child: TextFormField(
                          controller: dateTxtController,
                          enabled: false,
                          validator: (value) =>
                              model.validatorService.validateDate(value!),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorBorder: TextBorderStyles.errorBorder,
                              errorStyle: TextStyles.errorTextStyle,
                              disabledBorder: TextBorderStyles.normalBorder,
                              hintText: 'MM/DD/YYYY',
                              labelText: 'Appointment Date*',
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
                        onTap: () {},
                        child: TextFormField(
                          controller: dentistTxtController,
                          // validator: (value) => model.validatorService
                          //     .validateGender(value!),
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorBorder: TextBorderStyles.errorBorder,
                              errorStyle: TextStyles.errorTextStyle,
                              disabledBorder: TextBorderStyles.normalBorder,
                              hintText: 'Select Procedures/Services',
                              labelText: 'Procedure*',
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
                        onTap: () =>
                            model.selectStartTime(startTimeTxtController),
                        child: TextFormField(
                          controller: startTimeTxtController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Set Start Time',
                            labelText: 'Start Time*',
                            labelStyle:
                                TextStyles.tsBody1(color: Palettes.kcNeutral1),
                            errorBorder: TextBorderStyles.errorBorder,
                            errorStyle: TextStyles.errorTextStyle,
                            disabledBorder: TextBorderStyles.normalBorder,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: TextFormField(
                          controller: endTimeTxtController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Set End Time',
                            labelText: 'End Time*',
                            labelStyle:
                                TextStyles.tsBody1(color: Palettes.kcNeutral1),
                            errorBorder: TextBorderStyles.errorBorder,
                            errorStyle: TextStyles.errorTextStyle,
                            disabledBorder: TextBorderStyles.normalBorder,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: TextFormField(
                          controller: dentistTxtController,
                          // validator: (value) => model.validatorService
                          //     .validateGender(value!),
                          textInputAction: TextInputAction.next,
                          enabled: false,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              errorBorder: TextBorderStyles.errorBorder,
                              errorStyle: TextStyles.errorTextStyle,
                              disabledBorder: TextBorderStyles.normalBorder,
                              hintText: 'Select Dentist',
                              labelText: 'Dentist*',
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
                      TextFormField(
                        controller: remarksTxtController,
                        decoration: InputDecoration(
                          hintText: 'Type here',
                          labelText: 'Remarks',
                          labelStyle:
                              TextStyles.tsBody1(color: Palettes.kcNeutral1),
                          enabledBorder: TextBorderStyles.normalBorder,
                          focusedBorder: TextBorderStyles.focusedBorder,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
