// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/medical_history/medical_history.dart';
import '../models/patient_model/patient_model.dart';
import '../ui/views/add_medicine/add_medicine_view.dart';
import '../ui/views/add_patient/add_patient_view.dart';
import '../ui/views/add_payment/add_payment_view.dart';
import '../ui/views/add_procedure/add_procedure_view.dart';
import '../ui/views/appointment/appointment_view.dart';
import '../ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import '../ui/views/create_appointment/create_appointment_view.dart';
import '../ui/views/get_started/get_started_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main_body/main_body_view.dart';
import '../ui/views/medical_history/medical_history_view.dart';
import '../ui/views/medical_history_photo_view/med_history_photo_view.dart';
import '../ui/views/medicine/medicine_view.dart';
import '../ui/views/notification/notification_view.dart';
import '../ui/views/patient_dental_chart/patient_dental_chart_view.dart';
import '../ui/views/patient_info/patient_info_view.dart';
import '../ui/views/patients/patients_view.dart';
import '../ui/views/payment_select_patient/payment_select_patient_view.dart';
import '../ui/views/pre_loader/pre_loader_view.dart';
import '../ui/views/procedures/procedure_view.dart';
import '../ui/views/register/register_view.dart';
import '../ui/views/selection_tooth_condition/selection_tooth_condition_view.dart';
import '../ui/views/set_dental_note/set_dental_note_view.dart';
import '../ui/views/set_tooth_condition/set_tooth_condition_view.dart';
import '../ui/views/update_user_info/setup_user_view.dart';
import '../ui/views/user_view/user_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';
import '../ui/views/view_tooth_dental_notes/view_tooth_dental_note_view.dart';
import '../ui/widgets/selection_dentist/selection_dentist.dart';
import '../ui/widgets/selection_procedure/selection_procedure.dart';
import '../ui/widgets/success_view/success.dart';

