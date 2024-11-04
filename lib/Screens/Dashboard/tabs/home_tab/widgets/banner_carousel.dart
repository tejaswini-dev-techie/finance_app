import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:sizer/sizer.dart';

class BannerCarousel extends StatefulWidget {
  final String internetAlert;
  final List<BannerDetails>? bannerList;
  const BannerCarousel(
      {super.key, required this.internetAlert, required this.bannerList});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  double bannerTotalHeight = 130;
  double bannerCarouselTotalHeight = 120;
  double bannerIndicatorsTotalHeight = 12;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      _scrollNext();
    });
  }

  void _scrollNext() async {
    if (widget.bannerList != null && widget.bannerList!.isNotEmpty) {
      await _pageController.animateToPage(
        (currentIndex + 1) % widget.bannerList!.length,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
      Future.delayed(const Duration(seconds: 3), () => _scrollNext());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerTotalHeight.sp,
      margin: EdgeInsets.only(top: 16.sp, bottom: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            disableGesture: true,
            items: widget.bannerList?.map((bannerData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: InkWell(
                  onTap: () async {
                    await InternetUtil()
                        .checkInternetConnection()
                        .then((internet) {
                      if (internet) {
                        // Add Navigation
                      } else {
                        ToastUtil().showSnackBar(
                          context: context,
                          message: widget.internetAlert,
                          isError: true,
                        );
                      }
                    });
                  },
                  child: Container(
                    width: SizerUtil.width,
                    padding: EdgeInsets.all(16.sp),
                    height: bannerCarouselTotalHeight.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: ColorConstants.whiteColor,
                      border: Border.all(
                        color: ColorConstants.lightGreyColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        bannerData.title ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            carouselController: CarouselController(),
            options: CarouselOptions(
              pauseAutoPlayOnTouch: false,
              animateToClosest: false,
              height:
                  bannerCarouselTotalHeight.sp - bannerIndicatorsTotalHeight.sp,
              autoPlay: true,
              viewportFraction: 0.92,
              onPageChanged: (index, reason) => setState(
                () {
                  currentIndex = index;
                },
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
              children: widget.bannerList!.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(
                      milliseconds: 300), // Adjust animation duration
                  margin: EdgeInsets.symmetric(horizontal: 5.sp),
                  width: (currentIndex == entry.key) ? 13.sp : 5.sp,
                  height: 5.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: (currentIndex == entry.key)
                        ? ColorConstants.darkBlueColor
                        : ColorConstants.lighterBlackColor,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
