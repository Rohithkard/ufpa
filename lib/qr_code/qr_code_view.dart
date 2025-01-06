import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_buttons/app_buttons.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/qr_code/qr_code_controller.dart';
import 'package:upfa/record_entry/record_entry_model.dart';
import 'package:upfa/route/routes.dart';

class QrCodeScannerView extends StatelessWidget {
  const QrCodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "QR Code",
        backGroundColor: AppColors.green93,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.sp),
        shrinkWrap: true,
        children: [
          GetX<QrCodeScannerController>(builder: (controller) {
            return (controller.guest.value == null)
                ? SizedBox(
                    height: 500.sp,
                    width: 500.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.sp),
                      child: QRView(
                        key: QrCodeScannerController.to.qrKey,
                        onQRViewCreated: (qrController) =>
                            QrCodeScannerController.to
                                .onQRViewCreated(qrController),
                      ),
                    ))
                : AppNetworkImage(
                    height: 300.sp,
                    width: 300.sp,
                    imageUrl: controller.guest.value?.image ?? "");
          }),
          GetX<QrCodeScannerController>(builder: (controller) {
            return (controller.guest.value != null)
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 10.sp),
                    child: Text(
                      controller.guest.value?.name ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.sp),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox(
                    height: 30.sp,
                  );
          }),
          GetX<QrCodeScannerController>(builder: (controller) {
            return (controller.guest.value == null)
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GreenButton(
                          width: 150.sp,
                          text: "Verify",
                          onTap: () {
                            Get.toNamed(AppRoutes.recordEntry,
                                arguments: ArgumentModelForRecordEntry(
                                    user:
                                        QrCodeScannerController.to.guest.value,
                                    events: Get.arguments));
                          }),
                      GreenButton(
                          width: 150.sp,
                          text: "Retake",
                          onTap: () {
                            QrCodeScannerController.to.controller
                                ?.resumeCamera();
                            QrCodeScannerController.to.guest.value = null;
                          }),
                    ],
                  );
          })
        ],
      ),
    );
  }
}
