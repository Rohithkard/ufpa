import 'package:get/get.dart';

import '../api_services/api_services.dart';
import '../constants/get_storage_constants.dart';
import '../main.dart';
import '../profile/profile_model.dart';

class MemberShipRenewalControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberShipRenewalController());
  }
}

class MemberShipRenewalController extends GetxController {
  static MemberShipRenewalController get to => Get.find();
  @override
  Future<void> onInit() async {
    super.onInit();
    print(box.read(BoxKeys.userID));
    try {
      isLoading.value = true;

      await getRenewalDetails();
      await getMemberDetails();
      isError.value = false;
    } catch (error) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  getRenewalDetails() async {
    var response = await ApiServices.getRenewalDetails(
        body: {"member_id": box.read(BoxKeys.userID).toString()});
    daysToRenewal = response.days;
    amount = response.amount;
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

    validityExtensionDate = response.membershipValidity;
  }

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  String? address;
  String? userName;
  int? daysToRenewal;
  int? amount;
  String? area;
  String? phoneNumber;
  DateTime? validityExtensionDate;
  String? email;
  String? bloodGroup;
  String? userImage;
  String? qrCode;
}
