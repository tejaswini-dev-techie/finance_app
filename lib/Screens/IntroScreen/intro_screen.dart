import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:hp_finance/Utils/widgets_util/alert_model.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  /* JSON Text */
  String internetAlert = "Please check your internet connection!";
  String logoutSubTitle = "Are you sure you want to exit?";
  String btnText = "Exit";
  String cancelText = "Cancel";
  String nextText = "Next";
  String skipText = "SKIP";
  /* JSON Text */

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  sessionNavigation() async {
    String loginData = await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefisAlreadyLogin) ??
        "0";

    print("loginData: $loginData");

    if (loginData == "1") {
      if (!mounted) return;
      Navigator.pushReplacementNamed(
        context,
        RoutingConstants.routeDashboardScreen,
      );
    }
    // else {
    //   if (!mounted) return;
    //   Navigator.pushReplacementNamed(
    //     context,
    //     RoutingConstants.routeLoginScreen,
    //   );
    // }
  }

  getAppContentDet() async {
    await sessionNavigation();
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    logoutSubTitle = appContent['logout']['exit_subtitle_text'] ?? "";
    btnText = appContent['logout']['exit_text'] ?? "";
    cancelText = appContent['logout']['cancel_text'] ?? "";
    nextText = appContent['action_items']['next_text'] ?? "";
    skipText = appContent['action_items']['skip_text'] ?? "";
    setState(() {});
  }

  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        RoutingConstants.routeLoginScreen,
      );
    }
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Grow Your Savings, One Step at a Time',
      'image': 'assets/images/intro1.png',
      'description':
          "A flexible savings plan designed to help you save daily or weekly, tailored to your financial needs.",
      'skip': true
    },
    {
      'title': 'Your Personalized Financial Solution',
      'image': 'assets/images/intro2.png',
      'description':
          'Quick and easy loans designed to meet your unique financial requirements, with flexible repayment options.',
      'skip': true
    },
    {
      'title': 'Empowering Communities Together',
      'image': 'assets/images/intro3.png',
      'description':
          'Affordable loan solutions for groups, fostering collective financial growth and success.',
      'skip': false
    },
  ];

  backAction() {
    popupAlertDialog(
      internetAlert: internetAlert,
      context: context,
      titleText: logoutSubTitle,
      subTitleText: "",
      imagePath: ImageConstants.exitImage,
      secondaryButtonText: cancelText,
      primaryButtonText: btnText,
      onSecondaryButtonTap: () {
        Navigator.pop(context);
      },
      onPrimaryButtonTap: () {
        exit(0);
        // (Platform.isIOS)
        //     ?
        //     // force exit in ios
        //     FlutterExitApp.exitApp(iosForceExit: true)
        //     :
        //     // call this to exit app
        //     FlutterExitApp.exitApp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backAction();
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstants.whiteColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.sp),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              width: SizerUtil.width,
              height: 50.sp,
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.shadowBlackColor,
                    blurRadius: 8.sp,
                    offset: const Offset(0, 4),
                    spreadRadius: 4.sp,
                  )
                ],
              ),
              child: (_activePage == 2)
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        RoutingConstants.routeLoginScreen,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            skipText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorConstants.darkBlueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: ColorConstants.darkBlueColor,
                          )
                        ],
                      ),
                    ),
            ),
          ),
          body: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                // scrollBehavior: AppScrollBehavior(),
                onPageChanged: (int page) {
                  setState(() {
                    _activePage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: SizerUtil.width,
                    height: SizerUtil.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          _pages[index]['image'] ?? "",
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                _pages[index]['title'] ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 3.sp,
                              ),
                              Text(
                                _pages[index]['description'] ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 50.sp,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                top: SizerUtil.height * 0.76,
                right: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildIndicator(),
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      buttonWidgetHelperUtil(
                        isDisabled: false,
                        buttonText: nextText,
                        onButtonTap: () => onNextPage(),
                        context: context,
                        internetAlert: internetAlert,
                        borderradius: 8.sp,
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorConstants.darkBlueColor,
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ColorConstants.blackColor.withOpacity(0.18),
      ),
    );
  }
}
