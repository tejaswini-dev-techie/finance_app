import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

Widget textShimmer({
  double? widthSize,
  double? heightSize,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[400]!,
    child: Container(
      margin: EdgeInsets.symmetric(
        vertical: 3.sp,
      ),
      width: widthSize ?? 45.w,
      height: heightSize ?? 1.2.h,
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
      ),
    ),
  );
}
