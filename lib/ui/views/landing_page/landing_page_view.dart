import 'package:dentalapp/ui/views/appointment/appointment_view.dart';
import 'package:dentalapp/ui/views/home/home_view.dart';
import 'package:dentalapp/ui/views/landing_page/landing_page_view_model.dart';
import 'package:dentalapp/ui/views/medicine/medicine_view.dart';
import 'package:dentalapp/ui/views/patients/patients_view.dart';
import 'package:dentalapp/ui/views/services/services_view.dart';
import 'package:dentalapp/ui/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LandingPageView extends StatelessWidget {
  const LandingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LandingPageViewModel>.reactive(
      viewModelBuilder: () => LandingPageViewModel(),
      builder: (context, model, child) => Scaffold(
          extendBody: true,
          bottomNavigationBar: CustomBottomNavigation(
            setSelectedIndex: (index) => model.setSelectedIndex(index),
            selectedIndex: model.selectedIndex,
          ),
          body: IndexStackBody(
            index: model.selectedIndex,
          )),
    );
  }
}

class IndexStackBody extends StatelessWidget {
  final index;
  const IndexStackBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        HomePageView(),
        AppointmentView(),
        PatientsView(),
        ServicesView(),
        MedicineView(),
      ],
    );
  }
}
