import 'package:dentalapp/constants/styles/button_style.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/get_started/get_started_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GetStartedViewModel>.reactive(
      viewModelBuilder: () => GetStartedViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Palettes.kcBlueMain1,
          body: SafeArea(
            child: Container(
              height: screenHeight(context),
              width: screenWidth(context),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: model.goToLoginView,
                      child: Text('Skip'),
                      style: TextButton.styleFrom(primary: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: PageView.builder(
                      itemCount: model.listOfDetails.length,
                      physics: BouncingScrollPhysics(),
                      clipBehavior: Clip.none,
                      onPageChanged: (index) => model.indexChange(index),
                      itemBuilder: (context, index) => CarouselItem(
                          image: model.listOfDetails[index].image,
                          title: model.listOfDetails[index].title,
                          description: model.listOfDetails[index].description),
                    ),
                  ),
                  Spacer(),
                  RowPageIndicator(index: model.index),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.h,
                    child: ElevatedButton(
                      onPressed: model.goToLoginView,
                      child: Text('Get Started'),
                      style: ButtonStyles.whiteButtonStyle(isBold: true),
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

//carousel Item
class CarouselItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CarouselItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: 270.h,
            width: 270.w,
          ),
          Text(
            title,
            style: TextStyles.tsHeading2(color: Colors.white),
          ),
          SizedBox(height: 20.sp),
          Text(
            description,
            style: TextStyles.tsHeading5(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

//Row Page Indicator
class RowPageIndicator extends StatelessWidget {
  final int index;

  const RowPageIndicator({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          height: 8.h,
          width: 8.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 0 ? Colors.white : Colors.purple[200]),
        ),
        Container(
          margin: EdgeInsets.only(right: 5),
          height: 8.h,
          width: 8.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 1 ? Colors.white : Colors.purple[200]),
        ),
        Container(
          height: 8.h,
          width: 8.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 2 ? Colors.white : Colors.purple[200]),
        )
      ],
    );
  }
}
