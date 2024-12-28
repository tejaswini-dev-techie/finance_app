import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/agents_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_reports_tab/group_loans_reports_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/group_loans_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_reports_tab/group_pigmy_reports_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_tab/group_pigmy_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/home_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_reports_tab/loans_reports_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/loans_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_reports_tab/pigmy_reports_tab.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/pigmy_tab.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/alert_model.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  final int? tabIndex;
  int? dashbaordType; // 1 - Agent Dashboard | 2 - Customer Dashboard

  Dashboard({
    super.key,
    this.tabIndex = 0,
    this.dashbaordType, // 1 - Agent Dashboard | 2 - Customer Dashboard
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
  String groupPigmyText = "G-PIGMY";
  String loansText = "LOANS";
  String groupLoansText = "G-LOANS";
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

  backAction({int type = 0}) {
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
      onPrimaryButtonTap: () async {
        if (type == 1) {
          var res = await NetworkService().logoutService();
          if (res != null && res['status'] != null && res['status'] == true) {
            SharedPreferencesUtil.addSharedPref(
                SharedPreferenceConstants.prefisAlreadyLogin, "0");
            if (!mounted) return;
            ToastUtil().showSnackBar(
              context: context,
              message: res['message'] ?? "Logged Out Successfully",
            );
            Future.delayed(const Duration(seconds: 1)).then(
              (value) => Navigator.pushReplacementNamed(
                context,
                RoutingConstants.routeLoginScreen,
              ),
            );
          }
        } else {
          exit(0);
        } // (Platform.isIOS)
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
    String? userType = "agent";
    await SharedPreferencesUtil.getSharedPref(
            SharedPreferenceConstants.prefUserType)
        .then((value) {
      if (value != null) {
        userType = value;
        print("user Type: $userType");
      }
    });
    // Determine the tab index based on user_type
    int? navigationType = (userType == "customer")
        ? 2
        : 1; // dashbaordType 1 - Agent Dashboard "agent" | 2 - Customer Dashboard "customer"
    widget.dashbaordType = navigationType;

    widgetOptions = (widget.dashbaordType == 1)
        ? <Widget>[
            const AgentsTab(),
            const PigmyReportsTab(),
            const GroupPigmyReports(),
            const LoansReportsTab(),
            const GroupLoansReportsTab(),
          ]
        : <Widget>[
            const HomeTab(),
            const PigmyTab(),
            const GroupPigmyTab(),
            const LoansTab(),
            const GroupLoansTab(),
          ];

    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    logoutSubTitle = appContent['logout']['exit_subtitle_text'] ?? "";
    btnText = appContent['logout']['exit_text'] ?? "";
    cancelText = appContent['logout']['cancel_text'] ?? "";
    setState(() {});
  }

  int _selectedIndex = 0;
  final ValueNotifier<bool> updateTabIndex = ValueNotifier<bool>(false);
  static List<Widget>? widgetOptions;

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
                        ? Icon(
                            Icons.savings,
                            size: 20.sp,
                            color: ColorConstants.darkBlueColor,
                          )
                        // Image.asset(
                        //     ImageConstants.pigmySelImage,
                        //     width: 20.sp,
                        //     height: 20.sp,
                        //   )
                        : Icon(
                            Icons.savings_outlined,
                            size: 20.sp,
                            color: ColorConstants.darkBlueColor,
                          ),
                    // Image.asset(
                    //     ImageConstants.pigmyUnselImage,
                    //     width: 20.sp,
                    //     height: 20.sp,
                    //   ),
                    label: groupPigmyText,
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 3
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
                    icon: _selectedIndex == 4
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
                selectedFontSize: 10.sp,
                unselectedFontSize: 10.sp,
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
                        onTap: () => backAction(type: 1),
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
              body: widgetOptions!.elementAt(_selectedIndex),
            );
          },
        ),
      ),
    );
  }
}
