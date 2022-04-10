import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class AppointmentCard extends StatelessWidget {
  final Key key;
  final String dateDay;
  final String dateMonth;
  final String doctor;
  final String patient;
  final AppointmentStatus appointmentStatus;
  final String serviceTitle;
  final String? time;
  final VoidCallback onDelete;

  const AppointmentCard({
    required this.key,
    required this.dateDay,
    required this.dateMonth,
    required this.doctor,
    required this.patient,
    required this.appointmentStatus,
    required this.serviceTitle,
    required this.onDelete,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: this.key,
      trailingActions: [
        SwipeAction(
          widthSpace: 60,
          color: Colors.transparent,
          onTap: (handler) async {
            await handler(true);
            this.onDelete();
          },
          content: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.shade700,
            ),
            child: SvgPicture.asset(
              'assets/icons/Delete.svg',
              color: Colors.white,
            ),
          ),
          nestedAction: SwipeNestedAction(
            content: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red.shade700,
              ),
              child: Container(
                width: 95,
                child: OverflowBox(
                  maxWidth: 95,
                  minWidth: 95,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/Delete.svg',
                        color: Colors.white,
                      ),
                      Text(
                        'Delete',
                        style: TextStyles.tsBody2(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SwipeAction(
          widthSpace: 60,
          color: Colors.transparent,
          onTap: (handler) {},
          content: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palettes.kcBlueMain2,
            ),
            child: SvgPicture.asset(
              'assets/icons/Edit.svg',
              color: Colors.white,
            ),
          ),
        ),
      ],
      child: Container(
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
          child: Container(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            height: 135,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Palettes.kcNeutral5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Palettes.kcNeutral4, blurRadius: 2)
                ]),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        DateWidget(
                          dateDay: dateDay,
                          dateMonth: dateMonth,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: InfoWidget(
                          serviceTitle: serviceTitle,
                          doctor: doctor,
                          patient: patient,
                          appointmentStatus: appointmentStatus,
                        )),
                      ],
                    )),
                SizedBox(height: 10),
                Divider(height: 1, color: Palettes.kcNeutral2),
                Container(
                  height: 35,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'TIME: ${time}',
                            style: TextStyles.tsButton2(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              'Appointment Details',
                              style: TextStyles.tsButton2(
                                  color: Palettes.kcBlueMain2),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Palettes.kcBlueMain2,
                              size: 18,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  final String dateDay;
  final String dateMonth;

  const DateWidget({Key? key, required this.dateDay, required this.dateMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xff7A9DE9), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                dateMonth,
                style: TextStyles.tsHeading2(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 8),
          FittedBox(
            child: Text(
              dateDay,
              style: TextStyles.tsHeading4(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String serviceTitle;
  final String doctor;
  final String patient;
  final AppointmentStatus appointmentStatus;

  const InfoWidget(
      {Key? key,
      required this.serviceTitle,
      required this.doctor,
      required this.patient,
      required this.appointmentStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  serviceTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontNames.sfPro,
                      fontSize: 16,
                      color: Palettes.kcNeutral1,
                      overflow: TextOverflow.ellipsis,
                      leadingDistribution: TextLeadingDistribution.proportional,
                      letterSpacing: 0.5),
                ),
              ),
              Flexible(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                    color: appointmentStatus == AppointmentStatus.Done
                        ? Palettes.kcCompleteColor
                        : appointmentStatus == AppointmentStatus.Ongoing
                            ? Palettes.kcBlueMain2
                            : appointmentStatus == AppointmentStatus.Pending
                                ? Palettes.kcPendingColor
                                : appointmentStatus ==
                                        AppointmentStatus.Cancelled
                                    ? Palettes.kcCancelledColor
                                    : Palettes.kcCancelledColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  appointmentStatus.name,
                  style: TextStyles.tsButton2(color: Colors.white),
                ),
              )),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Patient: ',
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral2),
              ),
              Text(
                patient,
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Dentist: ',
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral2),
              ),
              Text(
                doctor,
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral2),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
