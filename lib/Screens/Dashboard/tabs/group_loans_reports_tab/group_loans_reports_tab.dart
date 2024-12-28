import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_reports_tab/bloc/group_loans_reports_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class GroupLoansReportsTab extends StatefulWidget {
  const GroupLoansReportsTab({super.key});

  @override
  State<GroupLoansReportsTab> createState() => _GroupLoansReportsTabState();
}

class _GroupLoansReportsTabState extends State<GroupLoansReportsTab> {
  final GroupLoansReportsBloc groupLoansReportsBloc = GroupLoansReportsBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    groupLoansReportsBloc.add(
      GetGroupLoansReports(
        type: "4",
        page: 1,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    groupLoansReportsBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupLoansReportsBloc, GroupLoansReportsState>(
      bloc: groupLoansReportsBloc,
      builder: (context, state) {
        if (state is GroupLoansReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.darkBlueColor,
            ),
          );
        } else if (state is GroupLoansReportsLoaded) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!groupLoansReportsBloc.saving) {
                if (!groupLoansReportsBloc.endPage) {
                  groupLoansReportsBloc.saving = true;
                  groupLoansReportsBloc.add(
                    GetGroupLoansReports(
                      type:
                          "4", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                      page: groupLoansReportsBloc.page,
                      oldReportList: groupLoansReportsBloc.reportsDetList ?? [],
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
              enablePullUp: groupLoansReportsBloc.endPage
                  ? false
                  : (groupLoansReportsBloc.isNetworkConnected == false)
                      ? false
                      : (groupLoansReportsBloc.reportsDetList == null ||
                              groupLoansReportsBloc.reportsDetList!.isEmpty)
                          ? false
                          : true,
              onRefresh: () {
                InternetUtil().checkInternetConnection().then(
                  (internet) {
                    if (internet) {
                      groupLoansReportsBloc.add(
                        GetGroupLoansReports(
                          type:
                              "4", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                          page: 1,
                          showLoading: true,
                        ),
                      );
                      _refreshController.refreshCompleted();
                    } else {
                      _refreshController.refreshFailed();

                      ToastUtil().showSnackBar(
                        context: context,
                        message: groupLoansReportsBloc.internetAlert,
                        isError: true,
                      );
                    }
                  },
                );
              },
              child: (groupLoansReportsBloc.reportData != null &&
                      groupLoansReportsBloc.reportsDetList != null &&
                      groupLoansReportsBloc.reportsDetList!.isNotEmpty)
                  ? ListView.separated(
                      itemCount: groupLoansReportsBloc.reportsDetList!.length,
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
                                  groupLoansReportsBloc.reportData?.title ?? "",
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
                                        "customerID": groupLoansReportsBloc
                                                .reportsDetList![index].id ??
                                            "",
                                        "type": groupLoansReportsBloc
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
                                        message: groupLoansReportsBloc
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
                                              if (groupLoansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .headerText !=
                                                      null &&
                                                  groupLoansReportsBloc
                                                      .reportsDetList![index]
                                                      .headerText!
                                                      .isNotEmpty)
                                                Text(
                                                  groupLoansReportsBloc
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
                                                groupLoansReportsBloc
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
                                              if (groupLoansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .phNum !=
                                                      null &&
                                                  groupLoansReportsBloc
                                                      .reportsDetList![index]
                                                      .phNum!
                                                      .isNotEmpty)
                                                Text(
                                                  groupLoansReportsBloc
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
                                              if (groupLoansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .paymentDate !=
                                                      null &&
                                                  groupLoansReportsBloc
                                                      .reportsDetList![index]
                                                      .paymentDate!
                                                      .isNotEmpty)
                                                Text(
                                                  groupLoansReportsBloc
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
                                              if (groupLoansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .footerText !=
                                                      null &&
                                                  groupLoansReportsBloc
                                                      .reportsDetList![index]
                                                      .footerText!
                                                      .isNotEmpty)
                                                Text(
                                                  groupLoansReportsBloc
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
                                          groupLoansReportsBloc
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
                                          groupLoansReportsBloc
                                                  .reportsDetList![index]
                                                  .payStatus ??
                                              "",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            color: (groupLoansReportsBloc
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
                              groupLoansReportsBloc.noDataFoundText ??
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
        } else if (state is GroupLoansReportsNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => groupLoansReportsBloc.add(
              GetGroupLoansReports(
                type: "4", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans(
                page: 1,
              ),
            ),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => groupLoansReportsBloc.add(
              GetGroupLoansReports(
                type: "4", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
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
