import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/textShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class DuesShimmer extends StatelessWidget {
  const DuesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
          ),
          child: textShimmer(widthSize: 75.sp),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: Container(
                width: SizerUtil.width,
                height: 60.sp,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.sp,
                  vertical: 4.sp,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: ColorConstants.whiteColor,
                  border: Border.all(
                    color: ColorConstants.lightGreyColor,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.sp,
            );
          },
        ),
      ],
    );
  }
}
