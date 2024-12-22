import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/agents_tab_bloc_components/agents_tab_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/widgets/info_cards_agents.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/home_tab_shimmer.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class AgentsTab extends StatefulWidget {
  const AgentsTab({super.key});

  @override
  State<AgentsTab> createState() => _AgentsTabState();
}

class _AgentsTabState extends State<AgentsTab> {
  final AgentsTabBloc agentsTabBloc = AgentsTabBloc();

  @override
  void initState() {
    super.initState();
    agentsTabBloc.add(GetAgentsDetailsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    agentsTabBloc.close();
  }

  void onFindCustomerDetailsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "1",
          };

          Navigator.pushNamed(
            context,
            RoutingConstants.routeSearchCustomerDetails,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: agentsTabBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onFindGroupDetailsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "2",
          };

          Navigator.pushNamed(
            context,
            RoutingConstants.routeSearchCustomerDetails,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: agentsTabBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onVerifyCustomerDetailsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeVerifyCustomersDetailsScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: agentsTabBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void onUpdatePaymentDetailsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeAgentUpdatePaymentDetailsScreen,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: agentsTabBloc.internetAlert ??
                "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentsTabBloc, AgentsTabState>(
      bloc: agentsTabBloc,
      builder: (context, state) {
        if (state is AgentsTabLoading) {
          return const HomeTabShimmer();
        } else if (state is AgentsTabLoaded) {
          return (agentsTabBloc.userData != null)
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 10.sp,
                    ),
                    child: Column(
                      children: [
                        /* Info Cards */
                        (agentsTabBloc.userData?.agentMenusList != null &&
                                agentsTabBloc
                                    .userData!.agentMenusList!.isNotEmpty)
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: agentsTabBloc
                                    .userData?.agentMenusList!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12.sp,
                                  mainAxisSpacing: 16.sp,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return AgentsInfoCards(
                                    menuDet: agentsTabBloc
                                        .userData?.agentMenusList![index],
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                        /* Info Cards */

                        SizedBox(
                          height: 8.sp,
                        ),
                        (agentsTabBloc.userData?.findBtnText != null &&
                                agentsTabBloc.userData!.findBtnText!.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: InkWell(
                                  onTap: () => onFindCustomerDetailsAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          agentsTabBloc.userData?.findBtnText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
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
                        (agentsTabBloc.userData?.finGrpBtnTxt != null &&
                                agentsTabBloc
                                    .userData!.finGrpBtnTxt!.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: InkWell(
                                  onTap: () => onFindGroupDetailsAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          agentsTabBloc
                                                  .userData?.finGrpBtnTxt ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
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
                        (agentsTabBloc.userData?.verifyBtnText != null &&
                                agentsTabBloc
                                    .userData!.verifyBtnText!.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: InkWell(
                                  onTap: () => onVerifyCustomerDetailsAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          agentsTabBloc
                                                  .userData?.verifyBtnText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
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
                        (agentsTabBloc.userData?.updatePaymentDetText != null &&
                                agentsTabBloc
                                    .userData!.updatePaymentDetText!.isNotEmpty)
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: InkWell(
                                  onTap: () => onUpdatePaymentDetailsAction(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          agentsTabBloc.userData
                                                  ?.updatePaymentDetText ??
                                              "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ColorConstants.darkBlueColor,
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
                )
              : const SizedBox.shrink();
        } else if (state is AgentsTabNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => agentsTabBloc.add(GetAgentsDetailsEvent()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => agentsTabBloc.add(GetAgentsDetailsEvent()),
            state: 2,
          );
        }
      },
    );
  }
}
