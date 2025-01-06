import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/profile_edit/profile_edit_controller.dart';
import 'package:upfa/textfields/textfields.dart';
import 'package:upfa/validators/validations.dart';

import '../app_bar/app_bar.dart';
import '../constants/get_storage_constants.dart';
import '../main.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithImage(
        title: "Profile",
        imageUrl: box.read(BoxKeys.image) ?? "",
      ),
      body: GetX<ProfileEditController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : Form(
                    key: ProfileEditController.to.editProfileFormKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 10.sp),
                      children: [
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEMail(value ?? ""),
                            controller:
                                ProfileEditController.to.controllerEmail,
                            header: "Email"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isMobile(value ?? "", 10, 10),
                            maxLength: 10,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller:
                                ProfileEditController.to.controllerPhoneNumber,
                            header: "phone number"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            controller:
                                ProfileEditController.to.controllerAddress1,
                            header: "Address1"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            controller:
                                ProfileEditController.to.controllerAddress2,
                            header: "Address2"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            controller:
                                ProfileEditController.to.controllerAddress3,
                            header: "Address3"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppDropDownFormField(
                            header: "Blood Group",
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            onChange: (value) => ProfileEditController
                                .to.selectedBloodGroup = value,
                            value: ProfileEditController.to.selectedBloodGroup,
                            itemList: ProfileEditController.to.bloodGroups,
                            label: (bloodGroup) => bloodGroup),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            controller: ProfileEditController
                                .to.controllerEmergencyContactName,
                            header: "Emergency contact name"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isMobile(value ?? "", 10, 10),
                            maxLength: 10,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: ProfileEditController
                                .to.controllerEmergencyContactNumber,
                            header: "Emergency contact number"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isEmpty(value: value),
                            controller: ProfileEditController
                                .to.controllerRelationWithEmergencyContact,
                            header: "Relation with emergency contact"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        AppTextFormField(
                            showBanner: true,
                            validator: (value) =>
                                Validators.isMobile(value ?? "", 10, 10),
                            maxLength: 10,
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: ProfileEditController
                                .to.controllerWhatsAppNumber,
                            header: "whats app number"),
                        SizedBox(
                          height: 20.sp,
                        ),
                        GetX<ProfileEditController>(builder: (controller) {
                          return GreenButton(
                              onTap: () =>
                                  ProfileEditController.to.updateProfile(),
                              isLoading: controller.isButtonLoading.value,
                              text: "Edit");
                        }),
                        SizedBox(
                          height: 20.sp,
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
