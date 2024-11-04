import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/dues_shimmer.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/textShimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class PigmyShimmer extends StatelessWidget {
  const PigmyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 10.sp,
            ),
            child: Column(
              children: [
                /* Info Cards */
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.sp,
                    mainAxisSpacing: 16.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      enabled: true,
                      child: Container(
                        height: 24.sp,
                        width: 24.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: Colors.grey,
                          border: Border.all(
                            color: ColorConstants.lightGreyColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                /* Info Cards */

                Column(
                  children: [
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: textShimmer(widthSize: SizerUtil.width * 0.5),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: textShimmer(widthSize: SizerUtil.width * 0.5),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: textShimmer(widthSize: SizerUtil.width * 0.5),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const DuesShimmer(),
        ],
      ),
    );
  }
}
