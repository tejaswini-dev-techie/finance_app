import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/GroupMembersDetails/bloc/group_members_details_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class GroupMembersDetailsScreen extends StatefulWidget {
  final String? type; // type: 1 - G PIGMY | 2 - G Loans
  const GroupMembersDetailsScreen({
    super.key,
    this.type = "1",
  });

  @override
  State<GroupMembersDetailsScreen> createState() =>
      _GroupMembersDetailsScreenState();
}

class _GroupMembersDetailsScreenState extends State<GroupMembersDetailsScreen> {
  final GroupMembersDetailsBloc groupMembersDetailsBloc =
      GroupMembersDetailsBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    groupMembersDetailsBloc.add(
      GetGroupMemDetEvent(
        page: 1,
        showLoading: true,
        type: widget.type,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    groupMembersDetailsBloc.close();
    _refreshController.dispose();
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": (widget.type == "1") ? 2 : 4,
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
                      groupMembersDetailsBloc.groupMembersDetailsText,
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
          body: BlocBuilder<GroupMembersDetailsBloc, GroupMembersDetailsState>(
            bloc: groupMembersDetailsBloc,
            builder: (context, state) {
              if (state is GroupMembersDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is GroupMembersDetailsLoaded) {
                return (groupMembersDetailsBloc.grpMemList != null &&
                        groupMembersDetailsBloc.grpMemList!.isNotEmpty)
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!groupMembersDetailsBloc.saving) {
                            if (!groupMembersDetailsBloc.endPage) {
                              groupMembersDetailsBloc.saving = true;
                              groupMembersDetailsBloc.add(
                                GetGroupMemDetEvent(
                                  type: widget.type,
                                  page: groupMembersDetailsBloc.page,
                                  oldGrpMemList:
                                      groupMembersDetailsBloc.grpMemList ?? [],
                                  showLoading: false,
                                ),
                              );
                            }
                          }
                          return true;
                        },
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          header: const MaterialClassicHeader(
                            distance: 40,
                            color: ColorConstants.whiteColor,
                            backgroundColor: ColorConstants.greenColor,
                          ),
                          enablePullUp: groupMembersDetailsBloc.endPage
                              ? false
                              : (groupMembersDetailsBloc.isNetworkConnected ==
                                      false)
                                  ? false
                                  : true,
                          onRefresh: () {
                            InternetUtil().checkInternetConnection().then(
                              (internet) {
                                if (internet) {
                                  groupMembersDetailsBloc.add(
                                    GetGroupMemDetEvent(
                                      type: widget.type,
                                      page: 1,
                                      showLoading: true,
                                    ),
                                  );
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();

                                  ToastUtil().showSnackBar(
                                    context: context,
                                    message:
                                        groupMembersDetailsBloc.internetAlert,
                                    isError: true,
                                  );
                                }
                              },
                            );
                          },
                          child: ListView.separated(
                            itemCount:
                                groupMembersDetailsBloc.grpMemList!.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 24.sp,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  InternetUtil()
                                      .checkInternetConnection()
                                      .then((internet) {
                                    if (internet) {
                                      if (groupMembersDetailsBloc
                                                  .grpMemList![index]
                                                  .memberID !=
                                              null &&
                                          groupMembersDetailsBloc
                                              .grpMemList![index]
                                              .memberID!
                                              .isNotEmpty) {
                                        Map<String, dynamic> data = {};
                                        data = {
                                          "type":
                                              "2", // type 1 - My Profile | 2 - Others Profile
                                          "customerID": groupMembersDetailsBloc
                                                  .grpMemList![index]
                                                  .memberID ??
                                              "",
                                        };
                                        Navigator.pushReplacementNamed(
                                          context,
                                          RoutingConstants.routeProfileScreen,
                                          arguments: {"data": data},
                                        );
                                      }
                                    } else {
                                      ToastUtil().showSnackBar(
                                          context: context,
                                          message: groupMembersDetailsBloc
                                              .internetAlert,
                                          isError: true);
                                    }
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.sp),
                                            child: Image.network(
                                              groupMembersDetailsBloc
                                                      .grpMemList![index]
                                                      .profileImg ??
                                                  "",
                                              scale: 5.0,
                                              fit: BoxFit.fill,
                                              height: 24.sp,
                                              width: 24.sp,
                                              filterQuality: Platform.isIOS
                                                  ? FilterQuality.medium
                                                  : FilterQuality.low,
                                              loadingBuilder:
                                                  (BuildContext? context,
                                                      Widget? child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child!;
                                                }
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[400]!,
                                                  enabled: true,
                                                  child: Image.asset(
                                                    ImageConstants.profileImage,
                                                    width: 34.sp,
                                                    height: 34.sp,
                                                  ),
                                                );
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[400]!,
                                                  enabled: true,
                                                  child: Image.asset(
                                                    ImageConstants.profileImage,
                                                    width: 34.sp,
                                                    height: 34.sp,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .headerText ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstants
                                                        .lightBlackColor,
                                                  ),
                                                ),
                                                Text(
                                                  groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .memName ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorConstants
                                                        .blackColor,
                                                  ),
                                                ),
                                                Text(
                                                  groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .joinedDate ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstants
                                                        .lightBlackColor,
                                                  ),
                                                ),
                                                Text(
                                                  groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .footerText ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstants
                                                        .lightBlackColor,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            groupMembersDetailsBloc
                                                    .grpMemList![index]
                                                    .amtText ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  ColorConstants.darkBlueColor,
                                            ),
                                          ),
                                          Text(
                                            groupMembersDetailsBloc
                                                    .grpMemList![index]
                                                    .payStatus ??
                                                "",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: (groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .payStatusType ==
                                                      "2")
                                                  ? ColorConstants.mintRedColor
                                                  : ColorConstants
                                                      .mintGreenColor,
                                            ),
                                          ),
                                          Text(
                                            groupMembersDetailsBloc
                                                    .grpMemList![index]
                                                    .accStatus ??
                                                "",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: (groupMembersDetailsBloc
                                                          .grpMemList![index]
                                                          .accStatusType ==
                                                      "2")
                                                  ? ColorConstants.mintRedColor
                                                  : ColorConstants
                                                      .mintGreenColor,
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
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 84.sp,
                            ),
                            Container(
                              width: SizerUtil.width,
                              height: 250.sp,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageConstants.noDataFoundImage,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              child: Text(
                                groupMembersDetailsBloc.noDataFoundText ??
                                    "No Data found!!!",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              } else if (state is GroupMembersDetailsNoInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => groupMembersDetailsBloc.add(
                    GetGroupMemDetEvent(
                      type: widget.type,
                      page: 1,
                      showLoading: true,
                    ),
                  ),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => groupMembersDetailsBloc.add(
                    GetGroupMemDetEvent(
                      type: widget.type,
                      page: 1,
                      showLoading: true,
                    ),
                  ),
                  state: 2,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
