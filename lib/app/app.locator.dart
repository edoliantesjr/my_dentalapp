// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../core/service/dialog/dialog_service.dart';
import '../core/service/dialog/dialog_service_imp.dart';
import '../core/service/firebase_auth/firebase_auth_service.dart';
import '../core/service/firebase_auth/firebase_auth_service_impl.dart';
import '../core/service/navigation/navigation_service.dart';
import '../core/service/navigation/navigation_service_impl.dart';
import '../core/service/snack_bar/snack_bar_service.dart';
import '../core/service/snack_bar/snack_bar_service_impl.dart';
import '../core/service/validator/validator_service.dart';
import '../core/service/validator/validator_service_impl.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<FirebaseAuthService>(
      () => FirebaseAuthServiceImpl());
  locator.registerLazySingleton<ValidatorService>(() => ValidatorServiceImpl());
}
