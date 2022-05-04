import 'package:animate_do/animate_do.dart';
import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/main.dart';
import 'package:dentalapp/ui/views/pre_loader/pre_loader_view_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class PreLoaderView extends StatelessWidget {
  const PreLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreLoaderViewModel>.nonReactive(
      viewModelBuilder: () => PreLoaderViewModel(),
      onModelReady: (model) async {
        model.getSessionInfo();
      },
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.grey.shade50,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bounce(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/icons/logo-blue-circle.png',
                              ))),
                    ),
                    SizedBox(height: 10),
                    FadeIn(
                      delay: Duration(milliseconds: 1100),
                      duration: Duration(milliseconds: 400),
                      child: Text(
                        'Maglinte Dental Clinic',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontNames.gilRoy,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          letterSpacing: 1,
                          wordSpacing: 1,
                          color: Palettes.kcBlueMain1,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FadeIn(
                        child: CircularProgressIndicator(
                      color: Palettes.kcBlueMain1,
                      strokeWidth: 5,
                    )),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Version $appVersion',
                    style: TextStyles.tsBody4(color: Palettes.kcNeutral1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
