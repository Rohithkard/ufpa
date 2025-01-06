import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/profile/profile_controller.dart';

import '../main.dart';
import '../profile/profile_model.dart';
import '../snackbar/snackbar.dart';

class ProfileEditControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileEditController());
  }
}

class ProfileEditController extends GetxController {
  Future<void> onInit() async {
    super.onInit();

    try {
      isLoading.value = true;
      UserDetailsResponseModel response = await ApiServices.memberDetails(
          id: box.read(BoxKeys.userID).toString());
      print(box.read(BoxKeys.userID).toString());
      controllerPhoneNumber.text = response.phoneNumber ?? "";
      controllerEmail.text = response.email ?? "";
      controllerAddress1.text = response.address1 ?? "";
      controllerAddress2.text = response.address2 ?? "";
      controllerAddress3.text = response.address3 ?? "";
      selectedBloodGroup = response.bloodGroup?.toUpperCase();
      controllerEmergencyContactName.text = response.emergencyContactName ?? "";
      controllerEmergencyContactNumber.text =
          response.emergencyContactNumber ?? "";
      controllerRelationWithEmergencyContact.text = response.relation ?? "";
      controllerWhatsAppNumber.text = response.phoneNumber2 ?? "";

      isError.value = false;
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  GlobalKey<FormState> editProfileFormKey = GlobalKey();
  updateProfile() async {
    if (editProfileFormKey.currentState?.validate() ?? false) {
      try {
        isButtonLoading.value = true;
        var response = await ApiServices.upDateProfile(body: {
          "pk": box.read(BoxKeys.userID),
          "email": controllerEmail.text,
          "phone_number1": controllerPhoneNumber.text,
          "address1": controllerAddress1.text,
          "address2": controllerAddress2.text,
          "address3": controllerAddress3.text,
          "blood_group": selectedBloodGroup,
          "emergency_contact_name": controllerEmergencyContactName.text,
          "emergency_contact_number": controllerEmergencyContactNumber.text,
          "relation": controllerRelationWithEmergencyContact.text,
        });
        ProfileController.to.onInit();
        isButtonLoading.value = false;
        Get.back();
      } catch (error) {
        Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            messageText: AppSnackBar(
              text: "OOPS Something went wrong",
            )));
      } finally {
        isButtonLoading.value = false;
      }
    }
  }

  RxBool isButtonLoading = false.obs;

  static ProfileEditController get to => Get.find();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerAddress1 = TextEditingController();
  TextEditingController controllerAddress2 = TextEditingController();
  TextEditingController controllerAddress3 = TextEditingController();
  TextEditingController controllerEmergencyContactName =
      TextEditingController();
  TextEditingController controllerEmergencyContactNumber =
      TextEditingController();
  TextEditingController controllerRelationWithEmergencyContact =
      TextEditingController();
  TextEditingController controllerWhatsAppNumber = TextEditingController();
  List<String?> bloodGroups = [
    "A+VE",
    "A-VE",
    "B+VE",
    "B-VE",
    "O+VE",
    "O-VE",
    "AB+VE",
    "AB-VE",
  ];
  String? selectedBloodGroup;
}
