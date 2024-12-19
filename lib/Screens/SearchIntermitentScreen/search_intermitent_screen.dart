import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_intermittent_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/widgets/image_data.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/widgets/sec_list.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SearchIntermitentScreen extends StatefulWidget {
  final String? customerID;
  const SearchIntermitentScreen({super.key, this.customerID});

  @override
  State<SearchIntermitentScreen> createState() =>
      _SearchIntermitentScreenState();
}

class _SearchIntermitentScreenState extends State<SearchIntermitentScreen> {
  String? internetAlert = "";

  String? infoText = "Info";

  Data? searchDet;

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

    // await getPigmyDetails();
    setState(() {});
  }

  Future getSearchInfoDetails(String cusID) async {
    await NetworkService()
        .searchIntermittentService(cusID: cusID)
        .then((SearchIntermittentDetailsDataModel? respObj) {
      if (respObj != null && respObj.data != null) {
        searchDet = respObj.data;
      }
    });
    return searchDet;
  }

  onCollectNowAction() {
    InternetUtil().checkInternetConnection().then((internet) {
      if (internet) {
        // TODO Navigation
      } else {
        ToastUtil().showSnackBar(
          context: context,
          message: internetAlert ?? "",
          isError: true,
        );
      }
    });
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
                      infoText ?? "",
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
          body: FutureBuilder(
            future: getSearchInfoDetails(
                widget.customerID ?? ""), // the API call function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while the data is loading
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (snapshot.hasError) {
                // Show an error message if the request failed
                return noInternetWidget(
                  context: context,
                  retryAction: () =>
                      getSearchInfoDetails(widget.customerID ?? ""),
                  state: 2,
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data != null) {
                  searchDet = snapshot.data;
                }

                return SingleChildScrollView(
                  child: Container(
                    width: SizerUtil.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 12.sp,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.sp,
                          backgroundColor: ColorConstants.greyShadow,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.sp),
                            child: Image.network(
                              searchDet?.profileImage ?? "",
                              fit: BoxFit.fill,
                              width: 60.sp,
                              height: 60.sp,
                              filterQuality: Platform.isIOS
                                  ? FilterQuality.medium
                                  : FilterQuality.low,
                              loadingBuilder: (BuildContext? context,
                                  Widget? child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child!;
                                }
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  enabled: true,
                                  child: Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  enabled: true,
                                  child: Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Text(
                          searchDet?.name ?? "",
                          textAlign: TextAlign.center,
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
                          searchDet?.phNum ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorConstants.lightBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Text(
                          searchDet?.emailId ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorConstants.lightBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Text(
                          searchDet?.address ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorConstants.lightBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        (searchDet?.docsList != null &&
                                searchDet!.docsList!.isNotEmpty)
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchDet?.documentsText ?? "Documents",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: ColorConstants.blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.docsList != null &&
                                searchDet!.docsList!.isNotEmpty)
                            ? ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 12.sp),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchDet!.docsList![index].title ?? "",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: ColorConstants.blackColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.sp,
                                      ),
                                      ImageData(
                                        imagePath: searchDet!
                                                .docsList![index].imagePath ??
                                            "",
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.sp,
                                  );
                                },
                                itemCount: searchDet!.docsList!.length,
                              )
                            : const SizedBox.shrink(),
                        /* LIST */
                        (searchDet?.listDetails != null &&
                                searchDet!.listDetails!.isNotEmpty)
                            ? ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 12.sp),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SectionList(
                                    listMenuDetails: searchDet!
                                            .listDetails![index].listDetMenu ??
                                        [],
                                    onPayAction: onPayAction,
                                    title: searchDet!
                                            .listDetails![index].listDetTitle ??
                                        "",
                                    listDetails: searchDet!
                                            .listDetails![index].listDet ??
                                        [],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.sp,
                                  );
                                },
                                itemCount: searchDet!.docsList!.length,
                              )
                            : const SizedBox.shrink(),
                        /* LIST */

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
                  retryAction: () =>
                      getSearchInfoDetails(widget.customerID ?? ""),
                  state: 1,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void onPayAction({required String? type, required String? cusID}) {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "customerID": cusID,
            "type": type,
          };
          Navigator.pushNamed(
            context,
            RoutingConstants.routeAgentUpdatePaymentDetailsScreen,
            arguments: {"data": data},
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
}
