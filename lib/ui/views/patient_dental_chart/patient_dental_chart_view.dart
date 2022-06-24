import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/patient_dental_chart/patient_dental_chart_view_model.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:dentalapp/ui/widgets/tooth/tooth_widget.dart';
import 'package:flutter/cupertino.dart';
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
      onModelReady: (model) async {
        await Future.delayed(const Duration(milliseconds: 100));
        refreshKey.currentState?.show();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Patient's Dental Chart"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => model.goToChartLegend(),
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                ))
          ],
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  onPressed: () => model.navigationService.pushNamed(
                      Routes.ViewDentalNote,
                      arguments: ViewDentalNoteArguments(patient: patient)),
                  label: const Text('View Dental Notes'),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyles.tsBody2(),
                    primary: Palettes.kcBlueMain1,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.money,
                  color: Colors.white,
                ),
                onPressed: () => model.navigationService.pushNamed(
                    Routes.AddPaymentView,
                    arguments: AddPaymentViewArguments(patient: patient)),
                label: const Text('Add Payment'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyles.tsBody2(),
                  primary: Palettes.kcNeutral1,
                ),
              ),
            ],
          ),
        ],
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            model.isInSelectionMode = false;
            model.selectedTooth.clear();
            model.init(patient.id);
            model.notifyListeners();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              PatientCard(
                image: patient.image,
                name: patient.fullName,
                phone: patient.phoneNum,
                address: patient.address,
                age: '20',
                birthDate:
                    DateFormat.yMMMd().format(patient.birthDate.toDateTime()!),
                dateCreated: patient.dateCreated!,
              ),
              AnimatedContainer(
                height: model.isInSelectionMode ? 45 : 0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                ),
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(2),
                curve: Curves.easeIn,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 10),
                    Center(
                        child: RichText(
                      text: TextSpan(
                        text: model.selectedTooth.length.toString(),
                        children: const [
                          TextSpan(
                              text: ' Tooth Selected',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal))
                        ],
                        style: TextStyles.tsHeading5(),
                      ),
                    )),
                    const Spacer(),
                    // TextButton.icon(
                    //   onPressed: () => model.goToSetToothCondition(patient.id),
                    //   icon: Icon(CupertinoIcons.add_circled),
                    //   label: Text('Condition'),
                    //   style: TextButton.styleFrom(
                    //     primary: Colors.white,
                    //     backgroundColor: Palettes.kcNeutral1,
                    //   ),
                    // ),
                    const SizedBox(width: 5),
                    TextButton.icon(
                      onPressed: () => model.goToSetDentalNote(patient.id),
                      icon: const Icon(CupertinoIcons.add_circled),
                      label: const Text(' Add Dental Note/ Treatment'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Palettes.kcBlueMain1,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
              const SizedBox(height: 4),
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
                    const SizedBox(height: 3),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const SizedBox(height: 5),

                              //PEDIATRIC UPPER
                              GridView.builder(
                                itemCount: 10,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 10,
                                        mainAxisExtent: 60,
                                        crossAxisSpacing: 1),
                                itemBuilder: (context, index) => ToothWidget(
                                  isUpper: true,
                                  hasRecord: model.hasHistory(
                                      model.toothIdFromA[index].toString()),
                                  isSelected: model.isSelected(
                                      model.toothIdFromA[index].toString()),
                                  onTap: () {
                                    if (model.hasHistory(model
                                            .toothIdFromA[index]
                                            .toString()) &&
                                        !(model.isInSelectionMode)) {
                                      model.viewDentalNoteById(
                                          patient: patient,
                                          selectedTooth:
                                              model.toothIdFromA[index]);
                                    } else {
                                      model.addToSelectedTooth(
                                          model.toothIdFromA[index].toString());
                                    }
                                  },
                                  isCenterTooth: model.checkCenterTooth1(
                                      model.toothIdFromA[index]),
                                  toothId: model.toothIdFromA[index],
                                ),
                              ),
                              const SizedBox(height: 10),

                              //PEDIATRIC LOWER
                              GridView.builder(
                                itemCount: 10,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 1,
                                        crossAxisCount: 10,
                                        mainAxisExtent: 60),
                                itemBuilder: (context, index) => ToothWidget(
                                  isSelected: model.isSelected(
                                      model.toothIdFromT[index].toString()),
                                  hasRecord: model.hasHistory(
                                      model.toothIdFromT[index].toString()),
                                  onTap: () {
                                    if (model.hasHistory(model
                                            .toothIdFromT[index]
                                            .toString()) &&
                                        !(model.isInSelectionMode)) {
                                      model.viewDentalNoteById(
                                          patient: patient,
                                          selectedTooth:
                                              model.toothIdFromT[index]);
                                    } else {
                                      model.addToSelectedTooth(
                                          model.toothIdFromT[index].toString());
                                    }
                                  },
                                  isUpper: false,
                                  isCenterTooth: model.checkCenterTooth1(
                                      model.toothIdFromT[index]),
                                  toothId: model.toothIdFromT[index],
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //second row of teeth chart
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Column(
                        children: [
                          Text('Upper', style: TextStyles.tsHeading5()),
                          const SizedBox(height: 5),

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
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8,
                                mainAxisExtent: 60,
                              ),
                              itemBuilder: (context, index) => ToothWidget(
                                onTap: () {
                                  if (model.hasHistory(model.toothIdFrom1[index]
                                          .toString()) &&
                                      !(model.isInSelectionMode)) {
                                    model.viewDentalNoteById(
                                        patient: patient,
                                        selectedTooth: model.toothIdFrom1[index]
                                            .toString());
                                  } else {
                                    model.addToSelectedTooth(
                                        model.toothIdFrom1[index].toString());
                                  }
                                },
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
                          const SizedBox(height: 8),

                          //ADULT LOWER
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          Text('Lower', style: TextStyles.tsHeading5()),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: GridView.builder(
                              itemCount: 16,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 8,
                                mainAxisExtent: 60,
                              ),
                              itemBuilder: (context, index) => ToothWidget(
                                onTap: () {
                                  if (model.hasHistory(model
                                          .toothIdFrom32[index]
                                          .toString()) &&
                                      !(model.isInSelectionMode)) {
                                    model.viewDentalNoteById(
                                        patient: patient,
                                        selectedTooth: model
                                            .toothIdFrom32[index]
                                            .toString());
                                  } else {
                                    model.addToSelectedTooth(
                                        model.toothIdFrom32[index].toString());
                                  }
                                },
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
            ],
          ),
        ),
      ),
    );
  }
}
