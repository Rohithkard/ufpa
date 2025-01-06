import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/main.dart';
import 'package:upfa/report_generation/report_generation_model.dart';

import '../snackbar/snackbar.dart';

class ReportGenerationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportGenerationController());
  }
}

class ReportGenerationController extends GetxController {
  static ReportGenerationController get to => Get.find();

  GlobalKey<FormState> reportGenerationFormKey = GlobalKey();
  searchUser() async {
    try {
      isLoading.value = true;
      users.value = await ApiServices.search(
          queryParameter: {"q": controllerUserName.text});
      isError.value = false;
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isSubmitButtonLoading = false.obs;
  submit() async {
    if (selectedUser.value == null) {
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(
            text: "Please select a user",
          )));
    } else {
      try {
        isSubmitButtonLoading.value = true;
        if (reportGenerationFormKey.currentState?.validate() ?? false) {
          var response = await ApiServices.sendReport(body: {
            "member": selectedUser.value?.id,
            "report": controllerReport.text
          });
          Get.back();
          Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              messageText: AppSnackBar(
                text: "Report generated successfully",
              )));
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
        isSubmitButtonLoading.value = false;
      }
    }
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  String? location = box.read(BoxKeys.area);
  int? memberCount = 200;
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerReport = TextEditingController();
  RxString searchText = "".obs;
  Rx<SearchUsersResponseModel?> selectedUser =
      Rx<SearchUsersResponseModel?>(null);
  RxList<SearchUsersResponseModel> users = <SearchUsersResponseModel>[].obs;
}
