import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../../../core/service/connectivity/connectivity_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../selection_list/selection_option.dart';

class AppointmentCard extends StatefulWidget {
  final Key key;
  final String appointmentDate;
  final dynamic appointmentId;
  final String doctor;
  final String patient;
  final AppointmentStatus appointmentStatus;
  final Function onPatientTap;
  final String serviceTitle;
  final String? time;
  final dynamic imageUrl;
  final VoidCallback onDelete;

  const AppointmentCard({
    required this.key,
    required this.appointmentId,
    required this.onPatientTap,
    required this.appointmentDate,
    required this.doctor,
    required this.patient,
    required this.appointmentStatus,
    required this.serviceTitle,
    required this.onDelete,
    required this.imageUrl,
    this.time,
  }) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final bottomSheetService = locator<BottomSheetService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  Future<void> updateAppointmentStatus(String appointmentId) async {
    final appointmentStatus =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: [
        AppointmentStatus.Completed.name,
        AppointmentStatus.Cancelled.name,
        AppointmentStatus.Pending.name,
        AppointmentStatus.Declined.name,
      ],
      title: 'Set Appointment Status',
    ));

    if (appointmentStatus != null) {
      if (await connectivityService.checkConnectivity()) {
        dialogService.showDefaultLoadingDialog(
            barrierDismissible: false, willPop: false);
        await apiService.updateAppointmentStatus(
            appointmentId: appointmentId, appointmentStatus: appointmentStatus);
        navigationService.pop();
        snackBarService.showSnackBar(
            message: 'Appointment status was updated', title: 'Success!');
      } else {
        navigationService.pop();
        snackBarService.showSnackBar(
            message: 'Check your network connection and try again',
            title: 'Network Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: this.widget.key,
      trailingActions: [
        SwipeAction(
          widthSpace: 60,
          color: Colors.transparent,
          onTap: (handler) async {
            await handler(true);
            this.widget.onDelete();
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
            height: 152,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Palettes.kcNeutral4),
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
                          imageUrl: widget.imageUrl,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: InfoWidget(
                          onPatientTap: () => this.widget.onPatientTap(),
                          date: widget.appointmentDate,
                          serviceTitle: widget.serviceTitle,
                          doctor: widget.doctor,
                          patient: widget.patient,
                          appointmentStatus: widget.appointmentStatus,
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
                            'TIME: ${widget.time}',
                            style: TextStyles.tsButton2(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            updateAppointmentStatus(widget.appointmentId),
                        child: Row(
                          children: [
                            Text(
                              'Update Status',
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
  final dynamic imageUrl;

  const DateWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        width: 75,
        height: double.maxFinite,
        alignment: Alignment.center,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => Container(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String serviceTitle;
  final String doctor;
  final String patient;
  final String date;
  final Function onPatientTap;
  final AppointmentStatus appointmentStatus;

  const InfoWidget(
      {Key? key,
      required this.date,
      required this.onPatientTap,
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
                      fontSize: 14.sp,
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
                    color: selectAppointmentColor(appointmentStatus),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  appointmentStatus.name,
                  style: TextStyles.tsButton2(color: Colors.white),
                ),
              )),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Patient: ',
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
              ),
              InkWell(
                onTap: () => this.onPatientTap(),
                child: Text(
                  patient,
                  style: TextStyle(
                    color: Palettes.kcDarkerBlueMain1,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.5,
                    decoration: TextDecoration.underline,
                    wordSpacing: .2,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Dentist: ',
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
              ),
              Text(
                doctor,
                style: TextStyles.tsHeading5(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
                text: 'Date: ',
                style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                children: [
                  TextSpan(
                    text: date,
                    style: TextStyles.tsHeading5(),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Color selectAppointmentColor(AppointmentStatus appointmentStatus) {
    Color returnColor = Colors.red.shade900;
    if (appointmentStatus == AppointmentStatus.Completed) {
      returnColor = Palettes.kcCompleteColor;
    }
    if (appointmentStatus == AppointmentStatus.Pending) {
      returnColor = Palettes.kcPendingColor;
    }
    if (appointmentStatus == AppointmentStatus.Cancelled) {
      returnColor = Palettes.kcCancelledColor;
    }

    if (appointmentStatus == AppointmentStatus.OnRequest) {
      returnColor = Colors.brown;
    }

    if (appointmentStatus == AppointmentStatus.Declined) {
      returnColor = Colors.red;
    }
    return returnColor;
  }
}
