import 'dart:async';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/api/api_service.dart';
import '../../../core/service/bottom_sheet/bottom_sheet_service.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../../core/service/toast/toast_service.dart';
import '../../../core/utility/image_selector.dart';
import '../../../models/notification/notification.dart';
import '../../widgets/selection_list/selection_option.dart';

class PatientInfoViewModel extends BaseViewModel {
  String age = '';
  ScrollController scrollController = ScrollController();
  final urlLauncher = locator<URLLauncherService>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final imageSelectorService = locator<ImageSelector>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final snackBarService = locator<SnackBarService>();
  StreamSubscription? patientInfoSub;
  StreamSubscription? notifSub;

  final userId = FirebaseAuth.instance.currentUser!.uid;

  List<NotificationModel> notifications = [];

  int notificationCount = 0;

  Patient? patient;
  void init({required Patient patient}) async {
    this.patient = patient;
    listenToPatientInfoChange(patient: patient);
    getNotifications();
    listenToNotificationChanges();
  }

  Future<void> getPatient({required Patient patient}) async {
    this.patient = await apiService.getPatientInfo(patientId: patient.id);
    notifyListeners();
  }

  void listenToPatientInfoChange({required Patient patient}) {
    apiService.listenToPatientChanges(patientId: patient.id).listen((event) {
      patientInfoSub?.cancel();
      patientInfoSub = apiService
          .listenToPatientChanges(patientId: patient.id)
          .listen((event) {
        getPatient(patient: patient);
      });
    });
  }

  void computeTotalNotif() {
    notificationCount = 0;
    for (NotificationModel notif in notifications) {
      if (notif.isRead == false) {
        notificationCount += 1;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  void listenToNotificationChanges() {
    apiService.listenToNotificationChanges(userId: userId).listen((event) {
      notifSub?.cancel();
      notifSub = apiService
          .listenToNotificationChanges(userId: userId)
          .listen((event) {
        getNotifications();
      });
    });
  }

  Future<void> getNotifications() async {
    final notif = await apiService.getNotification(userId: userId);
    if (notif != null) {
      notifications.clear();
      notifications.addAll(notif);
      notifyListeners();
      computeTotalNotif();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    patientInfoSub?.cancel();
    super.dispose();
  }

  void computeAge({required String birthDate}) {
    age = AgeCalculator.age(birthDate.toDateTime()!, today: DateTime.now())
        .years
        .toString();
    notifyListeners();
  }

  void callPatient(String phone) {
    urlLauncher.callPhoneNumber(phone: phone);
  }

  void textPatient(String phone) {
    urlLauncher.sendTextMessage(phone: phone);
  }

  void goToMedicalHistoryView({required dynamic patientId}) {
    navigationService.pushNamed(Routes.MedicalHistoryView,
        arguments: MedicalHistoryViewArguments(patientId: patientId));
  }

  void goToMedicalChart({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.PatientDentalChartView,
          arguments: PatientDentalChartViewArguments(patient: patient));
  }

  void goToViewPatientAppointmentView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.ViewPatientAppointment,
          arguments: ViewPatientAppointmentArguments(patient: patient));
  }

  void goToViewPatientPaymentsView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.ViewPatientPayment,
          arguments: ViewPatientPaymentArguments(patient: patient));
  }

  void goToPrescriptionView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.PrescriptionView,
          arguments: PrescriptionViewArguments(patient: patient));
  }

  void goToDentalCertificateView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.DentalCertificationView,
          arguments: DentalCertificationViewArguments(patient: patient));
  }

  void goToUpdatePatient({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.EditPatientView,
          arguments: EditPatientViewArguments(patient: patient));
  }

  Future<void> updatePatientImage() async {
    XFile? selectedImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: ['Gallery', 'Camera'],
      title: 'Select Profile Picture in',
    ));

    //Condition to select Image Source
    if (selectedImageSource == 'Gallery') {
      selectedImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource == 'Camera') {
      selectedImage = await imageSelectorService.selectImageWithCamera();
    }

    if (selectedImage != null) {
      toastService.showToast(message: 'Image Uploading...');
      final imageResult = await apiService.uploadPatientProfileImage(
          imageToUpload: File(selectedImage.path), patientId: patient!.id);
      if (imageResult.isUploaded) {
        final qRes = await apiService.updatePatientPhoto(
            image: imageResult.imageUrl!, patientID: patient!.id);
        if (qRes.success) {
          await Future.delayed(Duration(seconds: 2));
          snackBarService.showSnackBar(
              message: 'Patient Image Updated', title: 'Success');
        } else {
          snackBarService.showSnackBar(
              message: 'Patient Image Not Updated: ${qRes.errorMessage!}',
              title: 'Error');
        }
      }
    }
  }
}
