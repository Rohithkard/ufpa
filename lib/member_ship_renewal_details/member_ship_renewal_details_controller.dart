import 'package:get/get.dart';
import 'package:upfa/member_ship_renewal/member_ship_renewal_model.dart';

class MemberShipRenewalDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MemberShipRenewalDetailsController());
  }
}

class MemberShipRenewalDetailsController extends GetxController {
  static MemberShipRenewalDetailsController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
    ArgumentModelForRenewalDetails argument = Get.arguments;
    validTo = argument.validityDate;
    amount = argument.amount;
    userName = argument.userName;
    amount = argument.amount;
  }

  String? extensionDuration = "1 year";
  DateTime? validTo;
  String? userName;
  String? area;
  int? amount;
}
