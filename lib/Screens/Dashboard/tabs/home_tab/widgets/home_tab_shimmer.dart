import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/banner_carousel_shimmer.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/dues_shimmer.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/services_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeTabShimmer extends StatelessWidget {
  const HomeTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.sp,
          ),

          /* Banner Carousel Shimmer */
          bannerCarouselShimmer(context: context),
          /* Banner Carousel Shimmer */

          /* KYC Status Widget */
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: Container(
              width: SizerUtil.width,
              margin: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
              padding: EdgeInsets.symmetric(
                vertical: 11.sp,
                horizontal: 8.sp,
              ),
              height: 120.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: ColorConstants.whiteColor,
                border: Border.all(
                  color: ColorConstants.lightGreyColor,
                ),
              ),
            ),
          ),
          /* KYC Status Widget */

          /* Services */
          const ServicesShimmer(),
          /* Services */

          /* Dues Section */
          const DuesShimmer(),
          /* Dues Section */
        ],
      ),
    );
  }
}
