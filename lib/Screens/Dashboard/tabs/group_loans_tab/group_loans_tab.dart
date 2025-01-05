import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/bloc/group_loans_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/widgets/group_loans_screen.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/widgets/no_group_loans.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_shimmer.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:hp_finance/Utils/widgets_util/pop_up_alert.dart';
import 'package:sizer/sizer.dart';

class GroupLoansTab extends StatefulWidget {
  const GroupLoansTab({super.key});

  @override
  State<GroupLoansTab> createState() => _GroupLoansTabState();
}

class _GroupLoansTabState extends State<GroupLoansTab> {
  final GroupLoansBloc groupLoansBloc = GroupLoansBloc();

  @override
  void initState() {
    super.initState();
    groupLoansBloc.add(GetGroupDetails());
  }

  @override
  void dispose() {
    super.dispose();
    groupLoansBloc.close();
  }

  void onEnquireNowAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(context, RoutingConstants.routeEnquiryScreen);
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupLoansBloc.internetAlert ??
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
            message: groupLoansBloc.internetAlert ??
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
          Navigator.pushNamed(
              context, RoutingConstants.routeTransactionDetails);
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupLoansBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onGroupMembersAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "2", // type: 1 - G PIGMY | 2 - G Loans
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeGroupMembersDetailScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: groupLoansBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupLoansBloc, GroupLoansState>(
      bloc: groupLoansBloc,
      builder: (context, state) {
        if (state is GroupLoansLoading) {
          return const PigmyShimmer();
        } else if (state is GroupLoansLoaded) {
          return (groupLoansBloc.grouploanData != null &&
                  groupLoansBloc.grouploanData?.loansMenusList != null &&
                  groupLoansBloc.grouploanData!.loansMenusList!.isNotEmpty)
              ? SingleChildScrollView(
                  child: GroupLoansScreen(
                    groupLoansBloc: groupLoansBloc,
                    groupMembersText:
                        groupLoansBloc.grouploanData?.groupMemDet ?? "",
                    onGroupMembersAction: () => onGroupMembersAction(),
                    transactionHistoryText:
                        groupLoansBloc.grouploanData?.transactionHistoryText ??
                            "",
                    onTransactionHistoryAction: () =>
                        onTransactionHistoryAction(),
                    onRepayAllAction: () {
                      if (groupLoansBloc.grouploanData?.payAllNudge != null) {
                        popupAlertDialog1(
                          internetAlert: groupLoansBloc.internetAlert,
                          context: context,
                          titleText: groupLoansBloc
                                  .grouploanData?.payAllNudge?.payAllText ??
                              "",
                          secondaryButtonText: groupLoansBloc
                                  .grouploanData?.payAllNudge?.secBtnText ??
                              "",
                          primaryButtonText: groupLoansBloc
                                  .grouploanData?.payAllNudge?.primaryBtnText ??
                              "",
                          subWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: ColorConstants.lighterBlueColor,
                                thickness: 1.2.sp,
                              ),
                              Text(
                                groupLoansBloc.grouploanData?.payAllNudge
                                        ?.loadCodeText ??
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
                              (groupLoansBloc.grouploanData!.payAllNudge!
                                              .installmentDetList !=
                                          null &&
                                      groupLoansBloc.grouploanData!.payAllNudge!
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
                                              groupLoansBloc
                                                      .grouploanData!
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
                                              groupLoansBloc
                                                      .grouploanData!
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
                                      itemCount: groupLoansBloc
                                          .grouploanData!
                                          .payAllNudge!
                                          .installmentDetList!
                                          .length)
                                  : const SizedBox.shrink(),
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
              : NoGroupLoansYet(
                  internetAlert: groupLoansBloc.internetAlert,
                  enquireNowText: groupLoansBloc.grouploanData?.btnText ?? "",
                  noLoansTitleText:
                      groupLoansBloc.grouploanData?.noGloanTitle ?? "",
                  noLoansSubTitleText:
                      groupLoansBloc.grouploanData?.noGloanSubtitle ?? "",
                  onEnquireNowAction: () => onEnquireNowAction(),
                );
        } else if (state is GroupLoansNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => groupLoansBloc.add(GetGroupDetails()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => groupLoansBloc.add(GetGroupDetails()),
            state: 2,
          );
        }
      },
    );
  }
}
