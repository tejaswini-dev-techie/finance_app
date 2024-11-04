import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:sizer/sizer.dart';

class PigmyHistoryScreen extends StatefulWidget {
  const PigmyHistoryScreen({super.key});

  @override
  State<PigmyHistoryScreen> createState() => _PigmyHistoryScreenState();
}

class _PigmyHistoryScreenState extends State<PigmyHistoryScreen> {
  String internetAlert = "";
  String pigmyHistoryText = "";

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    pigmyHistoryText = appContent['pigmy_history']['pigmy_history_text'] ?? "";
    setState(() {});
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": 1,
    };
    Navigator.pushReplacementNamed(
      context,
      RoutingConstants.routeDashboardScreen,
      arguments: {"data": data},
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => backAction(),
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      size: 16.sp,
                      color: ColorConstants.darkBlueColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: Text(
                      pigmyHistoryText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                ],
              ),
            ),
          ),
          body: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 24.sp,
            ),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.sp,
                  horizontal: 10.sp,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  color: ColorConstants.whiteColor,
                  border: Border.all(
                    color: ColorConstants.lightGreyColor,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "PAID TO",
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.lightBlackColor,
                            ),
                          ),
                          Text(
                            "HP FINANCE",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          Text(
                            "16th August 2024 6:45 PM",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.lightBlackColor,
                            ),
                          ),
                          Text(
                            "PIGMYCODE1234",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.lightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (index == 1)
                                ? '\u002D \u20B91500'
                                : '\u002B \u20B94200',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.darkBlueColor,
                            ),
                          ),
                          Text(
                            (index == 1) ? "WITHDRAW" : "PAID",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: (index == 1)
                                  ? ColorConstants.mintRedColor
                                  : ColorConstants.mintGreenColor,
                            ),
                          ),
                          Text(
                            (index == 1) ? "CLOSED" : "ACTIVE",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: (index == 1)
                                  ? ColorConstants.mintRedColor
                                  : ColorConstants.mintGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.sp,
              );
            },
          ),
        ),
      ),
    );
  }
}
