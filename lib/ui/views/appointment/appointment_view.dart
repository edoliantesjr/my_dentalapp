import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/appointment/appointment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppointmentViewModel>.reactive(
      viewModelBuilder: () => AppointmentViewModel(),
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
                await Future.delayed(Duration(seconds: 1));
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime.utc(2021, 12),
                              lastDate: DateTime(2026, 12),
                              onDateSelected: (date) {},
                              monthColor: Palettes.kcNeutral1,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Result',
                                    style: TextStyles.tsHeading4(),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade600,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Palettes.kcBlueMain2,
                                                      blurRadius: 1)
                                                ]),
                                            child: SvgPicture.asset(
                                              'assets/icons/Search.svg',
                                              color: Palettes.kcNeutral1,
                                              height: 18,
                                              width: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Palettes.kcBlueMain2,
                                                      blurRadius: 1)
                                                ]),
                                            child: SvgPicture.asset(
                                              'assets/icons/Filter.svg',
                                              color: Palettes.kcNeutral1,
                                              height: 18,
                                              width: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5)
                          ],
                        ),
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              color: Colors.red,
                              height: 30,
                            );
                            // return AppointmentCard(
                            //   key: ObjectKey(
                            //       HomePageViewModel().mockAppointment[index]),
                            //   dateDay: HomePageViewModel()
                            //       .mockAppointment[index]
                            //       .dateDay,
                            //   dateMonth: HomePageViewModel()
                            //       .mockAppointment[index]
                            //       .dateMonth,
                            //   doctor: HomePageViewModel()
                            //       .mockAppointment[index]
                            //       .doctor,
                            //   patient: HomePageViewModel()
                            //       .mockAppointment[index]
                            //       .patient
                            //       .fullName,
                            //   appointmentStatus: getAppointmentStatus(
                            //       HomePageViewModel()
                            //           .mockAppointment[index]
                            //           .status),
                            //   serviceTitle: HomePageViewModel()
                            //       .mockAppointment[index]
                            //       .serviceTitle,
                            //   onDelete: () {},
                            // );
                          },
                          childCount: 0,
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
