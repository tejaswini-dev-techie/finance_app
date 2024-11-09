import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Screens/TransactionDetails/bloc/transaction_details_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:hp_finance/Utils/widgets_util/pop_up_alert.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final TransactionDetailsBloc transactionDetailsBloc =
      TransactionDetailsBloc();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    transactionDetailsBloc
        .add(GetTransactionDetailsEvent(page: 1, showLoading: true));
  }

  @override
  void dispose() {
    super.dispose();
    transactionDetailsBloc.close();
    _refreshController.dispose();
  }

  backAction() {
    Navigator.pop(context);
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
                      transactionDetailsBloc.transactionHistoryText,
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
          body: BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
            bloc: transactionDetailsBloc,
            builder: (context, state) {
              if (state is TransactionDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is TransactionDetailsLoaded) {
                return (transactionDetailsBloc.transactionData != null &&
                        transactionDetailsBloc.transactionHistoryList != null &&
                        transactionDetailsBloc
                            .transactionHistoryList!.isNotEmpty)
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!transactionDetailsBloc.saving) {
                            if (!transactionDetailsBloc.endPage) {
                              transactionDetailsBloc.saving = true;
                              transactionDetailsBloc.add(
                                GetTransactionDetailsEvent(
                                  page: transactionDetailsBloc.page,
                                  oldTransactionHistoryList:
                                      transactionDetailsBloc
                                              .transactionHistoryList ??
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
                          enablePullUp: transactionDetailsBloc.endPage
                              ? false
                              : (transactionDetailsBloc.isNetworkConnected ==
                                      false)
                                  ? false
                                  : true,
                          onRefresh: () {
                            InternetUtil().checkInternetConnection().then(
                              (internet) {
                                if (internet) {
                                  transactionDetailsBloc.add(
                                    GetTransactionDetailsEvent(
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
                                        transactionDetailsBloc.internetAlert,
                                    isError: true,
                                  );
                                }
                              },
                            );
                          },
                          child: ListView.separated(
                            itemCount: transactionDetailsBloc
                                .transactionHistoryList!.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 24.sp,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // /* Payment Successfull POP UP */
                                  // popupAlertDialog(
                                  //   internetAlert: internetAlert,
                                  //   context: context,
                                  //   imageHeight: 140.sp,
                                  //   imageWidth: 200.sp,
                                  //   titleText: "Congratulations!!",
                                  //   subTitleText:
                                  //       "Thank you! Your payment has been processed successfully",
                                  //   imagePath: ImageConstants.paymentSuccessImage,
                                  //   secondaryButtonText: "CANCEL",
                                  //   primaryButtonText: "VIEW DETAILS",
                                  //   onSecondaryButtonTap: () {
                                  //     Navigator.pop(context);
                                  //   },
                                  //   onPrimaryButtonTap: () {
                                  //     Navigator.pushReplacementNamed(
                                  //       context,
                                  //       RoutingConstants.routeTransactionDetails,
                                  //     );
                                  //   },
                                  // );
                                  // /* Payment Successfull POP UP */

                                  // /* Payment Failed POP UP */
                                  // popupAlertDialog(
                                  //   internetAlert: internetAlert,
                                  //   context: context,
                                  //   imageHeight: 140.sp,
                                  //   imageWidth: 200.sp,
                                  //   titleText: "Oops! Sorry, Payment Failed",
                                  //   subTitleText:
                                  //       "Unfortunately, we couldn’t complete your payment. Please check your payment details or try again later. If the issue persists, our support team is here to help",
                                  //   imagePath: ImageConstants.paymentFailedImage,
                                  //   secondaryButtonText: "CANCEL",
                                  //   primaryButtonText: "RETRY",
                                  //   onSecondaryButtonTap: () {
                                  //     Navigator.pop(context);
                                  //   },
                                  //   onPrimaryButtonTap: () {
                                  //     // TODO Razory Pay Navigation
                                  //   },
                                  // );
                                  // /* Payment Failed POP UP */

                                  /* Transaction Details POP UP */
                                  popupAlertDialog1(
                                    internetAlert:
                                        transactionDetailsBloc.internetAlert,
                                    context: context,
                                    titleText: transactionDetailsBloc
                                        .transactiondetailsText,
                                    secondaryButtonText: "",
                                    primaryButtonText: "",
                                    subWidget: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          color:
                                              ColorConstants.lighterBlueColor,
                                          thickness: 1.2.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6.sp,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          transactionDetailsBloc
                                                                  .transactionHistoryList![
                                                                      index]
                                                                  .transactionDetails
                                                                  ?.headerText ??
                                                              "PAID TO",
                                                          style: TextStyle(
                                                            fontSize: 8.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: ColorConstants
                                                                .lightBlackColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          transactionDetailsBloc
                                                                  .transactionHistoryList![
                                                                      index]
                                                                  .transactionDetails
                                                                  ?.title ??
                                                              "HP FINANCE",
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                ColorConstants
                                                                    .blackColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          transactionDetailsBloc
                                                                  .transactionHistoryList![
                                                                      index]
                                                                  .transactionDetails
                                                                  ?.subtitle ??
                                                              "16th August 2024 6:45 PM",
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
                                                  Flexible(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          transactionDetailsBloc
                                                                  .transactionHistoryList![
                                                                      index]
                                                                  .transactionDetails
                                                                  ?.amtText ??
                                                              "",
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: ColorConstants
                                                                .darkBlueColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          transactionDetailsBloc
                                                                  .transactionHistoryList![
                                                                      index]
                                                                  .transactionDetails
                                                                  ?.payStatus ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: (transactionDetailsBloc
                                                                        .transactionHistoryList![
                                                                            index]
                                                                        .transactionDetails
                                                                        ?.payStatusType !=
                                                                    "1")
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
                                              SizedBox(
                                                height: 3.sp,
                                              ),
                                              Divider(
                                                color: ColorConstants
                                                    .lighterBlueColor,
                                                thickness: 1.2.sp,
                                              ),
                                              SizedBox(
                                                height: 3.sp,
                                              ),

                                              /* Transaction ID */
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.transId ??
                                                    "Transaction ID",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                ),
                                              ),
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.transNum ??
                                                    "XXXXXXXXXXXX123456",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                              ),
                                              /* Transaction ID */

                                              SizedBox(
                                                height: 6.sp,
                                              ),

                                              /* Bank Name */
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.bankNameText ??
                                                    "Bank Name",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                ),
                                              ),
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.bankName ??
                                                    "SBI",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                              ),
                                              /* Bank Name */

                                              SizedBox(
                                                height: 6.sp,
                                              ),

                                              /* UTR Number */
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.utrNumText ??
                                                    "UTR Number",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                ),
                                              ),
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.utrNum ??
                                                    'XXXXXXXXXXXXX',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                              ),
                                              /* UTR Number */

                                              SizedBox(
                                                height: 6.sp,
                                              ),

                                              /* A/C Number */
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.accNumText ??
                                                    "A/C Number",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                ),
                                              ),
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.accNum ??
                                                    'XXXXXXXXXXXXX',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                              ),
                                              /* A/C Number */

                                              SizedBox(
                                                height: 6.sp,
                                              ),

                                              /* A/C Status */
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.accStatusText ??
                                                    "A/C Status",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                ),
                                              ),
                                              Text(
                                                transactionDetailsBloc
                                                        .transactionHistoryList![
                                                            index]
                                                        .transactionDetails
                                                        ?.accStatus ??
                                                    'ACTIVE',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                  color: (transactionDetailsBloc
                                                              .transactionHistoryList![
                                                                  index]
                                                              .transactionDetails
                                                              ?.accStatusType ==
                                                          "1")
                                                      ? ColorConstants
                                                          .mintGreenColor
                                                      : ColorConstants
                                                          .mintRedColor,
                                                ),
                                              ),
                                              /* A/C Status */

                                              SizedBox(
                                                height: 10.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    onSecondaryButtonTap: () {},
                                    onPrimaryButtonTap: () {},
                                  );
                                  /* Transaction Details POP UP */
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
                                            padding:
                                                EdgeInsets.only(right: 4.sp),
                                            child: Image.asset(
                                              ImageConstants.transactionImage,
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
                                                Text(
                                                  transactionDetailsBloc
                                                          .transactionHistoryList![
                                                              index]
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
                                                  transactionDetailsBloc
                                                          .transactionHistoryList![
                                                              index]
                                                          .memName ??
                                                      "HP FINANCE",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorConstants
                                                        .blackColor,
                                                  ),
                                                ),
                                                Text(
                                                  transactionDetailsBloc
                                                          .transactionHistoryList![
                                                              index]
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
                                                  transactionDetailsBloc
                                                          .transactionHistoryList![
                                                              index]
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
                                            transactionDetailsBloc
                                                    .transactionHistoryList![
                                                        index]
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
                                            transactionDetailsBloc
                                                    .transactionHistoryList![
                                                        index]
                                                    .payStatus ??
                                                "",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w700,
                                              color: (transactionDetailsBloc
                                                          .transactionHistoryList![
                                                              index]
                                                          .payStatusType !=
                                                      "1")
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
                                transactionDetailsBloc.noDataFoundText ??
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
              } else if (state is TransactionDetailsInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => transactionDetailsBloc.add(
                      GetTransactionDetailsEvent(page: 1, showLoading: true)),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => transactionDetailsBloc.add(
                      GetTransactionDetailsEvent(page: 1, showLoading: true)),
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
