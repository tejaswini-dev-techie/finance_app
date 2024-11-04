import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/widgets_util/pop_up_alert.dart';
import 'package:sizer/sizer.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  String internetAlert = "";
  String transactionHistoryText = "";
  String transactiondetailsText = "";

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    transactionHistoryText =
        appContent['transaction_history']['transaction_history_text'] ?? "";
    transactiondetailsText =
        appContent['transaction_history']['transaction_details_text'] ?? "";

    setState(() {});
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
                      transactionHistoryText,
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
          body: ListView.separated(
            itemCount: 10,
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
                    internetAlert: internetAlert,
                    context: context,
                    titleText: transactiondetailsText,
                    secondaryButtonText: "",
                    primaryButtonText: "",
                    subWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: ColorConstants.lighterBlueColor,
                          thickness: 1.2.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 6.sp,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
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
                                          "PAID TO",
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                ColorConstants.lightBlackColor,
                                          ),
                                        ),
                                        Text(
                                          "HP FINANCE",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.blackColor,
                                          ),
                                        ),
                                        Text(
                                          "16th August 2024 6:45 PM",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                ColorConstants.lightBlackColor,
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
                                          (index == 1)
                                              ? '\u002D \u20B91500'
                                              : '\u002B \u20B94200',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                        ),
                                        Text(
                                          (index == 1) ? "FAILED" : "PAID",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                            color: (index == 1)
                                                ? ColorConstants.mintRedColor
                                                : ColorConstants.mintGreenColor,
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
                                color: ColorConstants.lighterBlueColor,
                                thickness: 1.2.sp,
                              ),
                              SizedBox(
                                height: 3.sp,
                              ),

                              /* Transaction ID */
                              Text(
                                "Transaction ID",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                "XXXXXXXXXXXX123456",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.darkBlueColor,
                                ),
                              ),
                              /* Transaction ID */
                              SizedBox(
                                height: 6.sp,
                              ),

                              /* Bank Name */
                              Text(
                                "Bank Name",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                "SBI",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.darkBlueColor,
                                ),
                              ),
                              /* Bank Name */

                              SizedBox(
                                height: 6.sp,
                              ),

                              /* UTR Number */
                              Text(
                                "UTR Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                'XXXXXXXXXXXXX',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.darkBlueColor,
                                ),
                              ),
                              /* UTR Number */

                              SizedBox(
                                height: 6.sp,
                              ),

                              /* A/C Number */
                              Text(
                                "A/C Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                'XXXXXXXXXXXXX',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.darkBlueColor,
                                ),
                              ),
                              /* A/C Number */

                              SizedBox(
                                height: 6.sp,
                              ),

                              /* A/C Status */
                              Text(
                                "A/C Status",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.lightBlackColor,
                                ),
                              ),
                              Text(
                                'ACTIVE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.mintGreenColor,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.sp),
                            child: Image.asset(
                              ImageConstants.transactionImage,
                              width: 24.sp,
                              height: 24.sp,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "PAID TO",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.lightBlackColor,
                                  ),
                                ),
                                Text(
                                  "HP FINANCE",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstants.blackColor,
                                  ),
                                ),
                                Text(
                                  "16th August 2024 6:45 PM",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.lightBlackColor,
                                  ),
                                ),
                                Text(
                                  "PIGMYCODE1234",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.lightBlackColor,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (index == 1)
                                ? '\u002D \u20B91500'
                                : '\u002B \u20B94200',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.darkBlueColor,
                            ),
                          ),
                          Text(
                            (index == 1) ? "FAILED" : "PAID",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: (index == 1)
                                  ? ColorConstants.mintRedColor
                                  : ColorConstants.mintGreenColor,
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
      ),
    );
  }
}
