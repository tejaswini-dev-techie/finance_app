import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/CustomerProfileVerification/bloc/customer_profile_verification_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class CustomerProfileVerification extends StatefulWidget {
  const CustomerProfileVerification({super.key});

  @override
  State<CustomerProfileVerification> createState() =>
      _CustomerProfileVerificationState();
}

class _CustomerProfileVerificationState
    extends State<CustomerProfileVerification> {
  final CustomerProfileVerificationBloc customerProfileVerificationBloc =
      CustomerProfileVerificationBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    customerProfileVerificationBloc.add(GetCustomerVerificationDetails());
    super.initState();
  }

  @override
  void dispose() {
    customerProfileVerificationBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  backAction() {
    Navigator.pushReplacementNamed(
      context,
      RoutingConstants.routeDashboardScreen,
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
                  const Spacer(),
                  Text(
                    "Verify Information",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 25.sp,
                  )
                ],
              ),
            ),
          ),
          body: BlocBuilder<CustomerProfileVerificationBloc,
              CustomerProfileVerificationState>(
            bloc: customerProfileVerificationBloc,
            builder: (context, state) {
              if (state is CustomerProfileVerificationLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is CustomerProfileVerificationLoaded) {
                return NotificationListener<ScrollEndNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!customerProfileVerificationBloc.saving) {
                      if (!customerProfileVerificationBloc.endPage) {
                        customerProfileVerificationBloc.saving = true;
                        customerProfileVerificationBloc.add(
                          GetCustomerVerificationDetails(
                            page: customerProfileVerificationBloc.page,
                            oldInfoList:
                                customerProfileVerificationBloc.infoDetList ??
                                    [],
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
                    enablePullUp: customerProfileVerificationBloc.endPage
                        ? false
                        : (customerProfileVerificationBloc.isNetworkConnected ==
                                false)
                            ? false
                            : (customerProfileVerificationBloc.infoDetList ==
                                        null ||
                                    customerProfileVerificationBloc
                                        .infoDetList!.isEmpty)
                                ? false
                                : true,
                    onRefresh: () {
                      InternetUtil().checkInternetConnection().then(
                        (internet) {
                          if (internet) {
                            customerProfileVerificationBloc.add(
                              GetCustomerVerificationDetails(
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
                                  customerProfileVerificationBloc.internetAlert,
                              isError: true,
                            );
                          }
                        },
                      );
                    },
                    child: (customerProfileVerificationBloc.reportData !=
                                null &&
                            customerProfileVerificationBloc.infoDetList !=
                                null &&
                            customerProfileVerificationBloc
                                .infoDetList!.isNotEmpty)
                        ? ListView.separated(
                            itemCount: customerProfileVerificationBloc
                                .infoDetList!.length,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.sp, vertical: 12.sp),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 12.sp,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.sp, vertical: 8.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  border: Border.all(
                                    color: ColorConstants.lightGreyColor,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        InternetUtil()
                                            .checkInternetConnection()
                                            .then(
                                          (internet) async {
                                            if (internet) {
                                              if (customerProfileVerificationBloc
                                                          .infoDetList![index]
                                                          .payStatusType !=
                                                      null &&
                                                  customerProfileVerificationBloc
                                                      .infoDetList![index]
                                                      .payStatusType!
                                                      .isNotEmpty &&
                                                  customerProfileVerificationBloc
                                                          .infoDetList![index]
                                                          .payStatusType !=
                                                      "1") {
                                                Map<String, dynamic> data = {};
                                                data = {
                                                  "title": "VERIFICATION",
                                                  "id":
                                                      customerProfileVerificationBloc
                                                          .infoDetList![index]
                                                          .id,
                                                };
                                                Navigator.pushNamed(
                                                  context,
                                                  RoutingConstants
                                                      .routeVerifyCustomersDetailsScreen,
                                                  arguments: {"data": data},
                                                );
                                              }
                                            } else {
                                              ToastUtil().showSnackBar(
                                                context: context,
                                                message:
                                                    customerProfileVerificationBloc
                                                            .internetAlert ??
                                                        "Please check your internet connection",
                                                isError: true,
                                              );
                                            }
                                          },
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        customerProfileVerificationBloc
                                                                .infoDetList![
                                                                    index]
                                                                .memName ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: ColorConstants
                                                              .blackColor,
                                                        ),
                                                      ),
                                                      if (customerProfileVerificationBloc
                                                                  .infoDetList![
                                                                      index]
                                                                  .phNum !=
                                                              null &&
                                                          customerProfileVerificationBloc
                                                              .infoDetList![
                                                                  index]
                                                              .phNum!
                                                              .isNotEmpty)
                                                        Text(
                                                          customerProfileVerificationBloc
                                                                  .infoDetList![
                                                                      index]
                                                                  .phNum ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorConstants
                                                                .lightBlackColor,
                                                          ),
                                                        ),
                                                      if (customerProfileVerificationBloc
                                                                  .infoDetList![
                                                                      index]
                                                                  .footerText !=
                                                              null &&
                                                          customerProfileVerificationBloc
                                                              .infoDetList![
                                                                  index]
                                                              .footerText!
                                                              .isNotEmpty)
                                                        Text(
                                                          customerProfileVerificationBloc
                                                                  .infoDetList![
                                                                      index]
                                                                  .footerText ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                  customerProfileVerificationBloc
                                                          .infoDetList![index]
                                                          .status ??
                                                      "",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: (customerProfileVerificationBloc
                                                                .infoDetList![
                                                                    index]
                                                                .payStatusType ==
                                                            "2") // 1-VERIFIED | 2-PENDING
                                                        ? ColorConstants
                                                            .mintRedColor
                                                        : ColorConstants
                                                            .mintGreenColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  child: Text(
                                    customerProfileVerificationBloc
                                            .noDataFoundText ??
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
              } else if (state is CustomerProfileVerificationNoInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => customerProfileVerificationBloc.add(
                    GetCustomerVerificationDetails(
                      page: 1,
                      showLoading: true,
                    ),
                  ),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => customerProfileVerificationBloc.add(
                    GetCustomerVerificationDetails(
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
