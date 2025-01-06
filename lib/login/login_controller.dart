import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/route/routes.dart';
import 'package:upfa/snackbar/snackbar.dart';

import 'login_model.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  TextEditingController controllerMobile = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  RxBool isButtonLoading = false.obs;
  sendOtp() async {
    try {
      isButtonLoading.value = true;
      if (loginFormKey.currentState?.validate() ?? false) {
        LoginResponseModel response = await ApiServices.login(body: {
          "phone_number1": controllerMobile.text.replaceAll("-", "").trim()
        });
        if ((response.error ?? "") == "") {
          Get.showSnackbar(GetSnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              messageText: AppSnackBar(
                text: "Your otp is ${response.otp ?? ""}",
              )));
          Get.toNamed(AppRoutes.otp, arguments: controllerMobile.text.trim());
        } else {
          Get.showSnackbar(GetSnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              messageText: AppSnackBar(
                text: response.error ?? "",
              )));
        }
      }
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(
            text: "Invalid Mobile Number",
          )));
    } finally {
      isButtonLoading.value = false;
    }
  }
}
