import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class PreLoaderView extends StatelessWidget {
  const PreLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f7fe),
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
                      child: LiquidCustomProgressIndicator(
                        value: 0.5,
                        backgroundColor: Colors.blue[100],
                        valueColor: AlwaysStoppedAnimation(Color(0xff0165fe)),
                        direction: Axis.vertical,
                        shapePath: toothPath(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cagape Dental App',
                      style: TextStyle(
                        fontFamily: FontNames.gilRoy,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Version 1.0',
                  style: TextStyles.tsBody4(color: Palettes.kcNeutral5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//tooth path for liquid custom progress indicator
  Path toothPath() {
    Size size = Size(160, 160);
    return Path()
      ..moveTo(size.width * 0.6440000, size.height * 0.9375000)
      ..cubicTo(
          size.width * 0.5948500,
          size.height * 0.9375000,
          size.width * 0.5875000,
          size.height * 0.8827000,
          size.width * 0.5875000,
          size.height * 0.8500000)
      ..lineTo(size.width * 0.5876000, size.height * 0.8295500)
      ..cubicTo(
          size.width * 0.5881250,
          size.height * 0.7488000,
          size.width * 0.5889250,
          size.height * 0.6267250,
          size.width * 0.5433500,
          size.height * 0.5808750)
      ..cubicTo(
          size.width * 0.5312500,
          size.height * 0.5686750,
          size.width * 0.5166500,
          size.height * 0.5625000,
          size.width * 0.5000000,
          size.height * 0.5625000)
      ..cubicTo(
          size.width * 0.4833500,
          size.height * 0.5625000,
          size.width * 0.4687500,
          size.height * 0.5686750,
          size.width * 0.4566500,
          size.height * 0.5808500)
      ..cubicTo(
          size.width * 0.4111000,
          size.height * 0.6267000,
          size.width * 0.4119000,
          size.height * 0.7487750,
          size.width * 0.4124000,
          size.height * 0.8295250)
      ..lineTo(size.width * 0.4125000, size.height * 0.8500000)
      ..cubicTo(
          size.width * 0.4125000,
          size.height * 0.8827000,
          size.width * 0.4051500,
          size.height * 0.9375000,
          size.width * 0.3559750,
          size.height * 0.9375000)
      ..cubicTo(
          size.width * 0.2996000,
          size.height * 0.9375000,
          size.width * 0.2812250,
          size.height * 0.8492500,
          size.width * 0.2599500,
          size.height * 0.7470500)
      ..cubicTo(
          size.width * 0.2530750,
          size.height * 0.7139750,
          size.width * 0.2459250,
          size.height * 0.6797750,
          size.width * 0.2370500,
          size.height * 0.6467500)
      ..cubicTo(
          size.width * 0.2232500,
          size.height * 0.5966500,
          size.width * 0.1998500,
          size.height * 0.5499000,
          size.width * 0.1772000,
          size.height * 0.5046750)
      ..cubicTo(
          size.width * 0.1439500,
          size.height * 0.4382000,
          size.width * 0.1125000,
          size.height * 0.3754000,
          size.width * 0.1125000,
          size.height * 0.3071500)
      ..cubicTo(
          size.width * 0.1125000,
          size.height * 0.1425250,
          size.width * 0.1960750,
          size.height * 0.06250000,
          size.width * 0.3680000,
          size.height * 0.06250000)
      ..cubicTo(
          size.width * 0.4012500,
          size.height * 0.06250000,
          size.width * 0.4594000,
          size.height * 0.07175000,
          size.width * 0.4896500,
          size.height * 0.08505000)
      ..lineTo(size.width * 0.4919000, size.height * 0.08602500)
      ..cubicTo(
          size.width * 0.4919000,
          size.height * 0.08602500,
          size.width * 0.4944250,
          size.height * 0.08610000,
          size.width * 0.4944500,
          size.height * 0.08610000)
      ..cubicTo(
          size.width * 0.5002250,
          size.height * 0.08610000,
          size.width * 0.5044000,
          size.height * 0.08502500,
          size.width * 0.5052250,
          size.height * 0.08480000)
      ..cubicTo(
          size.width * 0.5062250,
          size.height * 0.08450000,
          size.width * 0.5811250,
          size.height * 0.06247500,
          size.width * 0.6226750,
          size.height * 0.06247500)
      ..cubicTo(
          size.width * 0.7086250,
          size.height * 0.06247500,
          size.width * 0.7786250,
          size.height * 0.08737500,
          size.width * 0.8252000,
          size.height * 0.1344500)
      ..cubicTo(
          size.width * 0.8667750,
          size.height * 0.1765000,
          size.width * 0.8883000,
          size.height * 0.2361500,
          size.width * 0.8875000,
          size.height * 0.3069750)
      ..cubicTo(
          size.width * 0.8875000,
          size.height * 0.3753250,
          size.width * 0.8560750,
          size.height * 0.4381500,
          size.width * 0.8228000,
          size.height * 0.5046500)
      ..cubicTo(
          size.width * 0.8001750,
          size.height * 0.5498750,
          size.width * 0.7767500,
          size.height * 0.5966250,
          size.width * 0.7629500,
          size.height * 0.6466500)
      ..cubicTo(
          size.width * 0.7539500,
          size.height * 0.6797000,
          size.width * 0.7467500,
          size.height * 0.7141750,
          size.width * 0.7397750,
          size.height * 0.7475500)
      ..cubicTo(
          size.width * 0.7193500,
          size.height * 0.8452500,
          size.width * 0.7001000,
          size.height * 0.9375000,
          size.width * 0.6440000,
          size.height * 0.9375000)
      ..close();
  }
}
