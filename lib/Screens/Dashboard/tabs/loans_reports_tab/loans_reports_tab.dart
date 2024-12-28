import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_reports_tab/bloc/loans_reports_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class LoansReportsTab extends StatefulWidget {
  const LoansReportsTab({super.key});

  @override
  State<LoansReportsTab> createState() => _LoansReportsTabState();
}

class _LoansReportsTabState extends State<LoansReportsTab> {
  final LoansReportsBloc loansReportsBloc = LoansReportsBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    loansReportsBloc.add(
      GetLoanReports(
        type: "3",
        page: 1,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    loansReportsBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoansReportsBloc, LoansReportsState>(
      bloc: loansReportsBloc,
      builder: (context, state) {
        if (state is LoansReportsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.darkBlueColor,
            ),
          );
        } else if (state is LoansReportsLoaded) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!loansReportsBloc.saving) {
                if (!loansReportsBloc.endPage) {
                  loansReportsBloc.saving = true;
                  loansReportsBloc.add(
                    GetLoanReports(
                      type:
                          "3", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                      page: loansReportsBloc.page,
                      oldReportList: loansReportsBloc.reportsDetList ?? [],
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
              enablePullUp: loansReportsBloc.endPage
                  ? false
                  : (loansReportsBloc.isNetworkConnected == false)
                      ? false
                      : (loansReportsBloc.reportsDetList == null ||
                              loansReportsBloc.reportsDetList!.isEmpty)
                          ? false
                          : true,
              onRefresh: () {
                InternetUtil().checkInternetConnection().then(
                  (internet) {
                    if (internet) {
                      loansReportsBloc.add(
                        GetLoanReports(
                          type:
                              "3", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                          page: 1,
                          showLoading: true,
                        ),
                      );
                      _refreshController.refreshCompleted();
                    } else {
                      _refreshController.refreshFailed();

                      ToastUtil().showSnackBar(
                        context: context,
                        message: loansReportsBloc.internetAlert,
                        isError: true,
                      );
                    }
                  },
                );
              },
              child: (loansReportsBloc.reportData != null &&
                      loansReportsBloc.reportsDetList != null &&
                      loansReportsBloc.reportsDetList!.isNotEmpty)
                  ? ListView.separated(
                      itemCount: loansReportsBloc.reportsDetList!.length,
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
                                  loansReportsBloc.reportData?.title ?? "",
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
                                        "customerID": loansReportsBloc
                                                .reportsDetList![index].id ??
                                            "",
                                        "type": loansReportsBloc
                                                .reportsDetList![index].type ??
                                            "PIGMY",
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
                                        message: loansReportsBloc
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
                                              if (loansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .headerText !=
                                                      null &&
                                                  loansReportsBloc
                                                      .reportsDetList![index]
                                                      .headerText!
                                                      .isNotEmpty)
                                                Text(
                                                  loansReportsBloc
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
                                                loansReportsBloc
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
                                              if (loansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .phNum !=
                                                      null &&
                                                  loansReportsBloc
                                                      .reportsDetList![index]
                                                      .phNum!
                                                      .isNotEmpty)
                                                Text(
                                                  loansReportsBloc
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
                                              if (loansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .paymentDate !=
                                                      null &&
                                                  loansReportsBloc
                                                      .reportsDetList![index]
                                                      .paymentDate!
                                                      .isNotEmpty)
                                                Text(
                                                  loansReportsBloc
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
                                              if (loansReportsBloc
                                                          .reportsDetList![
                                                              index]
                                                          .footerText !=
                                                      null &&
                                                  loansReportsBloc
                                                      .reportsDetList![index]
                                                      .footerText!
                                                      .isNotEmpty)
                                                Text(
                                                  loansReportsBloc
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
                                          loansReportsBloc
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
                                          loansReportsBloc
                                                  .reportsDetList![index]
                                                  .payStatus ??
                                              "",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            color: (loansReportsBloc
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
                              loansReportsBloc.noDataFoundText ??
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
        } else if (state is LoansReportsNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => loansReportsBloc.add(
              GetLoanReports(
                type: "3", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                page: 1,
                showLoading: true,
              ),
            ),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => loansReportsBloc.add(
              GetLoanReports(
                type: "3", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                page: 1,
                showLoading: true,
              ),
            ),
            state: 2,
          );
        }
      },
    );
  }
}
