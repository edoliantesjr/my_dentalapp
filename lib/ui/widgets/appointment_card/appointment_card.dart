// ignore_for_file: overridden_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:intl/intl.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/api/api_service.dart';
import '../../../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../../../core/service/connectivity/connectivity_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/navigation/navigation_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../../models/appointment_model/appointment_model.dart';
import '../../../models/notification/notification_model.dart';
import '../selection_list/selection_option.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentModel appointment;
  final Function onPatientTap;
  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onPatientTap,
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
  final toastService = locator<ToastService>();

  Future<void> deleteAppointment(String appointmentId) async {
    dialogService.showConfirmDialog(
        title: 'Delete  appointment',
        middleText:
            'This action will delete the appointment permanently. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          await apiService.deleteAppointment(appointmentId: appointmentId);
          navigationService.pop();
          final notification = NotificationModel(
            user_id: widget.appointment.patient.id,
            notification_title: 'Your appointment was DELETED',
            notification_msg: 'Your Appointment on ${widget.appointment.date}'
                ' with Doc. ${widget.appointment.dentist} was and deleted',
            notification_type: 'appointment',
            isRead: false,
          );
          await apiService.saveNotification(
              notification: notification,
              typeId: widget.appointment.appointment_id!);
          toastService.showToast(message: 'Appointment deleted');
        });
  }

  Future<void> updateAppointmentStatus(AppointmentModel appointment) async {
    final appointmentSelectedOption =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: setAppointmentOption(),
      title: 'Set Appointment Status',
    ));

    if (appointmentSelectedOption != null) {
      final appointmentStatus = setAppointmentReturn(appointmentSelectedOption);

      if (appointmentStatus != null) {
        if (await connectivityService.checkConnectivity()) {
          dialogService.showDefaultLoadingDialog(
              barrierDismissible: false, willPop: false);
          await apiService.updateAppointmentStatus(
              appointmentId: appointment.appointment_id!,
              appointmentStatus: appointmentStatus);
          navigationService.pop();
          final notification = NotificationModel(
            user_id: widget.appointment.patient.id,
            notification_title: 'Appointment status: $appointmentStatus.',
            notification_msg: 'Your Appointment on ${widget.appointment.date}'
                ' with Doc. ${widget.appointment.dentist} was marked: $appointmentStatus',
            notification_type: 'appointment',
            isRead: false,
          );
          await apiService.saveNotification(
              notification: notification,
              typeId: widget.appointment.appointment_id!);
          snackBarService.showSnackBar(
              message: 'Appointment status was updated', title: 'Success!');
        } else {
          navigationService.pop();
          snackBarService.showSnackBar(
              message: 'Check your network connection and try again',
              title: 'Network Error');
        }
      } else {
        navigationService.pushNamed(Routes.AppointmentRescheduleView,
            arguments:
                AppointmentRescheduleViewArguments(appointment: appointment));
      }
    }
  }

  String? setAppointmentReturn(String appointmentSelectedOption) {
    if (appointmentSelectedOption == AppointmentStatus.Approved.options) {
      return AppointmentStatus.Approved.name;
    } else if (appointmentSelectedOption == AppointmentStatus.Request.options) {
      return AppointmentStatus.Request.name;
    } else if (appointmentSelectedOption ==
        AppointmentStatus.Cancelled.options) {
      return AppointmentStatus.Cancelled.name;
    } else if (appointmentSelectedOption ==
        AppointmentStatus.Declined.options) {
      return AppointmentStatus.Declined.name;
    } else {
      return null;
    }
  }

  List<String> setAppointmentOption() {
    List<String> options = [];
    if (widget.appointment.appointment_status ==
        AppointmentStatus.Request.name) {
      options = [
        AppointmentStatus.Approved.options,
        AppointmentStatus.Declined.options,
      ];
    }
    if (widget.appointment.appointment_status ==
        AppointmentStatus.Approved.name) {
      options = [
        AppointmentStatus.Cancelled.options,
        'RESCHEDULE',
      ];
    }
    if (widget.appointment.appointment_status ==
        AppointmentStatus.Cancelled.name) {
      options = [
        'RESCHEDULE',
      ];
    }
    if (widget.appointment.appointment_status ==
        AppointmentStatus.Declined.name) {
      options = [
        'RESCHEDULE',
      ];
    }

    return options;
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(widget.appointment.appointment_id!),
      trailingActions: [
        SwipeAction(
          widthSpace: 80,
          color: Colors.transparent,
          onTap: (handler) async {
            // await handler(true);
            deleteAppointment(widget.appointment.appointment_id!);
          },
          content: Container(
            height: 50,
            width: 60,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red.shade700,
              ),
              child: SizedBox(
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
        // SwipeAction(
        //   widthSpace: 60,
        //   color: Colors.transparent,
        //   onTap: (handler) {
        //     //
        //   },
        //   content: Container(
        //     height: 50,
        //     width: 50,
        //     alignment: Alignment.center,
        //     padding: EdgeInsets.all(8),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Palettes.kcBlueMain2,
        //     ),
        //     child: SvgPicture.asset(
        //       'assets/icons/Edit.svg',
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      ],
      child: Container(
        color: Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
          child: Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            height: 152,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Palettes.kcNeutral4),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Palettes.kcNeutral4, blurRadius: 2)
                ]),
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        DateWidget(
                          imageUrl: widget.appointment.patient.image,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: InfoWidget(
                          onPatientTap: () => widget.onPatientTap(),
                          date: DateFormat.yMMMd()
                              .format(widget.appointment.date.toDateTime()!),
                          serviceTitle: widget
                              .appointment.procedures!.first.procedureName
                              .toString(),
                          doctor: widget.appointment.dentist,
                          patient: widget.appointment.patient.fullName,
                          appointmentStatus: getAppointmentStatus(
                              widget.appointment.appointment_status),
                        )),
                      ],
                    )),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Palettes.kcNeutral2),
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
                            'TIME: ${widget.appointment.startTime.toDateTime()!.toTime()}-${widget.appointment.endTime.toDateTime()!.toTime()}',
                            style: TextStyles.tsButton2(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            updateAppointmentStatus(widget.appointment),
                        child: Row(
                          children: [
                            Text(
                              'Update Status',
                              style: TextStyles.tsButton2(
                                  color: Palettes.kcBlueMain2),
                            ),
                            const Icon(
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
    return Column(
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
                    fontSize: 13.sp,
                    color: Palettes.kcNeutral1,
                    overflow: TextOverflow.ellipsis,
                    leadingDistribution: TextLeadingDistribution.proportional,
                    letterSpacing: 0.5),
              ),
            ),
            Flexible(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              'Patient: ',
              style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
            ),
            InkWell(
              onTap: () => onPatientTap(),
              child: Text(
                patient,
                style: const TextStyle(
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
        const SizedBox(height: 5),
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
        const SizedBox(height: 5),
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
    );
  }

  Color selectAppointmentColor(AppointmentStatus appointmentStatus) {
    Color returnColor = Colors.red.shade900;
    if (appointmentStatus == AppointmentStatus.Approved) {
      returnColor = Palettes.kcCompleteColor;
    }

    if (appointmentStatus == AppointmentStatus.Cancelled) {
      returnColor = Palettes.kcCancelledColor;
    }

    if (appointmentStatus == AppointmentStatus.Request) {
      returnColor = Colors.brown;
    }

    if (appointmentStatus == AppointmentStatus.Declined) {
      returnColor = Colors.red;
    }
    return returnColor;
  }
}
