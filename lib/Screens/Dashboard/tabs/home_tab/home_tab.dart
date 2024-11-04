import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/dashboard_bloc_components/dashboard_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/banner_carousel.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/dues_section.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/home_tab_shimmer.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/kyc_status_widget.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/home_tab/widgets/services.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final DashboardBloc dashboardBloc = DashboardBloc();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    dashboardBloc.add(GetUserDetails());
  }

  void onContactAction({String? btnText}) {
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
            message: dashboardBloc.internetAlert,
            isError: true,
          );
        }
      },
    );
  }

  void onKYCAction({String? btnText}) {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "title": btnText,
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeVerifyCustomersDetailsScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: dashboardBloc.internetAlert,
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const HomeTabShimmer();
        } else if (state is DashboardLoaded) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.sp,
                ),

                /* Banner */
                (dashboardBloc.userData?.bannerDetails != null &&
                        dashboardBloc.userData!.bannerDetails!.isNotEmpty)
                    ? BannerCarousel(
                        internetAlert: dashboardBloc.internetAlert,
                        bannerList: dashboardBloc.userData?.bannerDetails ?? [],
                      )
                    : const SizedBox.shrink(),
                /* Banner */

                /* KYC Status Widget */
                (dashboardBloc.userData?.showKycDet != null &&
                        dashboardBloc.userData!.showKycDet == true)
                    ? KYCStatusWidget(
                        titleText: dashboardBloc.userData?.kycDet?.title ?? "",
                        subTitleText:
                            dashboardBloc.userData?.kycDet?.subtitle ?? "",
                        btnText: dashboardBloc.userData?.kycDet?.btnText ?? "",
                        internetAlert: dashboardBloc.internetAlert,
                        onContactAction: () =>
                            (dashboardBloc.userData?.kycDet?.type == "2")
                                ? onContactAction(
                                    btnText: dashboardBloc
                                            .userData?.kycDet?.btnText ??
                                        "",
                                  )
                                : onKYCAction(
                                    btnText: dashboardBloc
                                            .userData?.kycDet?.btnText ??
                                        "",
                                  ),
                      )
                    : const SizedBox.shrink(),
                /* KYC Status Widget */

                /* Services */
                (dashboardBloc.userData?.servicesList != null &&
                        dashboardBloc.userData!.servicesList!.isNotEmpty)
                    ? ServicesSection(
                        dataList: dashboardBloc.userData?.servicesList ?? [],
                        titleText: dashboardBloc.userData?.servicesText ?? "",
                        internetAlert: dashboardBloc.internetAlert,
                      )
                    : const SizedBox.shrink(),
                /* Services */

                /* Dues Section */
                (dashboardBloc.userData?.duesSecList != null &&
                        dashboardBloc.userData!.duesSecList!.isNotEmpty)
                    ? DuesSection(
                        titleText: dashboardBloc.userData?.duesText ?? "",
                        dataList: dashboardBloc.userData?.duesSecList ?? [],
                      )
                    : const SizedBox.shrink(),
                /* Dues Section */
              ],
            ),
          );
        } else if (state is DashboardNoInternet) {
          return noInternetWidget(
            context: context,
            retryAction: () => dashboardBloc.add(GetUserDetails()),
            state: 1,
          );
        } else {
          return noInternetWidget(
            context: context,
            retryAction: () => dashboardBloc.add(GetUserDetails()),
            state: 2,
          );
        }
      },
    );
  }
}
