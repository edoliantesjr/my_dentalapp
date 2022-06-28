import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/appointment_card/appointment_card.dart';
import 'week_appointment_view_model.dart';

class WeekAppointmentView extends StatelessWidget {
  const WeekAppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeekAppointmentViewModel>.reactive(
      viewModelBuilder: () => WeekAppointmentViewModel(),
      onModelReady: (model) {
        debugPrint(model.selectedPeriod?.start.toString());
        debugPrint(model.selectedPeriod?.end.toString());
      },
      builder: (context, model, widget) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            WeekPicker(
              initiallyShowDate: DateTime.now(),
              selectedDate: model.selectedDate,
              firstDate: model.firstDate,
              lastDate: model.lastDate,

              onChanged: model.selectDateChange,
              datePickerStyles: DatePickerRangeStyles(
                selectedPeriodMiddleDecoration: const BoxDecoration(
                    color: Palettes.kcPurpleMain, shape: BoxShape.rectangle),
              ),
              // eventDecorationBuilder: _eventDecorationBuilder,
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              // physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: model.appointments.length,
              itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
                position: i,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 90.0,
                  // horizontalOffset: 300,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 850),
                  child: FadeInAnimation(
                    curve: Curves.easeInOut,
                    delay: const Duration(milliseconds: 350),
                    duration: const Duration(milliseconds: 1000),
                    child: AppointmentCard(
                      key: ObjectKey(model.appointments[i]),
                      onPatientTap: () {},
                      appointment: model.appointments[i],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
