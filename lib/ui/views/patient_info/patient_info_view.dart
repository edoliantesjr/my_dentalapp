import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/views/patient_info/patient_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../models/patient_model/patient_model.dart';
import '../patient_drawer/patient_drawer.dart';

class PatientInfoView extends StatelessWidget {
  final Patient patient;
  const PatientInfoView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientInfoViewModel>.reactive(
        viewModelBuilder: () => PatientInfoViewModel(),
        onModelReady: (model) {
          model.init(patient: patient);
          model.computeAge(birthDate: patient.birthDate);
        },
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.grey.shade50,
              drawer: PatientDrawerView(
                patient: model.patient ?? patient,
              ),
              appBar: AppBar(
                titleSpacing: 0,
                actions: [
                  IconButton(
                    onPressed: () => model.navigationService
                        .pushNamed(Routes.NotificationView),
                    icon: Icon(
                      Icons.notifications,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
                title: Text(
                  'Patient Info',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
                centerTitle: true,
              ),
              body: Scrollbar(
                thickness: 6,
                controller: model.scrollController,
                child: ListView(
                  controller: model.scrollController,
                  children: [
                    Container(
                      height: 200,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Palettes.kcBlueMain1,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () => model.updatePatientImage(),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100,
                                        border: Border.all(
                                            color: Colors.white, width: 3)),
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Palettes.kcBlueMain1,
                                              width: 2)),
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 3)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: CachedNetworkImage(
                                            imageUrl: model.patient?.image,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 20,
                                      bottom: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 25,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '${model.patient?.firstName} ${model.patient?.lastName}, ${model.age}',
                            style: TextStyles.tsHeading3(),
                          ),
                          Text(
                            'Patient Name',
                            style:
                                TextStyles.tsBody2(color: Colors.grey.shade900),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => model
                                      .goToUpdatePatient(patient: model.patient!),
                                  label: Text(
                                    'Edit your patient info',
                                    style:
                                        TextStyles.tsBody3(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.edit,
                                    size: 16,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Palettes.kcBlueDark),
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Call.svg',
                                          height: 19,
                                          width: 19,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          model.patient!.phoneNum,
                                          style: TextStyles.tsBody2(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Location.svg',
                                          height: 21,
                                          width: 21,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 9),
                                        Text(
                                          model.patient!.address,
                                          style: TextStyles.tsBody2(
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/Calendar.svg',
                                          height: 19,
                                          width: 19,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          model.patient!.birthDate
                                              .toDateTime()!
                                              .toStringDateFormat(),
                                          style: TextStyles.tsBody2(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          model.patient!.gender != 'Female'
                                              ? Icons.male
                                              : Icons.female,
                                          size: 22,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          patient.gender,
                                          style: TextStyles.tsBody2(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Emerg. Contact Name:'),
                                  Text(model.patient!.emergencyContactName ??
                                      'None'),
                                  SizedBox(height: 8),
                                  Text('Emerg. Contact #:'),
                                  Text(model.patient!.emergencyContactNumber ??
                                      'None'),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          // SizedBox(
                          //   height: 30,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         'Photos',
                          //         style: TextStyles.tsHeading4(),
                          //       ),
                          //       InkWell(
                          //         onTap: () {},
                          //         child: SizedBox(
                          //           width: 100,
                          //           child: Text(
                          //             'See All',
                          //             textAlign: TextAlign.end,
                          //             style: TextStyle(
                          //               color: Colors.blue,
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 5),
                          // Container(
                          //   height: 130,
                          //   color: Colors.grey.shade200,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Text('No Photos'),
                          //       TextButton(
                          //         onPressed: () {},
                          //         child: Text('Add Now'),
                          //         style: TextButton.styleFrom(
                          //             textStyle: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w500,
                          //         )),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(height: 8),
                          Divider(),
                          // Card(
                          //   shadowColor: Colors.grey.shade500,
                          //   child: ListTile(
                          //     onTap: () => model.goToMedicalHistoryView(
                          //         patientId: patient.id),
                          //     leading: Icon(
                          //       Icons.history,
                          //       color: Colors.black,
                          //     ),
                          //     title: Text(
                          //       'Medical History',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold, fontSize: 17),
                          //     ),
                          //     trailing: Icon(
                          //       Icons.arrow_right,
                          //       size: 35,
                          //       color: Colors.blue,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 4),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () =>
                                  model.goToMedicalChart(patient: patient),
                              leading: SvgPicture.asset(
                                'assets/icons/Filter.svg',
                                color: Colors.black,
                              ),
                              title: Text(
                                'Dental Chart',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () =>
                                  model.goToPrescriptionView(patient: patient),
                              leading: SvgPicture.asset(
                                'assets/icons/Pills.svg',
                                color: Colors.black,
                              ),
                              title: Text(
                                'Prescription',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () => model.goToViewPatientAppointmentView(
                                  patient: patient),
                              leading: SvgPicture.asset(
                                'assets/icons/Calendar.svg',
                                color: Colors.black,
                              ),
                              title: Text(
                                'My Appointments',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () => model.goToViewPatientPaymentsView(
                                  patient: patient),
                              leading: Icon(
                                Icons.money,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Payments',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () => model.goToDentalCertificateView(
                                  patient: patient),
                              leading: Icon(
                                Icons.receipt,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Dental Certificate',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
