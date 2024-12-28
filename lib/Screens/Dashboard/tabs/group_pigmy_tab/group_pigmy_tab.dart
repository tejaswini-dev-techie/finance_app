import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_tab/bloc/group_pigmy_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_tab/widgets/group_pigmy_screen.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/bloc/pigmy_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/no_pigmy_started.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_shimmer.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class GroupPigmyTab extends StatefulWidget {
  const GroupPigmyTab({super.key});

  @override
  State<GroupPigmyTab> createState() => _GroupPigmyTabState();
}

class _GroupPigmyTabState extends State<GroupPigmyTab> {
  final GroupPigmyBloc groupPigmyBloc = GroupPigmyBloc();

  @override
  void initState() {
    super.initState();
    groupPigmyBloc.add(GetGroupPigmyDetails());
  }

  @override
  void dispose() {
    super.dispose();
    groupPigmyBloc.close();
  }

  void onStartNowAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeCreatePigmySavingsAccountScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ?? "",
            isError: true,
          );
        }
      },
    );
  }

  void onClickHereAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "2",
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeLearnAboutPigmySavingsScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onWithdrawPigmySavingsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeWithdrawPigmySavingsScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onContactAction({required String btnText}) {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "title": btnText,
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeEnquiryScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onPigmyHistoryAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routePigmyHistoryScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onGropCreationAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeGroupCreationScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupPigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPigmyBloc, GroupPigmyState>(
      bloc: groupPigmyBloc,
      builder: (context, state) {
        if (state is GroupPigmyLoading) {
          return const PigmyShimmer();
        } else if (state is GroupPigmyLoaded) {
          return (groupPigmyBloc.pigmyData != null &&
                  groupPigmyBloc.pigmyData?.pigmyMenusList != null &&
                  groupPigmyBloc.pigmyData!.pigmyMenusList!.isNotEmpty)
              ? SingleChildScrollView(
                  child: GroupPigmyScreen(
                    groupPigmyBloc: groupPigmyBloc,
                    titleText:
                        groupPigmyBloc.pigmyData?.pigmyStatusNudgeTitle ??
                            'Pigmy Withdrawal Request Rejected',
                    subTitleText: groupPigmyBloc
                            .pigmyData?.pigmyStatusNudgeSubtitle ??
                        'Unfortunately, your Pigmy withdrawal request has been rejected. Please review the details and contact our support team for further assistance or to address any issues.',
                    btnText:
                        groupPigmyBloc.pigmyData?.pigmyStatusNudgeBtn ?? "",
                    internetAlert: groupPigmyBloc.internetAlert,
                    onContactAction: () => onContactAction(
                        btnText:
                            groupPigmyBloc.pigmyData?.pigmyStatusNudgeBtn ??
                                ""),
                    learnAboutPigmySavingsWidget: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      child: Column(
                        children: [
                          (groupPigmyBloc.pigmyData?.learnPigmyBtnText !=
                                      null &&
                                  groupPigmyBloc
                                      .pigmyData!.learnPigmyBtnText!.isNotEmpty)
                              ? InkWell(
                                  onTap: () => onClickHereAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          groupPigmyBloc.pigmyData
                                                  ?.learnPigmyBtnText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorConstants.darkBlueColor,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          (groupPigmyBloc.pigmyData?.learnPigmyBtnText !=
                                      null &&
                                  groupPigmyBloc
                                      .pigmyData!.learnPigmyBtnText!.isNotEmpty)
                              ? SizedBox(
                                  height: 5.sp,
                                )
                              : const SizedBox.shrink(),
                          (groupPigmyBloc.pigmyData?.withdrawPigmyBtnText !=
                                      null &&
                                  groupPigmyBloc.pigmyData!
                                      .withdrawPigmyBtnText!.isNotEmpty)
                              ? InkWell(
                                  onTap: () => onWithdrawPigmySavingsAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          groupPigmyBloc.pigmyData
                                                  ?.withdrawPigmyBtnText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorConstants.darkBlueColor,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          (groupPigmyBloc.pigmyData?.withdrawPigmyBtnText !=
                                      null &&
                                  groupPigmyBloc.pigmyData!
                                      .withdrawPigmyBtnText!.isNotEmpty)
                              ? SizedBox(
                                  height: 5.sp,
                                )
                              : const SizedBox.shrink(),
                          (groupPigmyBloc.pigmyData
                                          ?.pigmyTransactionHistoryBtnText !=
                                      null &&
                                  groupPigmyBloc
                                      .pigmyData!
                                      .pigmyTransactionHistoryBtnText!
                                      .isNotEmpty)
                              ? InkWell(
                                  onTap: () => onPigmyHistoryAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          groupPigmyBloc.pigmyData
                                                  ?.pigmyTransactionHistoryBtnText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: ColorConstants.darkBlueColor,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: 5.sp,
                          ),
                          InkWell(
                            onTap: () => onGropCreationAction(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    "GROUP CREATION",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: ColorConstants.darkBlueColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorConstants.darkBlueColor,
                                  size: 12.sp,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              :
              /* Pigmy Not Started */
              SingleChildScrollView(
                  child: PigmyNotStarted(
                    internetAlert: groupPigmyBloc.internetAlert,
                    startNowText: groupPigmyBloc.pigmyData?.btnText ?? "",
                    noPigmyTitleText:
                        groupPigmyBloc.pigmyData?.noPigmyTitle ?? "",
                    noPigmySubTitleText:
                        groupPigmyBloc.pigmyData?.noPigmySubtitle ?? "",
                    footertext: groupPigmyBloc.pigmyData?.footerText ?? "",
                    onStartNowAction: () => onStartNowAction(),
                    onClickHereAction: () => onClickHereAction(),
                  ),
                );
          /* Pigmy Not Started */
        } else if (state is GroupPigmyNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => groupPigmyBloc.add(GetGroupPigmyDetails()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => groupPigmyBloc.add(GetGroupPigmyDetails()),
            state: 2,
          );
        }
      },
    );
  }
}
