import 'package:get/get.dart';
import 'package:upfa/constants/get_storage_constants.dart';
import 'package:upfa/route/routes.dart';

import '../main.dart';

class SplashControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () => splashConfig());
  }

  splashConfig() {
    String? token = box.read(BoxKeys.token);
    print(token);
    if ((token ?? "").isEmpty) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.landingPage);
    }
  }
}
