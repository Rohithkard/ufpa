import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upfa/api_services/urls.dart';
import 'package:upfa/color/color.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? radius;
  final bool? isProfile;
  final BoxFit? fit;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.radius,
    this.fit,
    this.isProfile,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: "${AppUrls.baseForImage}$imageUrl",
          errorWidget: (context, url, error) => Container(
            color: AppColors.white,
            height: height,
            width: width,
            child: Icon(
              Icons.person,
              color: AppColors.black77,
              size: height,
            ),
          ),
          height: height,
          fit: fit ?? BoxFit.fill,
          width: width ?? 50.sp,
        ),
      ),
    );
  }
}
