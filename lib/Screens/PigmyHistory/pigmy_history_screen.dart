import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/PigmyHistory/bloc/pigmy_history_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class PigmyHistoryScreen extends StatefulWidget {
  const PigmyHistoryScreen({super.key});

  @override
  State<PigmyHistoryScreen> createState() => _PigmyHistoryScreenState();
}

class _PigmyHistoryScreenState extends State<PigmyHistoryScreen> {
  final PigmyHistoryBloc pigmyHistoryBloc = PigmyHistoryBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    pigmyHistoryBloc.add(
      GetPigmyTransactionDetailsEvent(
        page: 1,
        showLoading: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pigmyHistoryBloc.close();
    _refreshController.dispose();
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
                      pigmyHistoryBloc.pigmyHistoryText,
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
          body: BlocBuilder<PigmyHistoryBloc, PigmyHistoryState>(
            bloc: pigmyHistoryBloc,
            builder: (context, state) {
              if (state is PigmyHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is PigmyHistoryLoaded) {
                return (pigmyHistoryBloc.pigmyTransactionData != null &&
                        pigmyHistoryBloc.pigmyTransactionData?.pigmyHistList !=
                            null &&
                        pigmyHistoryBloc
                            .pigmyTransactionData!.pigmyHistList!.isNotEmpty)
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!pigmyHistoryBloc.saving) {
                            if (!pigmyHistoryBloc.endPage) {
                              pigmyHistoryBloc.saving = true;
                              pigmyHistoryBloc.add(
                                GetPigmyTransactionDetailsEvent(
                                  page: pigmyHistoryBloc.page,
                                  oldPigmyHistoryList:
                                      pigmyHistoryBloc.pigmyHistoryList ?? [],
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
                          enablePullUp: pigmyHistoryBloc.endPage
                              ? false
                              : (pigmyHistoryBloc.isNetworkConnected == false)
                                  ? false
                                  : true,
                          onRefresh: () {
                            InternetUtil().checkInternetConnection().then(
                              (internet) {
                                if (internet) {
                                  pigmyHistoryBloc.add(
                                    GetPigmyTransactionDetailsEvent(
                                      page: 1,
                                      showLoading: true,
                                    ),
                                  );
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();

                                  ToastUtil().showSnackBar(
                                    context: context,
                                    message: pigmyHistoryBloc.internetAlert,
                                    isError: true,
                                  );
                                }
                              },
                            );
                          },
                          child: ListView.separated(
                            itemCount:
                                pigmyHistoryBloc.pigmyHistoryList!.length,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .headerText ??
                                                "PAID TO",
                                            style: TextStyle(
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants
                                                  .lightBlackColor,
                                            ),
                                          ),
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .memName ??
                                                "HP FINANCE",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstants.blackColor,
                                            ),
                                          ),
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .paymentDate ??
                                                "16th August 2024 6:45 PM",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants
                                                  .lightBlackColor,
                                            ),
                                          ),
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .footerText ??
                                                "PIGMYCODE1234",
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
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
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
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .payStatus ??
                                                "", //1-PAID|2-DUE|3-WITHDRAW
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: (pigmyHistoryBloc
                                                          .pigmyHistoryList![
                                                              index]
                                                          .payStatusType !=
                                                      "1")
                                                  ? ColorConstants.mintRedColor
                                                  : ColorConstants
                                                      .mintGreenColor,
                                            ),
                                          ),
                                          Text(
                                            pigmyHistoryBloc
                                                    .pigmyHistoryList![index]
                                                    .accStatus ??
                                                "", //1-ACTIVE|2-CLOSED
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: (pigmyHistoryBloc
                                                          .pigmyHistoryList![
                                                              index]
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
                              return SizedBox(
                                height: 12.sp,
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
                                pigmyHistoryBloc.noDataFoundText ??
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
              } else if (state is PigmyHistoryNoInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => pigmyHistoryBloc.add(
                    GetPigmyTransactionDetailsEvent(
                      page: 1,
                      showLoading: true,
                    ),
                  ),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => pigmyHistoryBloc.add(
                    GetPigmyTransactionDetailsEvent(
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
