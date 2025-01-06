import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/login/login_controller.dart';
import 'package:upfa/text_style/text_style.dart';
import 'package:upfa/validators/validations.dart';

import '../app_buttons/app_buttons.dart';
import '../color/color.dart';
import '../text_input_formatter/text_input_formater.dart';
import '../textfields/textfields.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.green93, AppColors.green47])),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 0),
          children: [
            SizedBox(
              height: 200.sp,
            ),
            Text(
              "Log in",
              style: interSemiBold.copyWith(
                  fontSize: 30.sp, color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 34.sp,
            ),
            Form(
              key: LoginController.to.loginFormKey,
              child: AppTextFormField(
                controller: LoginController.to.controllerMobile,
                header: "Mobile Number",
                maxLength: 12,
                textInputType: TextInputType.number,
                inputFormatters: [
                  MaskedTextInputFormatter(
                    mask: "XX-XXXX-XXXX",
                    separator: "-",
                  )
                ],
                validator: (value) => Validators.isMobile(value, 12, 12),
              ),
            ),
            SizedBox(
              height: 82.sp,
            ),
            GetX<LoginController>(builder: (controller) {
              return WhiteButton(
                text: 'Send OTP',
                isLoading: controller.isButtonLoading.value,
                onTap: () => LoginController.to.sendOtp(),
              );
            })
          ],
        ),
      ),
    );
  }
}
