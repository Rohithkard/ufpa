import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/record_entry/record_entry_model.dart';

import '../events/event_model.dart';
import '../profile/profile_model.dart';
import '../snackbar/snackbar.dart';

class RecordEntryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecordEntryController());
  }
}

class RecordEntryController extends GetxController {
  static RecordEntryController get to => Get.find();
  @override
  Future<void> onInit() async {
    super.onInit();
    // try {
    //   isLoading.value = true;
    ArgumentModelForRecordEntry? argument = Get.arguments;
    user = argument?.user ?? UserDetailsResponseModel(id: 2204);
    events = argument?.events ?? GetEventsResponseModel(id: 1);
    await getEventUserCount();
    // } catch (error) {
    //   isError.value = true;
    // } finally {
    //   isLoading.value = false;
    // }
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  GlobalKey<FormState> recordEntryFormKey = GlobalKey();
  getEventUserCount() async {
    GetEventUserCountResponseModel response = await ApiServices.eventUserCount(
        queryParameter: {
          "user_id": "${user?.id ?? 0}",
          "event_id": "${events?.id ?? 0}"
        });
    childCount.text = response.childCount.toString();
    adultCount.text = response.adultCount.toString();
  }

  RxBool isButtonLoading = false.obs;
  addUserCount() async {
    try {
      isButtonLoading.value = true;
      await ApiServices.addUserCount(body: {
        "adult_count": adultCount.text,
        "child_count": childCount.text,
        "allotted_pass_count": "10",
        "user_id": "${user?.id ?? 0}",
        "event_id": "${events?.id ?? 0}"
      });
      Get.back();
      Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(
            text: "Data added successfully",
          )));
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        messageText:
            AppSnackBar(text: error.toString() ?? "OOPS Something went wrong"),
      ));
    } finally {
      isButtonLoading.value = false;
    }
  }

  UserDetailsResponseModel? user;
  GetEventsResponseModel? events;

  TextEditingController allottedPass = TextEditingController();
  TextEditingController adultCount = TextEditingController();
  TextEditingController childCount = TextEditingController();
  TextEditingController remark = TextEditingController();
}
