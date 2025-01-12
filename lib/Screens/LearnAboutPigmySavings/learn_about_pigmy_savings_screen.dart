import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/DataModel/LearnAboutPigmySavings/learn_about_pigmy_savings_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class LearnAboutPigmySavingsScreen extends StatefulWidget {
  final String?
      type; // 1 - Learn About PIGMY SAVINGS | 2 - Learn About GROUP PIGMY SAVINGS
  final String?
      pageType; /* pageType: 1 - Individual PIGMY | 2 - Individual GPIGMY*/
  const LearnAboutPigmySavingsScreen({
    super.key,
    this.type,
    this.pageType = "1",
  });

  @override
  State<LearnAboutPigmySavingsScreen> createState() =>
      _LearnAboutPigmySavingsScreenState();
}

class _LearnAboutPigmySavingsScreenState
    extends State<LearnAboutPigmySavingsScreen> {
  String? internetAlert = "";
  String? learnPigmySavingsText = "";

  String? startNowText = "";
  String? footerText = "";

  Data? pigmyData;

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
    learnPigmySavingsText =
        appContent['learn_pigmy_savings']['learn_pigmy_savings_text'] ?? "";
    startNowText = appContent['learn_pigmy_savings']['start_now_text'] ?? "";
    footerText = appContent['learn_pigmy_savings']['footer_text'] ?? "";
    // await getPigmyDetails();
    setState(() {});
  }

  Future<Data?> getPigmyDetails() async {
    await NetworkService()
        .learnAboutPigmySavingsService(
      type: widget.type,
    )
        .then((LearnAboutPigmySavings? respObj) {
      if (respObj != null && respObj.data != null) {
        pigmyData = respObj.data;
      }
    });
    return pigmyData;
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
                  Expanded(
                    child: Text(
                      learnPigmySavingsText ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ColorConstants.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.sp,
                  ),
                ],
              ),
            ),
          ),
          body: FutureBuilder<Data?>(
            future: getPigmyDetails(), // the API call function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while the data is loading
                return const CircularProgressIndicator(
                  color: ColorConstants.darkBlueColor,
                );
              } else if (snapshot.hasError) {
                // Show an error message if the request failed
                return noInternetWidget(
                  context: context,
                  retryAction: () => getPigmyDetails(),
                  state: 2,
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data != null) {
                  pigmyData = snapshot.data;
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 12.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pigmyData?.title ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConstants.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Text(
                          pigmyData?.subtitle ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorConstants.lightBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        (pigmyData?.howItWorksList != null &&
                                pigmyData!.howItWorksList!.isNotEmpty)
                            ? Text(
                                pigmyData?.howItWorksText ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (pigmyData?.howItWorksList != null &&
                                pigmyData!.howItWorksList!.isNotEmpty)
                            ? SizedBox(
                                height: 5.sp,
                              )
                            : const SizedBox.shrink(),
                        (pigmyData?.howItWorksList != null &&
                                pigmyData!.howItWorksList!.isNotEmpty)
                            ? ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${index + 1}. ${pigmyData!.howItWorksList![index].title}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: ColorConstants.blackColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.sp),
                                        child: Text(
                                          pigmyData!.howItWorksList![index]
                                                  .subtitle ??
                                              "",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 2.sp,
                                  );
                                },
                                itemCount: pigmyData!.howItWorksList!.length)
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          pigmyData?.depositSchemesText ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConstants.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${pigmyData!.schemesList![index].title}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: pigmyData!
                                      .schemesList![index].schemesDet!.length,
                                  itemBuilder: (context, innerIndex) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 12.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.sp, right: 3.sp),
                                            child: CircleAvatar(
                                              radius: 2.sp,
                                              backgroundColor:
                                                  ColorConstants.blackColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              pigmyData!.schemesList![index]
                                                  .schemesDet![innerIndex],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorConstants
                                                    .lightBlackColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2.sp,
                            );
                          },
                          itemCount: pigmyData!.schemesList!.length,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          pigmyData?.termsCondnText ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConstants.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${pigmyData!.termsList![index].title}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: pigmyData!
                                      .termsList![index].schemesDet!.length,
                                  itemBuilder: (context, innerIndex) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 12.sp),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.sp, right: 3.sp),
                                            child: CircleAvatar(
                                              radius: 2.sp,
                                              backgroundColor:
                                                  ColorConstants.blackColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              pigmyData!.termsList![index]
                                                  .schemesDet![innerIndex],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorConstants
                                                    .lightBlackColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2.sp,
                            );
                          },
                          itemCount: pigmyData!.termsList!.length,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        buttonWidgetHelperUtil(
                          isDisabled: false,
                          buttonText: pigmyData?.btnText ?? "",
                          onButtonTap: () => onStartNowAction(),
                          context: context,
                          internetAlert: internetAlert,
                          borderradius: 8.sp,
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Center(
                          child: Text(
                            pigmyData?.footerText ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: ColorConstants.lightBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.sp,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => getPigmyDetails(),
                  state: 1,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void onStartNowAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "1",
            "pageType": widget.pageType,
          };

          Navigator.pushNamed(
            context,
            RoutingConstants.routeCreatePigmySavingsAccountScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: internetAlert ?? "",
            isError: true,
          );
        }
      },
    );
  }
}
