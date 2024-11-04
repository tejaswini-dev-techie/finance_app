import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoadingUtil {
  static Widget ballRotate(BuildContext context) {
    return Container(
      width: SizerUtil.width,
      height: SizerUtil.height,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            ImageConstants.loderLottie,
            height: 100.sp,
            width: 100.sp,
          ),
        ],
      ),
    );
  }

  static Widget ballRotateWithText(
    BuildContext context,
    String? text,
  ) {
    return Container(
      width: SizerUtil.width,
      height: SizerUtil.height,
      color: ColorConstants.whiteColor.withOpacity(0.8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            ImageConstants.loderLottie,
            height: 100.sp,
            width: 100.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: ColorConstants.blackColor,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
