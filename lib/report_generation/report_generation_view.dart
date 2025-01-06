import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/report_generation/report_generation_controller.dart';
import 'package:upfa/report_generation/report_generation_model.dart';
import 'package:upfa/textfields/textfields.dart';
import 'package:upfa/validators/validations.dart';

class ReportGenerationView extends StatelessWidget {
  const ReportGenerationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Report Generation",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ReportGenerationController.to.location ?? "",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              // RichText(
              //   text: TextSpan(
              //       text: "Members : ",
              //       style: TextStyle(
              //           fontWeight: FontWeight.w600, color: AppColors.black),
              //       children: [
              //         TextSpan(
              //             text:
              //                 " ${ReportGenerationController.to.memberCount ?? " "}",
              //             style: TextStyle(
              //               fontWeight: FontWeight.normal,
              //               color: AppColors.black,
              //             ))
              //       ]),
              // )
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select User : ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                  width: 230.sp,
                  child: AppTextFormField(
                      onChange: (value) {
                        if (value.isEmpty) {
                          ReportGenerationController.to.users.clear();
                        } else {
                          ReportGenerationController.to.searchUser();
                        }
                      },
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 15.sp),
                      controller:
                          ReportGenerationController.to.controllerUserName,
                      header: "User")),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.sp),
            child: GetX<ReportGenerationController>(builder: (controller) {
              return controller.isLoading.value
                  ? LoadingBarsAnimation(
                      height: 200.sp,
                    )
                  : Column(
                      children: ReportGenerationController.to.users
                          .map((user) => ReportGenerationMemberContainer(
                                user: user,
                              ))
                          .toList(),
                    );
            }),
          ),
          Form(
            key: ReportGenerationController.to.reportGenerationFormKey,
            child: AppTextFormField(
              controller: ReportGenerationController.to.controllerReport,
              header: "Report",
              maxLInes: 5,
              maxLength: 500,
              validator: (value) => Validators.isEmpty(value: value),
              minLines: 4,
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          GetX<ReportGenerationController>(builder: (controller) {
            return GreenButton(
              text: "Submit Report",
              isLoading:
                  ReportGenerationController.to.isSubmitButtonLoading.value,
              onTap: () => ReportGenerationController.to.submit(),
            );
          })
        ],
      ),
    );
  }
}

class ReportGenerationMemberContainer extends StatelessWidget {
  SearchUsersResponseModel user;
  ReportGenerationMemberContainer({required this.user});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ReportGenerationController.to.selectedUser.value = user;
        ReportGenerationController.to.controllerUserName.text = user.name ?? "";
        ReportGenerationController.to.searchText.value = user.name ?? "";
      },
      child: Container(
        color: AppColors.white,
        margin: EdgeInsets.symmetric(vertical: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppNetworkImage(
                  imageUrl: user.image ?? "",
                  height: 50.sp,
                  width: 50.sp,
                  radius: 40.sp,
                ),
                SizedBox(
                  width: 15.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? "",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      user.phoneNumber ?? "",
                    )
                  ],
                ),
              ],
            ),
            GetX<ReportGenerationController>(builder: (controller) {
              return Icon(controller.selectedUser.value == user
                  ? Icons.check_box
                  : Icons.check_box_outline_blank);
            })
          ],
        ),
      ),
    );
  }
}
