import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/button_style.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'success_view_model.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SuccessViewModel>.nonReactive(
      viewModelBuilder: () => SuccessViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            var willPop = await model.navigationService
                .popAllAndPushNamed(Routes.MainBodyView);
            return willPop != null ? true : false;
          },
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff136AFB),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/success.png',
                          height: 350,
                          width: 350,
                        ),
                        Text(
                          'Success!',
                          style: TextStyles.tsHeading2(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => model.navigationService
                          .popAllAndPushNamed(Routes.MainBodyView),
                      child: const Text(
                        "Let's start the app",
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyles.whiteButtonStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
