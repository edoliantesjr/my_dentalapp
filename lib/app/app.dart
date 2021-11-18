import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service_imp.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service_impl.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service_impl.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service_impl.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/core/service/validator/validator_service_impl.dart';
import 'package:dentalapp/core/utility/connectivity_state.dart';
import 'package:dentalapp/core/utility/image_selector.dart';
import 'package:dentalapp/ui/views/get_started/get_started_view.dart';
import 'package:dentalapp/ui/views/login/login_view.dart';
import 'package:dentalapp/ui/views/pre_loader/pre_loader_view.dart';
import 'package:dentalapp/ui/views/register/register_view.dart';
import 'package:dentalapp/ui/views/update_user_info/setup_user_view.dart';
import 'package:dentalapp/ui/views/verify_email/verify_email_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: PreLoaderView, name: 'PreLoader'),
    CupertinoRoute(page: GetStartedView, name: 'GetStarted', initial: true),
    CupertinoRoute(page: LoginView, name: 'Login'),
    CupertinoRoute(page: RegisterView, name: 'Register'),
    CupertinoRoute(page: VerifyEmailView, name: 'VerifyEmail'),
    CupertinoRoute(page: SetUpUserView, name: 'SetUpUserView')
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
  ],
  logger: StackedLogger(),
)
class App {}
