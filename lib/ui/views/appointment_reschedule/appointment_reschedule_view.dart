import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_border_styles.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'appointment_reschedule_view_model.dart';

class AppointmentRescheduleView extends StatelessWidget {
  final AppointmentModel appointment;
  const AppointmentRescheduleView({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentRescheduleViewModel>.reactive(
        viewModelBuilder: () => AppointmentRescheduleViewModel(),
        onModelReady: (model) => model.init(appointment),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'ReSchedule Appointment',
                  style: TextStyles.tsHeading3(color: Colors.white),
                ),
              ),
              persistentFooterButtons: [
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: model.navigationService.pop,
                      child: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade700),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (model.createAppointmentFormKey.currentState!
                                  .validate()) {
                                if (model.selectedProcedures.isNotEmpty) {
                                  model.reSchedAppointment(
                                    appointment: AppointmentModel(
                                      appointment_id:
                                          appointment.appointment_id,
                                      patient: appointment.patient,
                                      date: model.selectedAppointmentDate
                                          .toString(),
                                      startTime:
                                          model.selectedStartTime.toString(),
                                      endTime: model.selectedEndTime.toString(),
                                      dentist: model.dentistTxtController.text,
                                      procedures: model.selectedProcedures,
                                      appointment_status:
                                          AppointmentStatus.Approved.name,
                                    ),
                                    popTime: 1,
                                    patientId: appointment.patient.id,
                                  );
                                } else {
                                  model.snackBarService.showSnackBar(
                                      message: 'No Procedures Selected',
                                      title: 'Warning');
                                }
                              }
                            },
                            child: const Text('Save'))),
                  ],
                )
              ],
              body: Form(
                key: model.createAppointmentFormKey,
                child: SafeArea(
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    children: [
                      const Divider(),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Patient Info',
                            style: TextStyles.tsHeading3(),
                            textAlign: TextAlign.center,
                          )),
                      PatientCard(
                        image: appointment.patient.image,
                        name: appointment.patient.fullName,
                        phone: appointment.patient.phoneNum,
                        address: appointment.patient.address,
                        birthDate: DateFormat.yMMMd().format(
                            appointment.patient.birthDate.toDateTime()!),
                        age: AgeCalculator.age(
                                appointment.patient.birthDate.toDateTime()!,
                                today: DateTime.now())
                            .years
                            .toString(),
                        dateCreated: appointment.patient.dateCreated!,
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () => model.selectDate(),
                              child: TextFormField(
                                controller: model.dateTxtController,
                                enabled: false,
                                validator: (value) =>
                                    model.validatorService.validateDate(value!),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                    errorBorder: TextBorderStyles.errorBorder,
                                    errorStyle: TextStyles.errorTextStyle,
                                    disabledBorder:
                                        TextBorderStyles.normalBorder,
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
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Procedure*',
                                ),
                                ActionChip(
                                  label: Text(model.selectedProcedures.isEmpty
                                      ? 'Select'
                                      : 'Add more'),
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  labelStyle:
                                      TextStyles.tsBody2(color: Colors.white),
                                  backgroundColor: Palettes.kcBlueMain1,
                                  tooltip: 'Select Procedure',
                                  onPressed: () =>
                                      model.openProcedureFullScreenModal(),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: model.selectedProcedures.isNotEmpty
                                  ? true
                                  : false,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Palettes.kcBlueMain1, width: 1)),
                                padding: const EdgeInsets.all(4),
                                child: Wrap(
                                  spacing: 4,
                                  children: model.selectedProcedures
                                      .map((e) => InputChip(
                                            label: Text(e.procedureName),
                                            backgroundColor:
                                                Colors.deepPurple.shade50,
                                            labelStyle: TextStyles.tsBody2(
                                                color: Colors.deepPurple),
                                            labelPadding:
                                                const EdgeInsets.all(1),
                                            onDeleted: () => model
                                                .deleteSelectedProcedure(e),
                                            deleteIcon: CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Colors.red.shade700,
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 16,
                                                )),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => model.selectStartTime(),
                              child: TextFormField(
                                controller: model.startTimeTxtController,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateStartTime(value!),
                                decoration: InputDecoration(
                                  hintText: 'Set Start Time',
                                  labelText: 'Start Time*',
                                  labelStyle: TextStyles.tsBody1(
                                      color: Palettes.kcNeutral1),
                                  errorBorder: TextBorderStyles.errorBorder,
                                  errorStyle: TextStyles.errorTextStyle,
                                  disabledBorder: TextBorderStyles.normalBorder,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => model.selectEndTime(),
                              child: TextFormField(
                                controller: model.endTimeTxtController,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateEndTime(value!),
                                decoration: InputDecoration(
                                  hintText: 'Set End Time',
                                  labelText: 'End Time*',
                                  labelStyle: TextStyles.tsBody1(
                                      color: Palettes.kcNeutral1),
                                  errorBorder: TextBorderStyles.errorBorder,
                                  errorStyle: TextStyles.errorTextStyle,
                                  disabledBorder: TextBorderStyles.normalBorder,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => model.openDentistModal(),
                              child: TextFormField(
                                controller: model.dentistTxtController,
                                textInputAction: TextInputAction.next,
                                enabled: false,
                                validator: (value) => model.validatorService
                                    .validateDentist(value!),
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                    errorBorder: TextBorderStyles.errorBorder,
                                    errorStyle: TextStyles.errorTextStyle,
                                    disabledBorder:
                                        TextBorderStyles.normalBorder,
                                    hintText: 'Select Dentist',
                                    labelText: 'Dentist*',
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
                            const SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
