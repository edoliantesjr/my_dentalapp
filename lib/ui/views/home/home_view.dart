import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/ui/views/home/home_view_model.dart';
import 'package:dentalapp/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:dentalapp/ui/widgets/home_appointment/home_appointment.dart';
import 'package:dentalapp/ui/widgets/home_shortcut/home_shortcut.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => HomePageViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: CustomHomePageAppBar(),
        body: RefreshIndicator(
          color: Palettes.kcBlueMain1,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            model.init();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeShortcut(),
                HomeAppointment(
                  deleteItem: (index) => model.deleteThisFromList(index),
                  myAppointments: model.mockAppointment,
                  isBusy: model.isBusy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
