import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/info_cards.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:sizer/sizer.dart';

class AgentsTab extends StatefulWidget {
  const AgentsTab({super.key});

  @override
  State<AgentsTab> createState() => _AgentsTabState();
}

class _AgentsTabState extends State<AgentsTab> {
  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  String? findCustomerDetailsText = "Find Customer Details";
  String? verifyCustomerDetailsText = "Verify Customer Details";
  String? updatePaymentDetailsText = "Update Payment Details";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onFindCustomerDetailsAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
            context,
            RoutingConstants.routeSearchCustomerDetails,
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: internetAlert ?? "Please check your internet connection",
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
            message: internetAlert ?? "Please check your internet connection",
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
            message: internetAlert ?? "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 10.sp,
        ),
        child: Column(
          children: [
            /* Info Cards */
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 18,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.sp,
                mainAxisSpacing: 16.sp,
              ),
              itemBuilder: (BuildContext context, int index) {
                return const InfoCards();
              },
            ),
            /* Info Cards */

            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: InkWell(
                onTap: () => onFindCustomerDetailsAction(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        findCustomerDetailsText ?? "",
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: InkWell(
                onTap: () => onVerifyCustomerDetailsAction(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        verifyCustomerDetailsText ?? "",
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
              child: InkWell(
                onTap: () => onUpdatePaymentDetailsAction(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        updatePaymentDetailsText ?? "",
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
            ),
          ],
        ),
      ),
    );
  }
}
