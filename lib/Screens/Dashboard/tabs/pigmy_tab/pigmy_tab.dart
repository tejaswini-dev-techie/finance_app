import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/bloc/pigmy_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/no_pigmy_started.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_screen.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_shimmer.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class PigmyTab extends StatefulWidget {
  const PigmyTab({super.key});

  @override
  State<PigmyTab> createState() => _PigmyTabState();
}

class _PigmyTabState extends State<PigmyTab> {
  final PigmyBloc pigmyBloc = PigmyBloc();

  @override
  void initState() {
    super.initState();
    pigmyBloc.add(GetPigmyDetails());
  }

  @override
  void dispose() {
    super.dispose();
    pigmyBloc.close();
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
            message: pigmyBloc.internetAlert ?? "",
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
            "type": "1",
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeLearnAboutPigmySavingsScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: pigmyBloc.internetAlert ??
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
            message: pigmyBloc.internetAlert ??
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
            message: pigmyBloc.internetAlert ??
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
            message: pigmyBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PigmyBloc, PigmyState>(
      bloc: pigmyBloc,
      builder: (context, state) {
        if (state is PigmyLoading) {
          return const PigmyShimmer();
        } else if (state is PigmyLoaded) {
          return (pigmyBloc.pigmyData != null &&
                  pigmyBloc.pigmyData?.pigmyMenusList != null &&
                  pigmyBloc.pigmyData!.pigmyMenusList!.isNotEmpty)
              ? SingleChildScrollView(
                  child: PigmyScreen(
                    pigmyBloc: pigmyBloc,
                    titleText: pigmyBloc.pigmyData?.pigmyStatusNudgeTitle ??
                        'Pigmy Withdrawal Request Rejected',
                    subTitleText: pigmyBloc
                            .pigmyData?.pigmyStatusNudgeSubtitle ??
                        'Unfortunately, your Pigmy withdrawal request has been rejected. Please review the details and contact our support team for further assistance or to address any issues.',
                    btnText: pigmyBloc.pigmyData?.pigmyStatusNudgeBtn ?? "",
                    internetAlert: pigmyBloc.internetAlert,
                    onContactAction: () => onContactAction(
                        btnText:
                            pigmyBloc.pigmyData?.pigmyStatusNudgeBtn ?? ""),
                    learnAboutPigmySavingsWidget: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      child: Column(
                        children: [
                          (pigmyBloc.pigmyData?.learnPigmyBtnText != null &&
                                  pigmyBloc
                                      .pigmyData!.learnPigmyBtnText!.isNotEmpty)
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () => onClickHereAction(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            pigmyBloc.pigmyData
                                                    ?.learnPigmyBtnText ??
                                                "",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                                  ColorConstants.darkBlueColor,
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
                                  ),
                                )
                              : const SizedBox.shrink(),
                          (pigmyBloc.pigmyData?.learnPigmyBtnText != null &&
                                  pigmyBloc
                                      .pigmyData!.learnPigmyBtnText!.isNotEmpty)
                              ? SizedBox(
                                  height: 5.sp,
                                )
                              : const SizedBox.shrink(),
                          (pigmyBloc.pigmyData?.withdrawPigmyBtnText != null &&
                                  pigmyBloc.pigmyData!.withdrawPigmyBtnText!
                                      .isNotEmpty)
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () => onWithdrawPigmySavingsAction(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            pigmyBloc.pigmyData
                                                    ?.withdrawPigmyBtnText ??
                                                "",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                                  ColorConstants.darkBlueColor,
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
                                  ),
                                )
                              : const SizedBox.shrink(),
                          (pigmyBloc.pigmyData?.withdrawPigmyBtnText != null &&
                                  pigmyBloc.pigmyData!.withdrawPigmyBtnText!
                                      .isNotEmpty)
                              ? SizedBox(
                                  height: 5.sp,
                                )
                              : const SizedBox.shrink(),
                          (pigmyBloc.pigmyData
                                          ?.pigmyTransactionHistoryBtnText !=
                                      null &&
                                  pigmyBloc
                                      .pigmyData!
                                      .pigmyTransactionHistoryBtnText!
                                      .isNotEmpty)
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () => onPigmyHistoryAction(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            pigmyBloc.pigmyData
                                                    ?.pigmyTransactionHistoryBtnText ??
                                                "",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color:
                                                  ColorConstants.darkBlueColor,
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
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                )
              :
              /* Pigmy Not Started */
              SingleChildScrollView(
                  child: PigmyNotStarted(
                    internetAlert: pigmyBloc.internetAlert,
                    startNowText: pigmyBloc.pigmyData?.btnText ?? "",
                    noPigmyTitleText: pigmyBloc.pigmyData?.noPigmyTitle ?? "",
                    noPigmySubTitleText:
                        pigmyBloc.pigmyData?.noPigmySubtitle ?? "",
                    footertext: pigmyBloc.pigmyData?.footerText ?? "",
                    onStartNowAction: () => onStartNowAction(),
                    onClickHereAction: () => onClickHereAction(),
                  ),
                );
          /* Pigmy Not Started */
        } else if (state is PigmyNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => pigmyBloc.add(GetPigmyDetails()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => pigmyBloc.add(GetPigmyDetails()),
            state: 2,
          );
        }
      },
    );
  }
}
