import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upfa/api_services/api_services.dart';
import 'package:upfa/snackbar/snackbar.dart';

import '../profile/profile_model.dart';

class QrCodeScannerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrCodeScannerController());
  }
}

class QrCodeScannerController extends GetxController {
  static QrCodeScannerController get to => Get.find();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Rx<UserDetailsResponseModel?> guest = Rx<UserDetailsResponseModel?>(null);

  QRViewController? controller;
  void onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      try {
        Barcode? result = scanData;
        String qrCode = result.code ?? "";

        String? guestId = qrCode.split("/").lastOrNull;
        if (guestId?.length == 1) {
          guestId = "UI A000$guestId";
        } else if (guestId?.length == 2) {
          guestId = "UI A00$guestId";
        } else if (guestId?.length == 3) {
          guestId = "UI A0$guestId";
        } else if (guestId?.length == 4) {
          guestId = "UI A$guestId";
        } else {
          controller.resumeCamera();
          Get.showSnackbar(const GetSnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              messageText: AppSnackBar(
                text: "Invalid QR code",
              )));
        }

        getUserDetails(guestId);
        controller.pauseCamera();
      } catch (error) {
        controller.resumeCamera();
        Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            messageText: AppSnackBar(
              text: "Invalid QR code",
            )));
      }
    });
  }

  getUserDetails(userId) async {
    try {
      guest.value = await ApiServices.getGuestUserDetails(id: userId);
    } catch (error) {
      controller?.resumeCamera();
      Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          messageText: AppSnackBar(
            text: "Invalid User",
          )));
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
