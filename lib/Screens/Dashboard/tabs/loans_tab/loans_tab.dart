import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/bloc/loans_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/widgets/loans_screen.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/widgets/no_loans.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_shimmer.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:hp_finance/Utils/widgets_util/pop_up_alert.dart';
import 'package:sizer/sizer.dart';

class LoansTab extends StatefulWidget {
  const LoansTab({super.key});

  @override
  State<LoansTab> createState() => _LoansTabState();
}

class _LoansTabState extends State<LoansTab> {
  final LoansBloc loansBloc = LoansBloc();
  // /* JSON Text */
  // String? internetAlert = "Please check your internet connection!";
  // /* JSON Text */

  // String? enquireNowText = "ENQUIRE NOW";
  // String? noLoansTitleText = "Unlock Financial Freedom with Our Loans!";
  // String? noLoansSubTitleText =
  //     "Need a boost to achieve your dreams? Whether it’s for personal needs or a business venture, our loans offer flexible terms and easy approval. Don’t miss out on the financial support you deserve. Start your journey today and take the first step toward your goals!";
  // String? transactionHistoryText = "Check Transaction History";
  // String? popupTitle = "Pay All";
  // String? cancelText = "CANCEL";
  // String? btnText = "COMPLETE PAYMENT";

  @override
  void initState() {
    super.initState();
    loansBloc.add(GetLoanDetails());
  }

  @override
  void dispose() {
    super.dispose();
    loansBloc.close();
  }

  void onEnquireNowAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(context, RoutingConstants.routeEnquiryScreen);
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: loansBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onCompletePaymentAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          // TODO Razor Pay
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: loansBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onTransactionHistoryAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(context, RoutingConstants.routeTransactionDetails,
              arguments: {
                'data': {
                  'type': '1',
                },
              });
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: loansBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoansBloc, LoansState>(
      bloc: loansBloc,
      builder: (context, state) {
        if (state is LoansLoading) {
          return const PigmyShimmer();
        } else if (state is LoansLoaded) {
          return (loansBloc.loanData != null &&
                  loansBloc.loanData?.loansMenusList != null &&
                  loansBloc.loanData!.loansMenusList!.isNotEmpty)
              ? SingleChildScrollView(
                  child: LoansScreen(
                    loansBloc: loansBloc,
                    onTransactionHistoryAction: () =>
                        onTransactionHistoryAction(),
                    onRepayAllAction: () {
                      if (loansBloc.loanData?.payAllNudge != null) {
                        popupAlertDialog1(
                          internetAlert: loansBloc.internetAlert,
                          context: context,
                          titleText:
                              loansBloc.loanData?.payAllNudge?.payAllText ?? "",
                          secondaryButtonText:
                              loansBloc.loanData?.payAllNudge?.secBtnText ?? "",
                          primaryButtonText:
                              loansBloc.loanData?.payAllNudge?.primaryBtnText ??
                                  "",
                          subWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: ColorConstants.lighterBlueColor,
                                thickness: 1.2.sp,
                              ),
                              Text(
                                loansBloc.loanData?.payAllNudge?.loadCodeText ??
                                    "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.darkBlueColor,
                                ),
                              ),
                              SizedBox(
                                height: 6.sp,
                              ),
                              (loansBloc.loanData!.payAllNudge!
                                              .installmentDetList !=
                                          null &&
                                      loansBloc.loanData!.payAllNudge!
                                          .installmentDetList!.isNotEmpty)
                                  ? ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6.sp),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              loansBloc
                                                      .loanData!
                                                      .payAllNudge!
                                                      .installmentDetList![
                                                          index]
                                                      .title ??
                                                  "",
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
                                              loansBloc
                                                      .loanData!
                                                      .payAllNudge!
                                                      .installmentDetList![
                                                          index]
                                                      .subtitle ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 6.sp,
                                        );
                                      },
                                      itemCount: loansBloc
                                          .loanData!
                                          .payAllNudge!
                                          .installmentDetList!
                                          .length)
                                  : const SizedBox.shrink(),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //     vertical: 6.sp,
                              //   ),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         "LOANCODE1234",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w700,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.darkBlueColor,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 6.sp,
                              //       ),
                              //       Text(
                              //         "Total Repayment Installment",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 10.sp,
                              //           fontWeight: FontWeight.w500,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.lightBlackColor,
                              //         ),
                              //       ),
                              //       Text(
                              //         "6",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w700,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.darkBlueColor,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 6.sp,
                              //       ),
                              //       Text(
                              //         "Installments Over",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 10.sp,
                              //           fontWeight: FontWeight.w500,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.lightBlackColor,
                              //         ),
                              //       ),
                              //       Text(
                              //         "Aug 2024 - Jan 2025",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w700,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.darkBlueColor,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 6.sp,
                              //       ),
                              //       Text(
                              //         "Amount Payable",
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 10.sp,
                              //           fontWeight: FontWeight.w500,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.lightBlackColor,
                              //         ),
                              //       ),
                              //       Text(
                              //         '\u20B920000',
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w700,
                              //           fontStyle: FontStyle.normal,
                              //           color: ColorConstants.darkBlueColor,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 10.sp,
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              SizedBox(
                                height: 10.sp,
                              ),
                            ],
                          ),
                          onSecondaryButtonTap: () {
                            Navigator.pop(context);
                          },
                          onPrimaryButtonTap: () => onCompletePaymentAction(),
                        );
                      }
                    },
                  ),
                )
              : SingleChildScrollView(
                  child: NoLoansYet(
                    internetAlert: loansBloc.internetAlert,
                    enquireNowText: loansBloc.loanData?.btnText,
                    noLoansTitleText: loansBloc.loanData?.noLoanTitle ?? "",
                    noLoansSubTitleText:
                        loansBloc.loanData?.noLoanSubtitle ?? "",
                    onEnquireNowAction: () => onEnquireNowAction(),
                  ),
                );
        } else if (state is LoansNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => loansBloc.add(GetLoanDetails()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => loansBloc.add(GetLoanDetails()),
            state: 2,
          );
        }
      },
    );
  }
}
