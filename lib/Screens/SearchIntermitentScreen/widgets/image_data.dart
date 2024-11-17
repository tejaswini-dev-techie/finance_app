import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ImageData extends StatelessWidget {
  final String? imagePath;
  const ImageData({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizerUtil.width,
      height: 140.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: ColorConstants.lighterBlueColor,
      ),
      child: (imagePath != null && imagePath!.isNotEmpty)
          ? Image.network(
              imagePath ?? "",
              // fit: BoxFit.fill,
              width: 60.sp,
              height: 60.sp,
              filterQuality:
                  Platform.isIOS ? FilterQuality.medium : FilterQuality.low,
              loadingBuilder: (BuildContext? context, Widget? child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child!;
                }
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  enabled: true,
                  child: Container(
                    width: 60.sp,
                    height: 60.sp,
                    color: Colors.grey,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  enabled: true,
                  child: Container(
                    width: 60.sp,
                    height: 60.sp,
                    color: Colors.grey,
                  ),
                );
              },
            )
          : Icon(
              Icons.image,
              color: ColorConstants.darkBlueColor,
              size: 42.sp,
            ),
    );
  }
}
