import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/ui/widgets/appointment_card/appointment_card.dart';
import 'package:dentalapp/ui/widgets/custom_shimmer/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppointment extends StatelessWidget {
  final List<AppointmentModel> myAppointments;
  final bool isBusy;
  final Function(int index) deleteItem;
  const HomeAppointment(
      {Key? key,
      required this.myAppointments,
      required this.isBusy,
      required this.deleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              SvgPicture.asset('assets/icons/Calendar.svg'),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 22,
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Appointments Today",
                    style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 22,
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View All',
                        style: TextStyle(
                            fontFamily: FontNames.gilRoy,
                            fontWeight: FontWeight.w600,
                            fontSize: kfsHeading5.sp,
                            color: Palettes.kcBlueMain2),
                      ),
                      SvgPicture.asset(
                        'assets/icons/arrow-right.svg',
                        height: 20,
                        width: 20,
                        color: Palettes.kcBlueMain1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          this.isBusy
              ? MyShimmer()
              : AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(5),
                    itemCount: myAppointments.length,
                    itemBuilder: (context, i) =>
                        AnimationConfiguration.staggeredList(
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
                            key: ObjectKey(myAppointments[i]),
                            onDelete: () => this.deleteItem(i),
                            serviceTitle:
                                myAppointments[i].procedures![0].procedureName,
                            doctor: myAppointments[i].dentist,
                            patient: myAppointments[i].patient.fullName,
                            dateDay: myAppointments[i].date,
                            dateMonth: myAppointments[i].date,
                            time: myAppointments[i]
                                .startTime
                                .toDateTime()!
                                .toTime(),
                            appointmentStatus: getAppointmentStatus(
                                myAppointments[i].appointment_status),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: 10),
          Visibility(
            visible: !isBusy,
            child: Center(
                child: Text(
              'Show more',
              style: TextStyles.tsButton2(color: Palettes.kcBlueMain2),
            )),
          ),
        ],
      ),
    );
  }
}
