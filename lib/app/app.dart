import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/api/api_service_impl.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/connectivity/connectivity_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service_imp.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service_impl.dart';
import 'package:dentalapp/core/service/firebase_messaging/firebase_messaging_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service_impl.dart';
import 'package:dentalapp/core/service/pdf_service/pdf_service.dart';
import 'package:dentalapp/core/service/pdf_service/pdf_service_impl.dart';
import 'package:dentalapp/core/service/search_index/search_index.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/core/service/session_service/session_service_impl.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service_impl.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/toast/toast_service_impl.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_impl.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/core/service/validator/validator_service_impl.dart';
import 'package:dentalapp/core/utility/connectivity_state.dart';
import 'package:dentalapp/core/utility/image_selector.dart';
import 'package:dentalapp/ui/views/add_dental_certificate/add_certificate_view.dart';
import 'package:dentalapp/ui/views/add_expense_item/add_expense_item_view.dart';
import 'package:dentalapp/ui/views/add_expenses/add_expenses_view.dart';
import 'package:dentalapp/ui/views/add_medicine/add_medicine_view.dart';
import 'package:dentalapp/ui/views/add_patient/add_patient_view.dart';
import 'package:dentalapp/ui/views/add_payment/add_payment_view.dart';
import 'package:dentalapp/ui/views/add_prescription/add_prescription_view.dart';
import 'package:dentalapp/ui/views/add_prescription_item/add_prescription_item_view.dart';
import 'package:dentalapp/ui/views/add_procedure/add_procedure_view.dart';
import 'package:dentalapp/ui/views/appointment/appointment_view.dart';
import 'package:dentalapp/ui/views/appointment_select_patient/appointment_select_patient_view.dart';
import 'package:dentalapp/ui/views/appoitment_yearly_monthly/appointment_year_month_view.dart';
import 'package:dentalapp/ui/views/create_appointment/create_appointment_view.dart';
import 'package:dentalapp/ui/views/dental_certification/dental_certification_view.dart';
import 'package:dentalapp/ui/views/dental_chart_legend/dental_chart_legend.dart';
import 'package:dentalapp/ui/views/finance/reports_view.dart';
import 'package:dentalapp/ui/views/get_started/get_started_view.dart';
import 'package:dentalapp/ui/views/home/home_view.dart';
import 'package:dentalapp/ui/views/login/login_view.dart';
import 'package:dentalapp/ui/views/main_body/main_body_view.dart';
import 'package:dentalapp/ui/views/medical_history/medical_history_view.dart';
import 'package:dentalapp/ui/views/medical_history_photo_view/med_history_photo_view.dart';
import 'package:dentalapp/ui/views/medicine/medicine_view.dart';
import 'package:dentalapp/ui/views/notification/notification_view.dart';
import 'package:dentalapp/ui/views/patient_dental_chart/patient_dental_chart_view.dart';
import 'package:dentalapp/ui/views/patient_info/patient_info_view.dart';
import 'package:dentalapp/ui/views/patients/patients_view.dart';
import 'package:dentalapp/ui/views/payment_select_dental_note/payment_select_dental_note_view.dart';
import 'package:dentalapp/ui/views/payment_select_patient/payment_select_patient_view.dart';
import 'package:dentalapp/ui/views/pre_loader/pre_loader_view.dart';
import 'package:dentalapp/ui/views/prescription_view/prescription_view.dart';
import 'package:dentalapp/ui/views/procedures/procedure_view.dart';
import 'package:dentalapp/ui/views/receipt_view/receipt_view.dart';
import 'package:dentalapp/ui/views/register/register_view.dart';
import 'package:dentalapp/ui/views/select_medicine_view/select_medicine_view.dart';
import 'package:dentalapp/ui/views/selection_tooth_condition/selection_tooth_condition_view.dart';
import 'package:dentalapp/ui/views/set_dental_note/set_dental_note_view.dart';
import 'package:dentalapp/ui/views/set_tooth_condition/set_tooth_condition_view.dart';
import 'package:dentalapp/ui/views/update_procedure/update_procedure_view.dart';
import 'package:dentalapp/ui/views/update_user_info/setup_user_view.dart';
import 'package:dentalapp/ui/views/user_view/user_view.dart';
import 'package:dentalapp/ui/views/verify_email/verify_email_view.dart';
import 'package:dentalapp/ui/views/view_dental_note/view_dental_note.dart';
import 'package:dentalapp/ui/views/view_dental_notes_by_tooth/view_dental_note_by_tooth_view.dart';
import 'package:dentalapp/ui/views/view_patient_appointment/view_patient_appointment_view.dart';
import 'package:dentalapp/ui/views/view_patient_payments/view_patient_payment.dart';
import 'package:dentalapp/ui/widgets/selection_dentist/selection_dentist.dart';
import 'package:dentalapp/ui/widgets/selection_procedure/selection_procedure.dart';
import 'package:dentalapp/ui/widgets/success_view/success.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/edit_patient/edit_patient_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: PreLoaderView, name: 'PreLoader'),
    MaterialRoute(page: GetStartedView, name: 'GetStarted'),
    MaterialRoute(page: LoginView, name: 'Login'),
    MaterialRoute(page: RegisterView, name: 'Register'),
    MaterialRoute(page: VerifyEmailView, name: 'VerifyEmail'),
    MaterialRoute(page: SetUpUserView, name: 'SetUpUserView'),
    MaterialRoute(page: SuccessView, name: 'Success'),
    MaterialRoute(page: MainBodyView, name: 'MainBodyView'),
    MaterialRoute(page: HomePageView, name: 'HomePageView'),
    MaterialRoute(page: AppointmentView, name: 'AppointmentView'),
    MaterialRoute(page: MedicineView, name: 'MedicineView'),
    MaterialRoute(page: PatientsView, name: 'PatientsView'),
    MaterialRoute(page: ProceduresView, name: 'ProceduresView'),
    MaterialRoute(page: AddPatientView, name: 'AddPatientView'),
    MaterialRoute(
        page: AppointmentSelectPatientView,
        name: 'AppointmentSelectPatientView'),
    MaterialRoute(page: CreateAppointmentView, name: 'CreateAppointmentView'),
    MaterialRoute(page: AddMedicineView, name: 'AddMedicineView'),
    MaterialRoute(page: AddProcedureView, name: 'AddProcedureView'),
    CupertinoRoute(page: PatientInfoView, name: 'PatientInfoView'),
    MaterialRoute(page: MedicalHistoryView, name: 'MedicalHistoryView'),
    MaterialRoute(page: MedHistoryPhotoView, name: 'MedHistoryPhotoView'),
    MaterialRoute(page: PatientDentalChartView, name: 'PatientDentalChartView'),
    MaterialRoute(page: SetToothConditionView, name: 'SetToothConditionView'),
    MaterialRoute(page: SetDentalNoteView, name: 'SetDentalNoteView'),
    MaterialRoute(page: AddPaymentView, name: 'AddPaymentView'),
    MaterialRoute(page: NotificationView, name: 'NotificationView'),
    // MaterialRoute(page: ViewDentalNoteView, name: 'ViewDentalNoteView'),
    MaterialRoute(page: AddExpenseView, name: 'AddExpenseView'),
    MaterialRoute(page: ReportView, name: 'ReportView'),
    MaterialRoute(page: ViewPatientAppointment, name: 'ViewPatientAppointment'),
    MaterialRoute(page: ViewPatientPayment, name: 'ViewPatientPayment'),
    MaterialRoute(page: AddPrescriptionView, name: 'AddPrescriptionView'),
    MaterialRoute(page: PrescriptionView, name: 'PrescriptionView'),
    MaterialRoute(page: EditPatientView, name: 'EditPatientView'),
    MaterialRoute(page: DentalChartLegend, name: 'DentalChartLegend'),
    MaterialRoute(
        page: ViewAppointmentByPeriod, name: 'ViewAppointmentByPeriod'),
    MaterialRoute(
        page: DentalCertificationView, name: 'DentalCertificationView'),
    MaterialRoute(
        page: PaymentSelectPatientView, name: 'PaymentSelectPatientView'),
    CustomRoute(
        page: SelectionDentist,
        name: 'SelectionDentist',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectionProcedure,
        name: 'SelectionProcedure',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectionToothCondition,
        name: 'SelectionToothCondition',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UserView,
        name: 'UserView',
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 300),
    CustomRoute(
        page: PaymentSelectDentalNoteView,
        name: 'PaymentSelectDentalNoteView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: SelectMedicineView,
        name: 'SelectMedicineView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ReceiptView,
        name: 'ReceiptView',
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddExpenseItemView,
        name: 'AddExpenseItemView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddPrescriptionItemView,
        name: 'AddPrescriptionItemView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: AddCertificateView,
        name: 'AddCertificateView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ViewDentalNote,
        name: 'ViewDentalNote',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: ViewDentalNoteByToothView,
        name: 'ViewDentalNoteByToothView',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
    CustomRoute(
        page: UpdateProcedureView,
        name: 'UpdateProcedureViews',
        transitionsBuilder: TransitionsBuilders.slideBottom,
        durationInMilliseconds: 300),
  ],
  dependencies: [
    Singleton(classType: NavigationServiceImpl, asType: NavigationService),
    LazySingleton(classType: SnackBarServiceImpl, asType: SnackBarService),
    LazySingleton(classType: DialogServiceImpl, asType: DialogService),
    LazySingleton(
        classType: FirebaseAuthServiceImpl, asType: FirebaseAuthService),
    LazySingleton(classType: ValidatorServiceImpl, asType: ValidatorService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: ConnectivityStateCheck),
    LazySingleton(classType: ImageSelector),
    LazySingleton(classType: ApiServiceImpl, asType: ApiService),
    LazySingleton(classType: SessionServiceImpl, asType: SessionService),
    LazySingleton(classType: ToastServiceImpl, asType: ToastService),
    LazySingleton(classType: SearchIndexService),
    LazySingleton(
        classType: URLLauncherServiceImpl, asType: URLLauncherService),
    LazySingleton(classType: ConnectivityService),
    LazySingleton(classType: FirebaseMessagingService),
    LazySingleton(classType: PdfServiceImp, asType: PdfService),
  ],
  logger: StackedLogger(),
)
class App {}
