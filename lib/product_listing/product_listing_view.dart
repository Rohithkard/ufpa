import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upfa/app_bar/app_bar.dart';
import 'package:upfa/app_network_image/app_network_image.dart';
import 'package:upfa/color/color.dart';
import 'package:upfa/error_page/error_page.dart';
import 'package:upfa/loading_animation/loading_animation.dart';
import 'package:upfa/product_listing/product_listing_controller.dart';
import 'package:upfa/product_listing/product_listing_model.dart';
import 'package:upfa/route/routes.dart';
import 'package:upfa/textfields/textfields.dart';

class ProductListingView extends StatelessWidget {
  const ProductListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "UFPA CO",
        backGroundColor: AppColors.green93,
      ),
      body: GetX<ProductListingController>(builder: (controller) {
        return controller.isLoading.value
            ? LoadingBarsAnimation()
            : controller.isError.value
                ? ErrorPage()
                : ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.sp, vertical: 20.sp),
                    controller: ProductListingController.to.scrollController,
                    children: [
                      AppTextFormField(
                          controller:
                              ProductListingController.to.controllerSearch,
                          header: "Search Products"),
                      SizedBox(
                        height: 20.sp,
                      ),
                      GetX<ProductListingController>(builder: (controller) {
                        return GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 25.sp,
                                  crossAxisSpacing: 10.sp,
                                  crossAxisCount: 2,
                                  childAspectRatio: 150.sp / 236.sp),
                          children: ProductListingController.to.products
                              .map((product) => ProductListingContainer(
                                    product: product,
                                  ))
                              .toList(),
                        );
                      }),
                      GetX<ProductListingController>(builder: (controller) {
                        return (controller.next.isEmpty)
                            ? SizedBox()
                            : LoadingBarsAnimation();
                      })
                    ],
                  );
      }),
    );
  }
}

class ProductListingContainer extends StatelessWidget {
  Product product;
  ProductListingContainer({required this.product});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(3.sp),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(7.sp),
            ),
            child: AppNetworkImage(
              imageUrl: product.productImage ?? "",
              height: 200.sp,
              radius: 5.sp,
              width: Get.width,
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            product.productName ?? "",
            maxLines: 1,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "${product.productPrice ?? 0}" == "0"
                  ? const SizedBox()
                  : RichText(
                      text: TextSpan(
                          text: "Price ₹",
                          style: TextStyle(color: AppColors.grey),
                          children: [
                          TextSpan(
                              text: "${product.productPrice ?? 0}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black77))
                        ])),
              Row(
                children: [
                  Icon(
                    Icons.lens,
                    color: AppColors.green93,
                    size: 12.sp,
                  ),
                  Text(
                    product.availability ?? false
                        ? " InStock"
                        : " Out of Stock",
                    style: TextStyle(
                        color: product.availability ?? false
                            ? AppColors.green93
                            : AppColors.red,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
