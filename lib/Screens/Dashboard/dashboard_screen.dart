import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/agents_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/group_loans_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/home_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/loans_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/pigmy_tab.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:hp_finance/Utils/widgets_util/alert_model.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  final int? tabIndex;

  const Dashboard({
    super.key,
    this.tabIndex = 0,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  /* JSON Text */
  String internetAlert = "";
  String logoutSubTitle = "";
  String btnText = "";
  String cancelText = "";
  String dashboardText = "HP FINANCE";
  String homeText = "HOME";
  String pigmyText = "PIGMY";
  String loansText = "LOANS";
  String groupLoansText = "GROUP LOANS";
  /* JSON Text */
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabIndex ?? 0;
    getAppContentDet();
  }

  @override
  void dispose() {
    super.dispose();
    updateTabIndex.dispose();
  }

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
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefisAlreadyLogin, "0");
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

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    logoutSubTitle = appContent['logout']['exit_subtitle_text'] ?? "";
    btnText = appContent['logout']['exit_text'] ?? "";
    cancelText = appContent['logout']['cancel_text'] ?? "";
    setState(() {});
  }

  int _selectedIndex = 0;
  final ValueNotifier<bool> updateTabIndex = ValueNotifier<bool>(false);
  static List<Widget> widgetOptions = <Widget>[
    const HomeTab(),
    // const AgentsTab(),
    const PigmyTab(),
    const LoansTab(),
    const GroupLoansTab(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    updateTabIndex.value = !updateTabIndex.value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backAction();
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: updateTabIndex,
          builder: (context, bool vals, _) {
            return Scaffold(
              backgroundColor: ColorConstants.whiteColor,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: ColorConstants.whiteColor,
                selectedLabelStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.darkBlueColor,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.darkShadeBlueColor,
                ),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 0
                        ? Image.asset(
                            ImageConstants.homeSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          )
                        : Image.asset(
                            ImageConstants.homeUnSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                    label: homeText,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 1
                        ? Image.asset(
                            ImageConstants.pigmySelImage,
                            width: 20.sp,
                            height: 20.sp,
                          )
                        : Image.asset(
                            ImageConstants.pigmyUnselImage,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                    label: pigmyText,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 2
                        ? Image.asset(
                            ImageConstants.loansSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          )
                        : Image.asset(
                            ImageConstants.loansUnSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                    label: loansText,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 3
                        ? Image.asset(
                            ImageConstants.grouploansSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          )
                        : Image.asset(
                            ImageConstants.grouploansUnSelImage,
                            width: 20.sp,
                            height: 20.sp,
                          ),
                    label: groupLoansText,
                  ),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                selectedItemColor: ColorConstants.darkBlueColor,
                unselectedItemColor: ColorConstants.darkShadeBlueColor,
                onTap: onItemTapped,
                elevation: 5,
              ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.sp),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          RoutingConstants.routeProfileScreen,
                        ),
                        child: Image.asset(
                          ImageConstants.profileImage,
                          width: 30.sp,
                          height: 30.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        dashboardText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorConstants.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => backAction(),
                        child: Image.asset(
                          ImageConstants.logoutImage,
                          width: 28.sp,
                          height: 28.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: widgetOptions.elementAt(_selectedIndex),
            );
          },
        ),
      ),
    );
  }
}