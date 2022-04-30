import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/patient_dental_chart/patient_dental_chart_view_model.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:dentalapp/ui/widgets/tooth/tooth_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class PatientDentalChartView extends StatelessWidget {
  final Patient patient;
  const PatientDentalChartView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientDentalChartViewModel>.reactive(
      viewModelBuilder: () => PatientDentalChartViewModel(),
      onModelReady: (model) => model.init(patient.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Dental Chart"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                ))
          ],
        ),
        body: ListView(
          children: [
            PatientCard(
              image: patient.image,
              name: patient.fullName,
              phone: patient.phoneNum,
              address: patient.address,
              age: '20',
              birthDate:
                  DateFormat.yMMMd().format(patient.birthDate.toDateTime()!),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Patient's Dental Chart",
                    style: TextStyles.tsHeading4(),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          children: [
                            SizedBox(height: 5),

                            //PEDIATRIC UPPER
                            GridView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 10,
                                      mainAxisExtent: 60,
                                      crossAxisSpacing: 1),
                              itemBuilder: (context, index) => ToothWidget(
                                isUpper: true,
                                hasRecord: model.hasHistory(
                                    model.toothIdFromA[index].toString()),
                                isSelected: model.isSelected(
                                    model.toothIdFromA[index].toString()),
                                onTap: () => model.addToSelectedTooth(
                                    model.toothIdFromA[index].toString()),
                                isCenterTooth: model.checkCenterTooth1(
                                    model.toothIdFromA[index]),
                                toothId: model.toothIdFromA[index],
                              ),
                            ),
                            SizedBox(height: 10),

                            //PEDIATRIC LOWER
                            GridView.builder(
                              itemCount: 10,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 1,
                                      crossAxisCount: 10,
                                      mainAxisExtent: 60),
                              itemBuilder: (context, index) => ToothWidget(
                                isSelected: model.isSelected(
                                    model.toothIdFromT[index].toString()),
                                hasRecord: model.hasHistory(
                                    model.toothIdFromT[index].toString()),
                                onTap: () => model.addToSelectedTooth(
                                    model.toothIdFromT[index].toString()),
                                isUpper: false,
                                isCenterTooth: model.checkCenterTooth1(
                                    model.toothIdFromT[index]),
                                toothId: model.toothIdFromT[index],
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  //second row of teeth chart
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Column(
                      children: [
                        Text('Upper', style: TextStyles.tsHeading5()),
                        SizedBox(height: 5),

                        //ADULT UPPER
                        Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: GridView.builder(
                            itemCount: 16,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              mainAxisExtent: 60,
                            ),
                            itemBuilder: (context, index) => ToothWidget(
                              onTap: () => model.addToSelectedTooth(
                                  model.toothIdFrom1[index].toString()),
                              isSelected: model.isSelected(
                                  model.toothIdFrom1[index].toString()),
                              hasRecord: model.hasHistory(
                                  model.toothIdFrom1[index].toString()),
                              isUpper: true,
                              toothId: model.toothIdFrom1[index].toString(),
                              isCenterTooth: model.checkCenterTooth2(
                                  model.toothIdFrom1[index].toString()),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        //ADULT LOWER
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Text('Lower', style: TextStyles.tsHeading5()),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: GridView.builder(
                            itemCount: 16,
                            shrinkWrap: true,
                            primary: false,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              mainAxisExtent: 60,
                            ),
                            itemBuilder: (context, index) => ToothWidget(
                              onTap: () => model.addToSelectedTooth(
                                  model.toothIdFrom32[index].toString()),
                              hasRecord: model.hasHistory(
                                  model.toothIdFrom32[index].toString()),
                              isSelected: model.isSelected(
                                  model.toothIdFrom32[index].toString()),
                              isUpper: false,
                              isCenterTooth: model.checkCenterTooth2(
                                  model.toothIdFrom32[index].toString()),
                              toothId: model.toothIdFrom32[index].toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                model.addToothCondition(patientId: patient.id);
                model.addDentalNotes(patientId: patient.id);
                // model.getDentalNotes(patientId: patient.id);
              },
              icon: Icon(Icons.note),
              label: Text('View Dental Notes'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                model.getDentalCondition(patientId: patient.id);
              },
              icon: Icon(Icons.note),
              label: Text('View Dental Condition'),
            ),
          ],
        ),
      ),
    );
  }
}

/// adult tooth chart
//Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 10),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 10),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 119),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 119),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 100),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 100),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 80),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 80),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 60),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 60),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 35),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 35),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 20),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 20),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     //lower
//                     Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 20),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 20),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                             color: Colors.grey.shade500,
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 35),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 35),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 60),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 60),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 80),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 80),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 100),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 100),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 119),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 119),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(left: 10),
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(right: 10),
//                           height: 35,
//                           width: 35,
//                           padding: EdgeInsets.all(3),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black, width: 0.8),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/icons/tooth.svg',
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
