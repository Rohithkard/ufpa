import 'package:get/get.dart';

import '../assets/images.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxInt currentIndex = 0.obs;
  List<String> sliderImages = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
    AppImages.banner4,
  ];

  String? aboutUFPA =
      "The United Farmers and Producers Association (UFPA) is an independent organization that originated from a WhatsApp group of Malayalee foreign farmers from Kerala. In the past three years, the UFPA has experienced significant growth, expanding to ten state members nationwide, with regional committees in states like Kerala, Tamil Nadu, Karnataka, and Chhattisgarh. The organization’s primary focus is to assist farmers through innovative farming methods, guidance on fertilizer application, and comprehensive support for those facing setbacks. Notably, the UFPA extends its commitment to farmers, by providing immediate assistance during emergencies, demonstrating a dedication to cooperation, love, care, and help.";
}
