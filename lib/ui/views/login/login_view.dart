import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/login/login_view.form.dart';
import 'package:dentalapp/ui/views/login/login_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (model) {
        disposeForm();
        model.logger.d('login form disposed');
      },
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              width: screenWidth(context),
              height: screenHeight(context),
              color: Palettes.kcBlueMain1,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        model.navigationService.pop();
                      },
                      color: Colors.white,
                      icon: SvgPicture.asset(
                        'assets/icons/arrow-back-white.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 150.h),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                          key: model.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 60.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Enter your email account to login',
                                  style: TextStyles.tsHeading4(
                                      color: Palettes.kcNeutral2),
                                ),
                              ),
                              SizedBox(height: 10.h),

                              //Email Text Field
                              TextFormField(
                                controller: emailController,
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: model.autoValidate
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                validator: (value) => model.validatorService
                                    .validateEmailAddress(value!),
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Your Email Account',
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 20),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 22.h,
                                    width: 21.w,
                                    child: SvgPicture.asset(
                                      'assets/icons/Message.svg',
                                      color: emailFocusNode.hasFocus
                                          ? Palettes.kcBlueMain1
                                          : Palettes.kcNeutral2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),

                              //Password Text Field
                              TextFormField(
                                controller: passwordController,
                                focusNode: passwordFocusNode,
                                obscureText: model.isObscure,
                                autovalidateMode: model.autoValidate
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                textInputAction: TextInputAction.go,
                                onChanged: (value) =>
                                    model.setShowIconVisibility(),
                                onEditingComplete: () => model.loginNow(),
                                validator: (value) => model.validatorService
                                    .validatePassword(value!),
                                decoration: InputDecoration(
                                  hintText: 'Your Password',
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 20),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      'assets/icons/Lock.svg',
                                      color: passwordFocusNode.hasFocus
                                          ? Palettes.kcBlueMain1
                                          : Palettes.kcNeutral2,
                                    ),
                                  ),
                                  suffixIcon: Visibility(
                                    visible: model.isShowIconVisible,
                                    child: IconButton(
                                        onPressed: model.showHidePassword,
                                        padding: EdgeInsets.zero,
                                        icon: SvgPicture.asset(
                                          model.isObscure
                                              ? 'assets/icons/Show.svg'
                                              : 'assets/icons/Hide.svg',
                                          color: Palettes.kcBlueMain1,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.end,
                                  style: TextStyles.tsHeading5(
                                      color: Palettes.kcNeutral2),
                                ),
                              ),
                              SizedBox(height: 25.h),
                              Container(
                                height: 45.sp,
                                width: screenWidth(context),
                                child: ElevatedButton(
                                  onPressed: () {
                                    model.loginNow();
                                  },
                                  child: Text('Login'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SocialLogin(
                          goToRegister: () => model.goToRegisterView(),
                        ),
                      ],
                    ),
                  ),
                  LoginOverlay()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SocialLogin extends StatelessWidget {
  final VoidCallback goToRegister;
  const SocialLogin({Key? key, required this.goToRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Text(
            'Or login with..',
            style: TextStyles.tsBody2(color: Palettes.kcNeutral2),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50.h,
                  width: 100.w,
                  padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palettes.kcNeutral5),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    'assets/icons/google.svg',
                  ),
                ),
              ),
              SizedBox(width: 20.h),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50.h,
                  width: 100.w,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palettes.kcNeutral5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image(image: AssetImage('assets/icons/facebook.png')),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyles.tsHeading5(),
              ),
              GestureDetector(
                onTap: () => goToRegister(),
                child: Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Palettes.kcBlueMain2))),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontFamily: FontNames.gilRoy,
                          fontWeight: FontWeight.w600,
                          fontSize: kfsHeading5.sp,
                          color: Palettes.kcBlueMain2),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class LoginOverlay extends StatelessWidget {
  const LoginOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 11.h,
      left: 80.w,
      child: Image(
        image: AssetImage('assets/images/loginoverlay.png'),
        height: 210.h,
        width: 210.w,
        fit: BoxFit.contain,
      ),
    );
  }
}
