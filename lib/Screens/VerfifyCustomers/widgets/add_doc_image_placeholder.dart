import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class AddDocImagePlaceholder extends StatelessWidget {
  final String placeholderText;
  final String addText;
  final Function onImageTap;
  final String? imagePath;

  const AddDocImagePlaceholder({
    super.key,
    required this.placeholderText,
    required this.addText,
    required this.onImageTap,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onImageTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeholderText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.sp,
              color: ColorConstants.lightBlackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 3.sp,
          ),
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              Container(
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
                        filterQuality: Platform.isIOS
                            ? FilterQuality.medium
                            : FilterQuality.low,
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: ColorConstants.darkBlueColor,
                            size: 32.sp,
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          Text(
                            addText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: ColorConstants.darkBlueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
              // Positioned(
              //   right: -8.sp,
              //   top: -10.sp,
              //   child: InkWell(
              //     onTap: () => onCancelTap,
              //     child: Icon(
              //       Icons.cancel,
              //       color: ColorConstants.darkBlueColor,
              //       size: 20.sp,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