class Routes {
  static const String PreLoader = '/pre-loader-view';
  static const String GetStarted = '/get-started-view';
  static const String Login = '/login-view';
  static const String Register = '/register-view';
  static const String VerifyEmail = '/verify-email-view';
  static const String SetUpUserView = '/set-up-user-view';
  static const String Success = '/success-view';
  static const String MainBodyView = '/main-body-view';
  static const String HomePageView = '/home-page-view';
  static const String AppointmentView = '/appointment-view';
  static const String MedicineView = '/medicine-view';
  static const String PatientsView = '/patients-view';
  static const String ProceduresView = '/procedures-view';
  static const String AddPatientView = '/add-patient-view';
  static const String AppointmentSelectPatientView =
      '/appointment-select-patient-view';
  static const String CreateAppointmentView = '/create-appointment-view';
  static const String AddMedicineView = '/add-medicine-view';
  static const String AddProcedureView = '/add-procedure-view';
  static const String PatientInfoView = '/patient-info-view';
  static const String MedicalHistoryView = '/medical-history-view';
  static const String MedHistoryPhotoView = '/med-history-photo-view';
  static const String PatientDentalChartView = '/patient-dental-chart-view';
  static const String SetToothConditionView = '/set-tooth-condition-view';
  static const String SetDentalNoteView = '/set-dental-note-view';
  static const String AddPaymentView = '/add-payment-view';
  static const String NotificationView = '/notification-view';
  static const String ViewDentalNoteView = '/view-dental-note-view';
  static const String PaymentSelectPatientView = '/payment-select-patient-view';
  static const String SelectionDentist = '/selection-dentist';
  static const String SelectionProcedure = '/selection-procedure';
  static const String SelectionToothCondition = '/selection-tooth-condition';
  static const String UserView = '/user-view';
  static const all = <String>{
    PreLoader,
    GetStarted,
    Login,
    Register,
    VerifyEmail,
    SetUpUserView,
    Success,
    MainBodyView,
    HomePageView,
    AppointmentView,
    MedicineView,
    PatientsView,
    ProceduresView,
    AddPatientView,
    AppointmentSelectPatientView,
    CreateAppointmentView,
    AddMedicineView,
    AddProcedureView,
    PatientInfoView,
    MedicalHistoryView,
    MedHistoryPhotoView,
    PatientDentalChartView,
    SetToothConditionView,
    SetDentalNoteView,
    AddPaymentView,
    NotificationView,
    ViewDentalNoteView,
    PaymentSelectPatientView,
    SelectionDentist,
    SelectionProcedure,
    SelectionToothCondition,
    UserView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.PreLoader, page: PreLoaderView),
    RouteDef(Routes.GetStarted, page: GetStartedView),
    RouteDef(Routes.Login, page: LoginView),
    RouteDef(Routes.Register, page: RegisterView),
    RouteDef(Routes.VerifyEmail, page: VerifyEmailView),
    RouteDef(Routes.SetUpUserView, page: SetUpUserView),
    RouteDef(Routes.Success, page: SuccessView),
    RouteDef(Routes.MainBodyView, page: MainBodyView),
    RouteDef(Routes.HomePageView, page: HomePageView),
    RouteDef(Routes.AppointmentView, page: AppointmentView),
    RouteDef(Routes.MedicineView, page: MedicineView),
    RouteDef(Routes.PatientsView, page: PatientsView),
    RouteDef(Routes.ProceduresView, page: ProceduresView),
    RouteDef(Routes.AddPatientView, page: AddPatientView),
    RouteDef(Routes.AppointmentSelectPatientView,
        page: AppointmentSelectPatientView),
    RouteDef(Routes.CreateAppointmentView, page: CreateAppointmentView),
    RouteDef(Routes.AddMedicineView, page: AddMedicineView),
    RouteDef(Routes.AddProcedureView, page: AddProcedureView),
    RouteDef(Routes.PatientInfoView, page: PatientInfoView),
    RouteDef(Routes.MedicalHistoryView, page: MedicalHistoryView),
    RouteDef(Routes.MedHistoryPhotoView, page: MedHistoryPhotoView),
    RouteDef(Routes.PatientDentalChartView, page: PatientDentalChartView),
    RouteDef(Routes.SetToothConditionView, page: SetToothConditionView),
    RouteDef(Routes.SetDentalNoteView, page: SetDentalNoteView),
    RouteDef(Routes.AddPaymentView, page: AddPaymentView),
    RouteDef(Routes.NotificationView, page: NotificationView),
    RouteDef(Routes.ViewDentalNoteView, page: ViewDentalNoteView),
    RouteDef(Routes.PaymentSelectPatientView, page: PaymentSelectPatientView),
    RouteDef(Routes.SelectionDentist, page: SelectionDentist),
    RouteDef(Routes.SelectionProcedure, page: SelectionProcedure),
    RouteDef(Routes.SelectionToothCondition, page: SelectionToothCondition),
    RouteDef(Routes.UserView, page: UserView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    PreLoaderView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PreLoaderView(),
        settings: data,
      );
    },
    GetStartedView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const GetStartedView(),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    RegisterView: (data) {
      var args = data.getArgs<RegisterViewArguments>(
        orElse: () => RegisterViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(key: args.key),
        settings: data,
      );
    },
    VerifyEmailView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const VerifyEmailView(),
        settings: data,
      );
    },
    SetUpUserView: (data) {
      var args = data.getArgs<SetUpUserViewArguments>(
        orElse: () => SetUpUserViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetUpUserView(
          key: args.key,
          firstName: args.firstName,
          lastName: args.lastName,
          userPhoto: args.userPhoto,
        ),
        settings: data,
      );
    },
    SuccessView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SuccessView(),
        settings: data,
      );
    },
    MainBodyView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MainBodyView(),
        settings: data,
      );
    },
    HomePageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePageView(),
        settings: data,
      );
    },
    AppointmentView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AppointmentView(),
        settings: data,
      );
    },
    MedicineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MedicineView(),
        settings: data,
      );
    },
    PatientsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PatientsView(),
        settings: data,
      );
    },
    ProceduresView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProceduresView(),
        settings: data,
      );
    },
    AddPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddPatientView(),
        settings: data,
      );
    },
    AppointmentSelectPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AppointmentSelectPatientView(),
        settings: data,
      );
    },
    CreateAppointmentView: (data) {
      var args = data.getArgs<CreateAppointmentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateAppointmentView(
          patient: args.patient,
          key: args.key,
        ),
        settings: data,
      );
    },
    AddMedicineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddMedicineView(),
        settings: data,
      );
    },
    AddProcedureView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddProcedureView(),
        settings: data,
      );
    },
    PatientInfoView: (data) {
      var args = data.getArgs<PatientInfoViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => PatientInfoView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    MedicalHistoryView: (data) {
      var args = data.getArgs<MedicalHistoryViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MedicalHistoryView(
          key: args.key,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    MedHistoryPhotoView: (data) {
      var args = data.getArgs<MedHistoryPhotoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MedHistoryPhotoView(
          key: args.key,
          medHistory: args.medHistory,
          initialIndex: args.initialIndex,
        ),
        settings: data,
      );
    },
    PatientDentalChartView: (data) {
      var args = data.getArgs<PatientDentalChartViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PatientDentalChartView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    SetToothConditionView: (data) {
      var args = data.getArgs<SetToothConditionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetToothConditionView(
          key: args.key,
          selectedTeeth: args.selectedTeeth,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    SetDentalNoteView: (data) {
      var args = data.getArgs<SetDentalNoteViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetDentalNoteView(
          key: args.key,
          selectedTeeth: args.selectedTeeth,
          patientId: args.patientId,
        ),
        settings: data,
      );
    },
    AddPaymentView: (data) {
      var args = data.getArgs<AddPaymentViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddPaymentView(
          key: args.key,
          patient: args.patient,
        ),
        settings: data,
      );
    },
    NotificationView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NotificationView(),
        settings: data,
      );
    },
    ViewDentalNoteView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ViewDentalNoteView(),
        settings: data,
      );
    },
    PaymentSelectPatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PaymentSelectPatientView(),
        settings: data,
      );
    },
    SelectionDentist: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionDentist(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectionProcedure: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionProcedure(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    SelectionToothCondition: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SelectionToothCondition(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
    UserView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UserView(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideRight,
        transitionDuration: const Duration(milliseconds: 300),
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  LoginViewArguments({this.key});
}

/// RegisterView arguments holder class
class RegisterViewArguments {
  final Key? key;
  RegisterViewArguments({this.key});
}

/// SetUpUserView arguments holder class
class SetUpUserViewArguments {
  final Key? key;
  final String? firstName;
  final String? lastName;
  final String? userPhoto;
  SetUpUserViewArguments(
      {this.key, this.firstName, this.lastName, this.userPhoto});
}

/// CreateAppointmentView arguments holder class
class CreateAppointmentViewArguments {
  final Patient patient;
  final Key? key;
  CreateAppointmentViewArguments({required this.patient, this.key});
}

/// PatientInfoView arguments holder class
class PatientInfoViewArguments {
  final Key? key;
  final Patient patient;
  PatientInfoViewArguments({this.key, required this.patient});
}

/// MedicalHistoryView arguments holder class
class MedicalHistoryViewArguments {
  final Key? key;
  final dynamic patientId;
  MedicalHistoryViewArguments({this.key, required this.patientId});
}

/// MedHistoryPhotoView arguments holder class
class MedHistoryPhotoViewArguments {
  final Key? key;
  final List<MedicalHistory> medHistory;
  final int initialIndex;
  MedHistoryPhotoViewArguments(
      {this.key, required this.medHistory, required this.initialIndex});
}

/// PatientDentalChartView arguments holder class
class PatientDentalChartViewArguments {
  final Key? key;
  final Patient patient;
  PatientDentalChartViewArguments({this.key, required this.patient});
}

/// SetToothConditionView arguments holder class
class SetToothConditionViewArguments {
  final Key? key;
  final List<String> selectedTeeth;
  final dynamic patientId;
  SetToothConditionViewArguments(
      {this.key, required this.selectedTeeth, required this.patientId});
}

/// SetDentalNoteView arguments holder class
class SetDentalNoteViewArguments {
  final Key? key;
  final List<String> selectedTeeth;
  final dynamic patientId;
  SetDentalNoteViewArguments(
      {this.key, required this.selectedTeeth, required this.patientId});
}

/// AddPaymentView arguments holder class
class AddPaymentViewArguments {
  final Key? key;
  final Patient patient;
  AddPaymentViewArguments({this.key, required this.patient});
}
