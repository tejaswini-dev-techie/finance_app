import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/textShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ServicesShimmer extends StatelessWidget {
  const ServicesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 8.sp),
          child: textShimmer(widthSize: 27.sp),
        ),
        SizedBox(
          height: 85.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Scroll horizontally
            itemCount: 3,
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
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      enabled: true,
                      child: Container(
                        height: 32.sp,
                        width: 32.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    textShimmer(widthSize: 60.sp)
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
