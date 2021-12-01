// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/views/get_started/get_started_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/main_body/main_body_view.dart';
import '../ui/views/pre_loader/pre_loader_view.dart';
import '../ui/views/register/register_view.dart';
import '../ui/views/update_user_info/setup_user_view.dart';
import '../ui/views/verify_email/verify_email_view.dart';
import '../ui/widgets/success_view/success.dart';

class Routes {
  static const String PreLoader = '/pre-loader-view';
  static const String GetStarted = '/';
  static const String Login = '/login-view';
  static const String Register = '/register-view';
  static const String VerifyEmail = '/verify-email-view';
  static const String SetUpUserView = '/set-up-user-view';
  static const String Success = '/success-view';
  static const String MainBodyView = '/main-body-view';
  static const all = <String>{
    PreLoader,
    GetStarted,
    Login,
    Register,
    VerifyEmail,
    SetUpUserView,
    Success,
    MainBodyView,
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
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    PreLoaderView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const PreLoaderView(),
        settings: data,
      );
    },
    GetStartedView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const GetStartedView(),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginView(key: args.key),
        settings: data,
      );
    },
    RegisterView: (data) {
      var args = data.getArgs<RegisterViewArguments>(
        orElse: () => RegisterViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => RegisterView(key: args.key),
        settings: data,
      );
    },
    VerifyEmailView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const VerifyEmailView(),
        settings: data,
      );
    },
    SetUpUserView: (data) {
      var args = data.getArgs<SetUpUserViewArguments>(
        orElse: () => SetUpUserViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SetUpUserView(key: args.key),
        settings: data,
      );
    },
    SuccessView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SuccessView(),
        settings: data,
      );
    },
    MainBodyView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const MainBodyView(),
        settings: data,
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
  SetUpUserViewArguments({this.key});
}
