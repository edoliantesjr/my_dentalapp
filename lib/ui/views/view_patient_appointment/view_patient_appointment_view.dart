import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/ui/views/view_patient_appointment/view_patient_appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../models/patient_model/patient_model.dart';
import '../../widgets/appointment_card/appointment_card.dart';

class ViewPatientAppointment extends StatelessWidget {
  final Patient patient;
  const ViewPatientAppointment({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewPatientAppointmentViewModel>.reactive(
      viewModelBuilder: () => ViewPatientAppointmentViewModel(),
      onModelReady: (model) {
        model.init(patientId: patient.id);
        model.listenToAppointmentChanges(patientId: patient.id);
      },
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text("Patient's Appointments"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.addAppointment(patient),
            label: const Text('Add Appointment')),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'List Of Patient Appointments',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Divider(
                    height: 2,
                    thickness: 2,
                    color: Palettes.kcDarkerBlueMain1,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            model.patientListOfAppointments.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, i) => AppointmentCard(
                          key: ObjectKey(model.patientListOfAppointments[i]),
                          onPatientTap: () {},
                          appointment: model.patientListOfAppointments[i],
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                    itemCount: model.patientListOfAppointments.length)
                : const SizedBox(
                    height: 500,
                    child: Center(
                        child: Text('No Appointments added on this patient ')),
                  ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
