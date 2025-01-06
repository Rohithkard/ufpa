import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_services/api_services.dart';
import '../profile/profile_model.dart';
import '../snackbar/snackbar.dart';
import '../user_review_listing/user_review_model.dart';

class UserReviewDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserReviewDetailsController());
  }
}

class UserReviewDetailsController extends GetxController {
  static UserReviewDetailsController get to => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      member = Get.arguments;
      await getMemberDetails();
      isError.value = false;
    } catch (error) {
      isError.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isReviewButtonLoading = false.obs;

  TextEditingController controllerReview = TextEditingController();
  submit() async {
    if (userReviewFormKey.currentState?.validate() ?? false) {
      try {
        isReviewButtonLoading.value = true;
        var response = await ApiServices.sendReview(
            body: {"member": member?.id, "review": controllerReview.text});
        Get.back();
        Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            messageText: AppSnackBar(
              text: "Review added successfully",
            )));
      } catch (error) {
        Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            messageText: AppSnackBar(
              text: "OOPs Something went wrong",
            )));
      } finally {}
      isReviewButtonLoading.value = false;
    }
  }

  Users? member;
  GlobalKey<FormState> userReviewFormKey = GlobalKey();
  getMemberDetails() async {
    UserDetailsResponseModel response =
        await ApiServices.memberDetails(id: member!.id.toString());
    userName = response.name;
    area = response.area;
    address = "${response.address1} ${response.address2}${response.address3}";
    phoneNumber = response.phoneNumber;
    email = response.email;
    bloodGroup = response.bloodGroup;
    qrCode = response.qrCode;
    userImage = response.image;
    memberValidity = response.membershipValidity;
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  String? address;
  String? userName;
  String? area;
  String? phoneNumber;
  String? email;
  String? bloodGroup;
  DateTime? memberValidity;
  String? userImage;
  String? qrCode;
}
