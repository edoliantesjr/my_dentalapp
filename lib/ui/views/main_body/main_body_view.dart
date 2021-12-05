import 'package:dentalapp/core/utility/home_navigator.dart';
import 'package:dentalapp/ui/views/appointment/appointment_view.dart';
import 'package:dentalapp/ui/views/main_body/main_body_view_model.dart';
import 'package:dentalapp/ui/views/medicine/medicine_view.dart';
import 'package:dentalapp/ui/views/patients/patients_view.dart';
import 'package:dentalapp/ui/views/services/services_view.dart';
import 'package:dentalapp/ui/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainBodyView extends StatelessWidget {
  const MainBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainBodyViewModel>.reactive(
      viewModelBuilder: () => MainBodyViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          model.navigationService.pop(id: model.selectedIndex);
          return false;
        },
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: CustomBottomNavigation(
              setSelectedIndex: (index) => model.setSelectedIndex(index),
              selectedIndex: model.selectedIndex,
            ),
            body: SafeArea(
              child: IndexStackBody(
                index: model.selectedIndex,
              ),
            )),
      ),
    );
  }
}

class IndexStackBody extends StatelessWidget {
  final index;
  IndexStackBody({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        HomeNavigator(navigatorKeyId: 0),
        // HomeNavigator(navigatorKeyId: 1),
        // HomeNavigator(navigatorKeyId: 2),
        // HomeNavigator(navigatorKeyId: 3),
        // HomeNavigator(navigatorKeyId: 4),
        // HomePageView(),
        AppointmentView(),
        PatientsView(),
        ServicesView(),
        MedicineView(),
      ],
    );
  }
}
