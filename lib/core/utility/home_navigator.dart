import 'package:dentalapp/app/app.router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigator extends StatelessWidget {
  final navigatorKeyId;
  const HomeNavigator({Key? key, required this.navigatorKeyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(navigatorKeyId),
      initialRoute: Routes.HomePageView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
