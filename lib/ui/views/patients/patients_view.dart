import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/views/patients/patients_view_model.dart';
import 'package:dentalapp/ui/widgets/patient_card/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: !model.isScrolledUp ? 56 : 48,
          child: FloatingActionButton.extended(
            heroTag: null,
            isExtended: model.isScrolledUp,
            onPressed: () =>
                model.navigationService.pushNamed(Routes.AddPatientView),
            label: const Text('Add Patient'),
            icon: const Icon(Icons.add),
          ),
        ),
        body: RefreshIndicator(
          color: Palettes.kcBlueMain1,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                model.setFabSize(isScrolledUp: true);
              } else if (notification.direction == ScrollDirection.reverse) {
                model.setFabSize(isScrolledUp: false);
              }
              return true;
            },
            child: CustomScrollView(
              controller: model.scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverStickyHeader(
                  controller: model.stickController,
                  overlapsContent: false,
                  header: Container(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
                            return Container(
                              margin: const EdgeInsets.only(top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade600,
                                    blurRadius: 1,
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () => model.goToPatientInfoView(index),
                                child: PatientCard(
                                  key: ObjectKey(model.patientList[index].id),
                                  name: model.patientList[index].fullName,
                                  image: model.patientList[index].image,
                                  phone: model.patientList[index].phoneNum,
                                  address: model.patientList[index].address,
                                  birthDate: DateFormat.yMMMd().format(model
                                      .patientList[index].birthDate
                                      .toDateTime()!),
                                  age: AgeCalculator.age(
                                          model.patientList[index].birthDate
                                              .toDateTime()!,
                                          today: DateTime.now())
                                      .years
                                      .toString(),
                                  dateCreated:
                                      model.patientList[index].dateCreated!,
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
