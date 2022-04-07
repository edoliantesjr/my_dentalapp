import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/ui/views/appointment/appointment_view_model.dart';
import 'package:dentalapp/ui/widgets/appointment_card/appointment_card.dart';
import 'package:dentalapp/ui/widgets/custom_shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

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
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Clinic Appointments',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton.extended(
          heroTag: null,
          onPressed: model.goToSelectPatient,
          label: Text('Add Appointment'),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade50,
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: RefreshIndicator(
              color: Palettes.kcBlueMain1,
              onRefresh: () async {
                await model.getAppointmentByDate(model.selectedDate);
              },
              child: CustomScrollView(
                physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverStickyHeader(
                      sticky: true,
                      overlapsContent: false,
                      header: Container(
                        color: Colors.grey.shade50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalendarTimeline(
                              initialDate: model.selectedDate,
                              firstDate: DateTime.utc(2021, 12),
                              lastDate: DateTime(2026, 12),
                              onDateSelected: (date) {
                                model.getAppointmentByDate(date!);
                              },
                              monthColor: Palettes.kcNeutral1,
                              key: ObjectKey(model.appointmentList),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 8),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 2,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Container()
                                //  todo: edit this to show filter appointments
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Result',
                                //       style: TextStyles.tsHeading4(),
                                //     ),
                                //     SizedBox(width: 8),
                                //     Container(
                                //       padding:
                                //           EdgeInsets.symmetric(horizontal: 8),
                                //       decoration: BoxDecoration(
                                //           color: Colors.grey.shade600,
                                //           borderRadius:
                                //               BorderRadius.circular(10)),
                                //       child: Text(
                                //         'Done',
                                //         style: TextStyle(color: Colors.white),
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child:
                                //       Row(
                                //         mainAxisAlignment: MainAxisAlignment.end,
                                //         children: [
                                //           InkWell(
                                //             onTap: () {},
                                //             child: Container(
                                //               padding: EdgeInsets.all(5),
                                //               decoration: BoxDecoration(
                                //                   color: Colors.white,
                                //                   shape: BoxShape.circle,
                                //                   boxShadow: [
                                //                     BoxShadow(
                                //                         color:
                                //                             Palettes.kcBlueMain2,
                                //                         blurRadius: 1)
                                //                   ]),
                                //               child: SvgPicture.asset(
                                //                 'assets/icons/Search.svg',
                                //                 color: Palettes.kcNeutral1,
                                //                 height: 18,
                                //                 width: 18,
                                //               ),
                                //             ),
                                //           ),
                                //           SizedBox(width: 15),
                                //           InkWell(
                                //             onTap: () {},
                                //             child: Container(
                                //               padding: EdgeInsets.all(5),
                                //               decoration: BoxDecoration(
                                //                   color: Colors.white,
                                //                   shape: BoxShape.circle,
                                //                   boxShadow: [
                                //                     BoxShadow(
                                //                         color:
                                //                             Palettes.kcBlueMain2,
                                //                         blurRadius: 1)
                                //                   ]),
                                //               child: SvgPicture.asset(
                                //                 'assets/icons/Filter.svg',
                                //                 color: Palettes.kcNeutral1,
                                //                 height: 18,
                                //                 width: 18,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // ),
                                ),
                            SizedBox(height: 5)
                          ],
                        ),
                      ),
                      sliver: SliverList(
                        delegate: model.appointmentList.isNotEmpty
                            ? SliverChildBuilderDelegate(
                                (context, index) {
                                  return appointmentCardHelper(
                                    appointmentList: model.appointmentList,
                                    isBusy: model.isBusy,
                                    onDeleteItem: (index) {},
                                  );
                                },
                                childCount: 1,
                              )
                            : SliverChildListDelegate([
                                Container(
                                  height: 400,
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      'No Appointments for this date.',
                                      style: TextStyles.tsBody2(
                                          color: Palettes.kcNeutral1),
                                    ),
                                  ),
                                ),
                              ]),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  Widget appointmentCardHelper(
      {required List<AppointmentModel> appointmentList,
      required bool isBusy,
      required Function(int index) onDeleteItem}) {
    if (isBusy) {
      return MyShimmer();
    } else {
      return AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
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
                  onDelete: () => onDeleteItem(i),
                  serviceTitle: appointmentList[i].procedures![0].procedureName,
                  doctor: appointmentList[i].dentist,
                  patient: appointmentList[i].patient.fullName,
                  dateDay: appointmentList[i].date.toDateTime()!.day.toString(),
                  dateMonth: DateFormat('MMM')
                      .format(appointmentList[i].date.toDateTime()!),
                  time:
                      '${appointmentList[i].startTime.toDateTime()!.toTime()}-${appointmentList[i].endTime.toDateTime()!.toTime()}',
                  appointmentStatus: getAppointmentStatus(
                      appointmentList[i].appointment_status),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
