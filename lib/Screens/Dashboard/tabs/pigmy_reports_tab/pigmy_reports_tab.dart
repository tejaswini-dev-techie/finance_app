import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_reports_tab/bloc/pigmy_reports_tab_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class PigmyReportsTab extends StatefulWidget {
  const PigmyReportsTab({super.key});

  @override
  State<PigmyReportsTab> createState() => _PigmyReportsTabState();
}

class _PigmyReportsTabState extends State<PigmyReportsTab> {
  final PigmyReportsTabBloc pigmyReportsTabBloc = PigmyReportsTabBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    pigmyReportsTabBloc.add(
      GetPigmyReports(
        page: 1,
        showLoading: true,
        type: "1", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    pigmyReportsTabBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PigmyReportsTabBloc, PigmyReportsTabState>(
      bloc: pigmyReportsTabBloc,
      builder: (context, state) {
        if (state is PigmyReportsTabLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorConstants.darkBlueColor,
            ),
          );
        } else if (state is PigmyReportsTabLoaded) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!pigmyReportsTabBloc.saving) {
                if (!pigmyReportsTabBloc.endPage) {
                  pigmyReportsTabBloc.saving = true;
                  pigmyReportsTabBloc.add(
                    GetPigmyReports(
                      type:
                          "1", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                      page: pigmyReportsTabBloc.page,
                      oldReportList: pigmyReportsTabBloc.reportsDetList ?? [],
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
              enablePullUp: pigmyReportsTabBloc.endPage
                  ? false
                  : (pigmyReportsTabBloc.isNetworkConnected == false)
                      ? false
                      : (pigmyReportsTabBloc.reportsDetList == null ||
                              pigmyReportsTabBloc.reportsDetList!.isEmpty)
                          ? false
                          : true,
              onRefresh: () {
                InternetUtil().checkInternetConnection().then(
                  (internet) {
                    if (internet) {
                      pigmyReportsTabBloc.add(
                        GetPigmyReports(
                          type:
                              "1", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                          page: 1,
                          showLoading: true,
                        ),
                      );
                      _refreshController.refreshCompleted();
                    } else {
                      _refreshController.refreshFailed();

                      ToastUtil().showSnackBar(
                        context: context,
                        message: pigmyReportsTabBloc.internetAlert,
                        isError: true,
                      );
                    }
                  },
                );
              },
              child: (pigmyReportsTabBloc.reportData != null &&
                      pigmyReportsTabBloc.reportsDetList != null &&
                      pigmyReportsTabBloc.reportsDetList!.isNotEmpty)
                  ? ListView.separated(
                      itemCount: pigmyReportsTabBloc.reportsDetList!.length,
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
                                  pigmyReportsTabBloc.reportData?.title ?? "",
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
                                        "customerID": pigmyReportsTabBloc
                                                .reportsDetList![index].id ??
                                            "",
                                        "type": pigmyReportsTabBloc
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
                                        message: pigmyReportsTabBloc
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
                                              if (pigmyReportsTabBloc
                                                          .reportsDetList![
                                                              index]
                                                          .headerText !=
                                                      null &&
                                                  pigmyReportsTabBloc
                                                      .reportsDetList![index]
                                                      .headerText!
                                                      .isNotEmpty)
                                                Text(
                                                  pigmyReportsTabBloc
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
                                                pigmyReportsTabBloc
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
                                              if (pigmyReportsTabBloc
                                                          .reportsDetList![
                                                              index]
                                                          .phNum !=
                                                      null &&
                                                  pigmyReportsTabBloc
                                                      .reportsDetList![index]
                                                      .phNum!
                                                      .isNotEmpty)
                                                Text(
                                                  pigmyReportsTabBloc
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
                                              if (pigmyReportsTabBloc
                                                          .reportsDetList![
                                                              index]
                                                          .paymentDate !=
                                                      null &&
                                                  pigmyReportsTabBloc
                                                      .reportsDetList![index]
                                                      .paymentDate!
                                                      .isNotEmpty)
                                                Text(
                                                  pigmyReportsTabBloc
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
                                              if (pigmyReportsTabBloc
                                                          .reportsDetList![
                                                              index]
                                                          .footerText !=
                                                      null &&
                                                  pigmyReportsTabBloc
                                                      .reportsDetList![index]
                                                      .footerText!
                                                      .isNotEmpty)
                                                Text(
                                                  pigmyReportsTabBloc
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
                                          pigmyReportsTabBloc
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
                                          pigmyReportsTabBloc
                                                  .reportsDetList![index]
                                                  .payStatus ??
                                              "",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            color: (pigmyReportsTabBloc
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
                              pigmyReportsTabBloc.noDataFoundText ??
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
        } else if (state is PigmyReportsTabNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => pigmyReportsTabBloc.add(
              GetPigmyReports(
                type: "1", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
                page: 1,
                showLoading: true,
              ),
            ),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => pigmyReportsTabBloc.add(
              GetPigmyReports(
                type: "1", // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
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
