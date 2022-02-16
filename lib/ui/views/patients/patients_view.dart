import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/patients/patients_view_model.dart';
import 'package:dentalapp/ui/views/select_patient/select_patient_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientsViewModel>.reactive(
      onModelReady: (model) => model.getPatientList(),
      viewModelBuilder: () => PatientsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dental Patients',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 15),
          physics: BouncingScrollPhysics(),
          children: [
            //  Todo: design code for patients view
            Container(
              height: 10,
              color: Colors.grey.shade500,
            ),
            model.patientList.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) => SelectPatientCard(
                      image: model.patientList[index].image,
                      name: model.patientList[index].fullName,
                      phone: model.patientList[index].phoneNum,
                      address: model.patientList[index].address,
                      birthDate: model.patientList[index].birthDate,
                    ),
                    separatorBuilder: (context, index) => Container(
                      height: 10,
                      color: Colors.grey.shade500,
                    ),
                    itemCount: model.patientList.length,
                  )
                : Text('Loading Patients'),
            Container(
              height: 10,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
