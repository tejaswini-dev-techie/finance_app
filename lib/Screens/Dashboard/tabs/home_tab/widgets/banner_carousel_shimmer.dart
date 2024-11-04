import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

bannerCarouselShimmer({required BuildContext context}) {
  return Container(
    height: 140.sp,
    margin:
        EdgeInsets.only(top: 16.sp, bottom: 10.sp, right: 16.sp, left: 16.sp),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[400]!,
          child: Container(
            height: 120.sp,
            width: SizerUtil.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              color: Colors.grey[200],
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 16.sp,
            right: 16.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(8, (index) {
              bool isActive = 0 == index;
              return AnimatedContainer(
                duration: const Duration(
                    milliseconds: 300), // Adjust animation duration
                margin: EdgeInsets.symmetric(horizontal: 5.sp),
                width: isActive ? 13.sp : 5.sp,
                height: 5.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  color: isActive
                      ? ColorConstants.darkBlueColor
                      : ColorConstants.lighterBlackColor,
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}
