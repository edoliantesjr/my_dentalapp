import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/ui/views/appointment/appointment_view_model.dart';
import 'package:dentalapp/ui/widgets/appointment_card/appointment_card.dart';
import 'package:dentalapp/ui/widgets/custom_shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentViewModel>.reactive(
      viewModelBuilder: () => AppointmentViewModel(),
      onModelReady: (model) async {
        final dateToday =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toDateTime();
        await model.getDateFromNtp();
        await model.getAppointmentByDate(dateToday);
        model.listenToAppointmentChanges();
      },
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Clinic Appointments',
              style: TextStyles.tsHeading3(color: Colors.white),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            onPressed: model.goToSelectPatient,
            label: Text('Add Appointment'),
          ),
          body: Container(
            color: Colors.grey.shade50,
            child: Column(
              children: [
                Container(
                  color: Palettes.kcBlueMain1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 4, right: 4, bottom: 4),
                    child: CalendarTimeline(
                      key: ObjectKey(model.appointmentList),
                      initialDate: model.selectedDate,
                      firstDate: DateTime.utc(2021, 12),
                      lastDate: DateTime(2026, 12),
                      onDateSelected: (date) {
                        model.getAppointmentByDate(date!);
                      },
                      monthColor: Colors.white,
                      activeBackgroundDayColor: Colors.white,
                      dayColor: Colors.white,
                      activeDayColor: Palettes.kcBlueMain1,
                    ),
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Container(
                  height: 45,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'Filter: ',
                        style: TextStyles.tsHeading5(),
                      ),
                      Spacer(),
                      FilterChip(
                        label: Text('All'),
                        selected: true,
                        onSelected: (bool) => !bool,
                      ),
                      SizedBox(width: 4),
                      FilterChip(
                        label: Text('Done'),
                        onSelected: (bool) => !bool,
                      ),
                      SizedBox(width: 4),
                      FilterChip(
                        label: Text('Pending'),
                        onSelected: (bool) => !bool,
                      ),
                      SizedBox(width: 4),
                      FilterChip(
                        label: Text('Cancelled'),
                        onSelected: (bool) => !bool,
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey),
                Expanded(
                  child: Scrollbar(
                    thickness: 7,
                    hoverThickness: 2,
                    showTrackOnHover: true,
                    child: Container(
                      color: Colors.grey.shade50,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: model.appointmentList.isNotEmpty
                          ? appointmentCardHelper(
                              appointmentList: model.appointmentList,
                              isBusy: model.isBusy,
                              onDeleteItem: (int) {},
                              navigator: model.navigationService)
                          : Center(
                              child:
                                  Text('No Appointment for this date. Add Now'),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget appointmentCardHelper(
      {required List<AppointmentModel> appointmentList,
      required bool isBusy,
      required NavigationService navigator,
      required Function(int index) onDeleteItem}) {
    if (isBusy) {
      return MyShimmer();
    } else {
      return AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          // physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(5),
          itemCount: appointmentList.length,
          itemBuilder: (context, i) => AnimationConfiguration.staggeredList(
            position: i,
            duration: Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 90.0,
              // horizontalOffset: 300,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 850),
              child: FadeInAnimation(
                curve: Curves.easeInOut,
                delay: Duration(milliseconds: 350),
                duration: Duration(milliseconds: 1000),
                child: AppointmentCard(
                  key: ObjectKey(appointmentList[i]),
                  onPatientTap: () => navigator.pushNamed(
                      Routes.PatientInfoView,
                      arguments: PatientInfoViewArguments(
                          patient: appointmentList[i].patient)),
                  onDelete: () => onDeleteItem(i),
                  imageUrl: appointmentList[i].patient.image,
                  serviceTitle: appointmentList[i].procedures![0].procedureName,
                  doctor: appointmentList[i].dentist,
                  patient: appointmentList[i].patient.fullName,
                  appointmentDate: DateFormat.yMMMd()
                      .format(appointmentList[i].date.toDateTime()!),
                  time:
                      '${appointmentList[i].startTime.toDateTime()!.toTime()}-${appointmentList[i].endTime.toDateTime()!.toTime()}',
                  appointmentStatus: getAppointmentStatus(
                      appointmentList[i].appointment_status),
                  appointmentId: appointmentList[i].appointment_id,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
