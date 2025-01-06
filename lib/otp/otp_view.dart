import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/text_style/text_style.dart';

import '../app_buttons/app_buttons.dart';
import '../color/color.dart';
import '../constants/get_storage_constants.dart';
import '../count_down/count_down_view.dart';
import 'otp_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        backGroundColor: AppColors.green47,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.green93, AppColors.green47])),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          children: [
            SizedBox(
              height: 40.sp,
            ),
            Text(
              "OTP",
              style: interSemiBold.copyWith(
                  fontSize: 30.sp, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.sp,
            ),
            Text(
              "We send a OTP to ( ${OtpController.to.mobileNumber} ).Enter it here to verify your identity",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.white,
                height: 1,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55.sp),
              child: PinFieldAutoFill(
                controller: OtpController.to.code,
                decoration: BoxLooseDecoration(
                    textStyle: TextStyle(color: AppColors.white, fontSize: 18),
                    strokeColorBuilder:
                        PinListenColorBuilder(AppColors.white, AppColors.grey),
                    radius: Radius.circular(10.sp)),
                currentCode: "",
                onCodeSubmitted: (code) {
                  if (code.length == 4) {
                    OtpController.to.code.text = code;
                  }
                },
                onCodeChanged: (code) {
                  if (code?.length == 4) {
                    OtpController.to.code.text = code!;
                  }
                },
                codeLength: 4,
              ),
            ),
            GetX<OtpController>(
              builder: (controller) {
                return controller.showIsOtpValid.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "Please enter full Otp",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox();
              },
            ),
            SizedBox(
              height: 20.sp,
            ),
            GetX<OtpController>(builder: (controller) {
              return ResendOtp(
                timerState: controller.showTimer.value,
                onTap: () {
                  OtpController.to.resendOtp();
                },
                onEnd: () =>
                    OtpController.to.showTimer.value = ShowTimerState.text,
              );
            }),
            SizedBox(
              height: 90.sp,
            ),
            GetX<OtpController>(builder: (controller) {
              return WhiteButton(
                text: 'Verify OTP',
                isLoading: controller.validateOtpButtonLoading.value,
                onTap: () => OtpController.to.validateOtp(),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ResendOtp extends StatelessWidget {
  final ShowTimerState timerState;
  final void Function()? onTap;
  final void Function()? onEnd;
  const ResendOtp({
    super.key,
    required this.timerState,
    this.onTap,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    switch (timerState) {
      case ShowTimerState.timer:
        return AppCountDown(
          text: "Resend OTP in ",
          endDate: DateTime.now().add(
            const Duration(minutes: 1),
          ),
          onEnd: onEnd,
        );

      case ShowTimerState.text:
        return GestureDetector(
          onTap: onTap,
          child: Text(
            "Resend Otp",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        );

      case ShowTimerState.loading:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.sp,
              width: 25.sp,
              child: CircularProgressIndicator(color: AppColors.black),
            ),
          ],
        );
    }
  }
}
