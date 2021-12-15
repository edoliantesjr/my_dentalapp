import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/main.dart';
import 'package:dentalapp/ui/views/pre_loader/pre_loader_view_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
        backgroundColor: Palettes.kcBlueMain1,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  child: SlideAnimation(
                    duration: Duration(milliseconds: 500),
                    verticalOffset: 90,
                    child: FadeInAnimation(
                      duration: Duration(milliseconds: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 130,
                              width: 130,
                              child: Image.asset('assets/icons/logo.png')),
                          SizedBox(height: 10),
                          Text(
                            'Cagape Dental Care',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontNames.gilRoy,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              letterSpacing: 1,
                              wordSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Version $appVersion',
                    style: TextStyles.tsBody4(color: Palettes.kcNeutral5),
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
