import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_reports_tab/bloc/group_pigmy_reports_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class GroupPigmyReports extends StatefulWidget {
  const GroupPigmyReports({super.key});

  @override
  State<GroupPigmyReports> createState() => _GroupPigmyReportsState();
}

class _GroupPigmyReportsState extends State<GroupPigmyReports> {
  final GroupPigmyReportsBloc groupPigmyReportsBloc = GroupPigmyReportsBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    groupPigmyReportsBloc.add(
      GetGroupPigmyReports(
        type: "2",
        page: 1,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    groupPigmyReportsBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupPigmyReportsBloc, GroupPigmyReportsState>(
      bloc: groupPigmyReportsBloc,
      builder: (context, state) {
        if (state is GroupPigmyReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.darkBlueColor,
            ),
          );
        } else if (state is GroupPigmyReportsLoaded) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!groupPigmyReportsBloc.saving) {
                if (!groupPigmyReportsBloc.endPage) {
                  groupPigmyReportsBloc.saving = true;
                  groupPigmyReportsBloc.add(
                    GetGroupPigmyReports(
                      type:
                          "2", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                      page: groupPigmyReportsBloc.page,
                      oldReportList: groupPigmyReportsBloc.reportsDetList ?? [],
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
              enablePullUp: groupPigmyReportsBloc.endPage
                  ? false
                  : (groupPigmyReportsBloc.isNetworkConnected == false)
                      ? false
                      : (groupPigmyReportsBloc.reportsDetList == null ||
                              groupPigmyReportsBloc.reportsDetList!.isEmpty)
                          ? false
                          : true,
              onRefresh: () {
                InternetUtil().checkInternetConnection().then(
                  (internet) {
                    if (internet) {
                      groupPigmyReportsBloc.add(
                        GetGroupPigmyReports(
                          type:
                              "2", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                          page: 1,
                          showLoading: true,
                        ),
                      );
                      _refreshController.refreshCompleted();
                    } else {
                      _refreshController.refreshFailed();

                      ToastUtil().showSnackBar(
                        context: context,
                        message: groupPigmyReportsBloc.internetAlert,
                        isError: true,
                      );
                    }
                  },
                );
              },
              child: (groupPigmyReportsBloc.reportData != null &&
                      groupPigmyReportsBloc.reportsDetList != null &&
                      groupPigmyReportsBloc.reportsDetList!.isNotEmpty)
                  ? ListView.separated(
                      itemCount: groupPigmyReportsBloc.reportsDetList!.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.sp, vertical: 12.sp),
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 4.sp,
                            ),
                            Divider(
                              thickness: 1.2.sp,
                              color: ColorConstants.lightGreyColor,
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                          ],
                        );
                      },
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == 0)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.sp,
                                ),
                                child: Text(
                                  groupPigmyReportsBloc.reportData?.title ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstants.blackColor,
                                  ),
                                ),
                              ),
                            InkWell(
                              onTap: () {
                                InternetUtil().checkInternetConnection().then(
                                  (internet) async {
                                    if (internet) {
                                      Map<String, dynamic> data = {};
                                      data = {
                                        "customerID": groupPigmyReportsBloc
                                                .reportsDetList![index].id ??
                                            "",
                                        "type": groupPigmyReportsBloc
                                                .reportsDetList![index].type ??
                                            "",
                                      };

                                      Navigator.pushNamed(
                                        context,
                                        RoutingConstants
                                            .routeAgentUpdatePaymentDetailsScreen,
                                        arguments: {"data": data},
                                      );
                                    } else {
                                      ToastUtil().showSnackBar(
                                        context: context,
                                        message: groupPigmyReportsBloc
                                                .internetAlert ??
                                            "Please check your internet connection",
                                        isError: true,
                                      );
                                    }
                                  },
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 4.sp),
                                          child: Image.asset(
                                            ImageConstants.profileImage,
                                            width: 24.sp,
                                            height: 24.sp,
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .headerText !=
                                                      null &&
                                                  groupPigmyReportsBloc
                                                      .reportsDetList![index]
                                                      .headerText!
                                                      .isNotEmpty)
                                                Text(
                                                  groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
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
                                                groupPigmyReportsBloc
                                                        .reportsDetList![index]
                                                        .memName ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorConstants.blackColor,
                                                ),
                                              ),
                                              if (groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .phNum !=
                                                      null &&
                                                  groupPigmyReportsBloc
                                                      .reportsDetList![index]
                                                      .phNum!
                                                      .isNotEmpty)
                                                Text(
                                                  groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .phNum ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstants
                                                        .lightBlackColor,
                                                  ),
                                                ),
                                              if (groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .paymentDate !=
                                                      null &&
                                                  groupPigmyReportsBloc
                                                      .reportsDetList![index]
                                                      .paymentDate!
                                                      .isNotEmpty)
                                                Text(
                                                  groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .paymentDate ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorConstants
                                                        .lightBlackColor,
                                                  ),
                                                ),
                                              if (groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .footerText !=
                                                      null &&
                                                  groupPigmyReportsBloc
                                                      .reportsDetList![index]
                                                      .footerText!
                                                      .isNotEmpty)
                                                Text(
                                                  groupPigmyReportsBloc
                                                          .reportsDetList![
                                                              index]
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
                                          groupPigmyReportsBloc
                                                  .reportsDetList![index]
                                                  .amtText ??
                                              "",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                        ),
                                        Text(
                                          groupPigmyReportsBloc
                                                  .reportsDetList![index]
                                                  .payStatus ??
                                              "",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            color: (groupPigmyReportsBloc
                                                        .reportsDetList![index]
                                                        .payStatusType !=
                                                    "1") // 1-PAID | 2-DUE | 3-WITHDRAW | 4-FAILED | 5-OVERDUE
                                                ? ColorConstants.mintRedColor
                                                : ColorConstants.mintGreenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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
                              groupPigmyReportsBloc.noDataFoundText ??
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
                    ),
            ),
          );
        } else if (state is GroupPigmyReportsNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => groupPigmyReportsBloc.add(
              GetGroupPigmyReports(
                type: "2",
                page: 1,
              ),
            ),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => groupPigmyReportsBloc.add(
              GetGroupPigmyReports(
                type: "2",
                page: 1,
              ),
            ),
            state: 2,
          );
        }
      },
    );
  }
}
