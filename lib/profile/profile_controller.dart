import 'package:get/get.dart';
import 'package:upfa/profile/profile_model.dart';

import '../api_services/api_services.dart';
import '../constants/get_storage_constants.dart';
import '../main.dart';

class ProfileControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading.value = true;
      await getMemberDetails();
      isError.value = false;
    } catch (error) {
      isError.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  getMemberDetails() async {
    UserDetailsResponseModel response = await ApiServices.memberDetails(
        id: box.read(BoxKeys.userID).toString());
    userName = response.name;
    area = response.area;
    address = "${response.address1} ${response.address2}${response.address3}";
    phoneNumber = response.phoneNumber;
    email = response.email;
    bloodGroup = response.bloodGroup;
    qrCode = response.qrCode;
    userImage = response.image;
    isEditable.value = response.editOption ?? false;
    box.write(
        BoxKeys.editPermission, response?.editOption ?? false ? "1" : "0");
    box.write(BoxKeys.reportable, response?.reviewable ?? false ? "1" : "0");
    box.write(BoxKeys.reviewable, response?.reportable ?? false ? "1" : "0");
  }

  RxBool isEditable = false.obs;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  String? address;
  String? userName;
  String? area;
  String? phoneNumber;
  String? email;
  String? bloodGroup;
  String? userImage;
  String? qrCode;
}
