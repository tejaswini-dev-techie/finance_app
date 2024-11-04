import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/DataModel/Dashboard/loans_data_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LoansInfoCards extends StatelessWidget {
  final LoansMenusList? loansMenuDet;

  const LoansInfoCards({
    super.key,
    this.loansMenuDet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.sp,
        horizontal: 4.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.sp),
        color: ColorConstants.whiteColor,
        border: Border.all(
          color: ColorConstants.lightGreyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            loansMenuDet?.menuImg ?? "",
            scale: 5.0,
            fit: BoxFit.fill,
            height: 24.sp,
            width: 24.sp,
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
                  height: 24.sp,
                  width: 24.sp,
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
                  height: 24.sp,
                  width: 24.sp,
                  color: Colors.grey,
                ),
              );
            },
          ),
          Text(
            loansMenuDet?.menuTitle ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 8.sp,
              color: ColorConstants.lightBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            loansMenuDet?.menuSubtile ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              color: ColorConstants.darkBlueColor,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
