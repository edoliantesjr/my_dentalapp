import 'package:dentalapp/ui/views/prescription_view/prescription_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/patient_model/patient_model.dart';

class PrescriptionView extends StatelessWidget {
  final Patient patient;
  const PrescriptionView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PrescriptionViewModel>.reactive(
      viewModelBuilder: () => PrescriptionViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Prescription"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.goToAddPrescription(patient),
            label: Text('Add Prescription')),
      ),
    );
  }
}
