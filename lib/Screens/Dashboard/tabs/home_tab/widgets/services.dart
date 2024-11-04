import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
// import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';

class ServicesSection extends StatefulWidget {
  final String internetAlert;
  final List<ServicesList>? dataList;
  final String? titleText;
  const ServicesSection(
      {super.key,
      required this.internetAlert,
      required this.dataList,
      required this.titleText});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  // List dataList = [
  //   {
  //     "id": "0",
  //     "title": "PIGMY",
  //     "image": ImageConstants.pigmySelImage,
  //   },
  //   {
  //     "id": "1",
  //     "title": "LOANS",
  //     "image": ImageConstants.loansSelImage,
  //   },
  //   {
  //     "id": "2",
  //     "title": "GROUP LOANS",
  //     "image": ImageConstants.grouploansSelImage,
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 8.sp),
          child: Text(
            widget.titleText ?? 'Services',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.blackColor,
            ),
          ),
        ),
        SizedBox(
          height: 85.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Scroll horizontally
            itemCount: widget.dataList!.length,
            itemBuilder: (context, index) {
              return Container(
                width: 90.sp,
                margin: EdgeInsets.only(
                  left: (index == 0) ? 16.sp : 6.sp,
                  right: (index == 2) ? 16.sp : 6.sp,
                ), // Spacing between containers
                decoration: BoxDecoration(
                  color: ColorConstants
                      .lighterBlueColor, // Different colors for each container
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.dataList![index].imageUrl ?? "",
                      scale: 5.0,
                      fit: BoxFit.fill,
                      height: 32.sp,
                      width: 32.sp,
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
                            height: 32.sp,
                            width: 32.sp,
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
                            height: 32.sp,
                            width: 32.sp,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Text(
                      widget.dataList![index].title ?? "",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.darkBlueColor,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
