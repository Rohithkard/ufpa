import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/main.dart';

import '../constants/get_storage_constants.dart';
import '../route/routes.dart';
import '../snackbar/snackbar.dart';
import 'otp_model.dart';

class OtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}

class OtpController extends GetxController {
  static OtpController get to => Get.find();
  @override
  void onInit() {
    mobileNumber = Get.arguments;
  }

  Rx<ShowTimerState> showTimer = ShowTimerState.timer.obs;
  RxBool showIsOtpValid = false.obs;
  RxBool validateOtpButtonLoading = false.obs;
  resendOtp() {}
  validateOtp() async {
    try {
      validateOtpButtonLoading.value = true;
      OtpResponseModel response = await ApiServices.verifyOtp(body: {
        "phone_number1": mobileNumber?.replaceAll("-", ""),
        "otp": code.text
      });
      if ((response.token ?? "").isEmpty) {
        Get.showSnackbar(GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            messageText: AppSnackBar(
              text: response.message ?? "",
            )));
      } else {
        print(response.token);
        box.write(BoxKeys.token, response.token);
        box.write(BoxKeys.image, response.member?.image);
        box.write(BoxKeys.userID, response.member?.id);
        box.write(BoxKeys.area, response.member?.area);
        box.write(BoxKeys.membershipType, response.member?.membershipType);
        box.write(BoxKeys.editPermission,
            response.member?.editOption ?? false ? "1" : "0");
        box.write(BoxKeys.reportable,
            response.member?.reviewable ?? false ? "1" : "0");
        box.write(BoxKeys.reviewable,
            response.member?.reportable ?? false ? "1" : "0");
        Get.offAllNamed(AppRoutes.landingPage);
      }
    } catch (error) {
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(
            text: "OOPS something went wrong",
          )));
    } finally {
      validateOtpButtonLoading.value = false;
    }
  }

  String? mobileNumber;
  TextEditingController code = TextEditingController();
}
