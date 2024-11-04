import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:sizer/sizer.dart';

class GroupMembersDetailsScreen extends StatefulWidget {
  const GroupMembersDetailsScreen({super.key});

  @override
  State<GroupMembersDetailsScreen> createState() =>
      _GroupMembersDetailsScreenState();
}

class _GroupMembersDetailsScreenState extends State<GroupMembersDetailsScreen> {
  String internetAlert = "";
  String groupMembersDetailsText = "";

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
    groupMembersDetailsText =
        appContent['group_mem_det']['group_mem_det_text'] ?? "";
    setState(() {});
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": 3,
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
                      groupMembersDetailsText,
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
            itemCount: 5,
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 24.sp,
            ),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.sp),
                          child: Image.asset(
                            ImageConstants.profileImage,
                            width: 34.sp,
                            height: 34.sp,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                (index == 0) ? "Group Leader" : "Group Member",
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                "RAM",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              Text(
                                "Joined on 16th August 2024",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                "Rashtreeya Vidyala Road, Jayanagar, Bangalore, Karnataka",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                            ],
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
                          (index == 1) ? "DUE" : "PAID",
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
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.sp),
                child: Divider(
                  color: ColorConstants.lighterBlueColor,
                  thickness: 1.2.sp,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
