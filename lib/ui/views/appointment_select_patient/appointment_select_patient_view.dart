import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'appointment_select_patient_view_model.dart';

class AppointmentSelectPatientView extends StatelessWidget {
  const AppointmentSelectPatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentSelectPatientViewModel>.reactive(
      viewModelBuilder: () => AppointmentSelectPatientViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text(
            'Select Patient',
            style: TextStyle(color: Colors.white, fontSize: 21),
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: ElevatedButton(
                onPressed: () =>
                    model.navigationService.pushNamed(Routes.AddPatientView),
                child: const Text(
                  'Add Patient',
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Palettes.kcNeutral1),
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: RefreshIndicator(
            color: Palettes.kcBlueMain1,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverStickyHeader(
                  overlapsContent: false,
                  header: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Palettes.kcBlueMain1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          onChanged: (value) => model.searchPatient(value),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Palettes.kcBlueMain1,
                                width: 1.8,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/icons/Search.svg',
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  'assets/icons/Filter.svg',
                                ),
                              ),
                            ),
                            constraints: const BoxConstraints(maxHeight: 43),
                            hintText: 'Search by Last Name, First Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  sliver: model.patientList.isNotEmpty
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 400),
                                horizontalOffset: 100,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        blurRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () => model.selectPatient(
                                          model.patientList[index]),
                                      child: PatientCard(
                                        key: ObjectKey(
                                            model.patientList[index].id),
                                        name: model.patientList[index].fullName,
                                        image: model.patientList[index].image,
                                        phone:
                                            model.patientList[index].phoneNum,
                                        address:
                                            model.patientList[index].address,
                                        birthDate: DateFormat.yMMMd().format(
                                            model.patientList[index].birthDate
                                                .toDateTime()!),
                                        age: AgeCalculator.age(
                                                model.patientList[index]
                                                    .birthDate
                                                    .toDateTime()!,
                                                today: DateTime.now())
                                            .years
                                            .toString(),
                                        dateCreated: model
                                            .patientList[index].dateCreated!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }, childCount: model.patientList.length),
                        )
                      : SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: const Center(
                              child: Text('No Patients Found'),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
