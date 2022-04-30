import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/patient_info/patient_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class PatientInfoView extends StatelessWidget {
  final Patient patient;
  const PatientInfoView({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientInfoViewModel>.reactive(
        viewModelBuilder: () => PatientInfoViewModel(),
        onModelReady: (model) {
          model.computeAge(birthDate: patient.birthDate);
        },
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.grey.shade50,
              appBar: AppBar(
                titleSpacing: 0,
                title: Text(
                  'Patient Info',
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
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
                            child: Container(
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
                                        color: Palettes.kcBlueMain1, width: 2)),
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: CachedNetworkImage(
                                      imageUrl: patient.image,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
                            '${patient.firstName} ${patient.lastName}, ${model.age}',
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
                    SizedBox(height: 10),
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
                                  onPressed: () =>
                                      model.callPatient(patient.phoneNum),
                                  label: Text(
                                    'Call',
                                    style:
                                        TextStyles.tsBody3(color: Colors.white),
                                  ),
                                  icon: Icon(
                                    Icons.phone,
                                    size: 16,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Palettes.kcBlueDark),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                  child: ElevatedButton.icon(
                                onPressed: () =>
                                    model.textPatient(patient.phoneNum),
                                label: Text(
                                  'Text',
                                  style:
                                      TextStyles.tsBody3(color: Colors.white),
                                ),
                                icon: Icon(
                                  Icons.send,
                                  size: 16,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Palettes.kcNeutral1),
                              )),
                              SizedBox(width: 8),
                              SizedBox(
                                width: 46,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    '•••',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey.shade300),
                                ),
                              ),
                            ],
                          ),
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
                                patient.phoneNum,
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
                                patient.address,
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
                                patient.birthDate
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
                                patient.gender != 'Female'
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
                          SizedBox(height: 12),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Photos',
                                  style: TextStyles.tsHeading4(),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      'See All',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Wrap(
                            spacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: patient.image,
                                      height: 145,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    patient.birthDate
                                        .toDateTime()!
                                        .toStringDateFormat(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: patient.image,
                                      height: 145,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    patient.birthDate
                                        .toDateTime()!
                                        .toStringDateFormat(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: patient.image,
                                      height: 145,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    patient.birthDate
                                        .toDateTime()!
                                        .toStringDateFormat(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: patient.image,
                                      height: 145,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    patient.birthDate
                                        .toDateTime()!
                                        .toStringDateFormat(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(),
                          Card(
                            shadowColor: Colors.grey.shade500,
                            child: ListTile(
                              onTap: () => model.goToMedicalHistoryView(
                                  patientId: patient.id),
                              leading: Icon(
                                Icons.history,
                                color: Colors.black,
                              ),
                              title: Text(
                                'Medical History',
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
                              onTap: () {},
                              leading: SvgPicture.asset(
                                'assets/icons/Calendar.svg',
                                color: Colors.black,
                              ),
                              title: Text(
                                'Appointments',
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
                              onTap: () {},
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
