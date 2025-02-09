import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_intermittent_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/widgets/image_data.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/widgets/sec_list.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchIntermitentScreen extends StatefulWidget {
  final String? customerID;
  final String? type;
  const SearchIntermitentScreen({super.key, this.customerID, this.type = "1"});

  @override
  State<SearchIntermitentScreen> createState() =>
      _SearchIntermitentScreenState();
}

class _SearchIntermitentScreenState extends State<SearchIntermitentScreen> {
  String? internetAlert = "";

  String? infoText = "Info";

  Data? searchDet;

  final TextEditingController _altPhNumController = TextEditingController();
  final FocusNode _altPhNumFocusNode = FocusNode();

  final TextEditingController _streetAddressController =
      TextEditingController();
  final FocusNode _streetAddressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  @override
  void dispose() {
    _altPhNumController.dispose();
    _altPhNumFocusNode.dispose();
    _streetAddressController.dispose();
    _streetAddressFocusNode.dispose();
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
        .searchIntermittentService(cusID: cusID, type: widget.type)
        .then((SearchIntermittentDetailsDataModel? respObj) {
      if (respObj != null && respObj.data != null) {
        searchDet = respObj.data;
      }
    });
    return searchDet;
  }

  Future<void> _launchUrl(String url) async {
    InternetUtil().checkInternetConnection().then((internet) async {
      if (internet) {
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
      } else {
        ToastUtil().showSnackBar(
          context: context,
          message: internetAlert,
          isError: true,
        );
      }
    });
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

  void onWithdrawPigmyAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Map<String, dynamic> data = {};
          data = {
            "type": "2",
            "customerID": widget.customerID,
          };

          Navigator.pushNamed(
            context,
            RoutingConstants.routeWithdrawPigmySavingsScreen,
            arguments: {"data": data},
          );
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: "Please check your internet connection",
            isError: true,
          );
        }
      },
    );
  }

  void _showCloseLoanConfirmationDialog(BuildContext context, String? loanID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: Text("Are you sure you want to close the loan?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _handleLoanClosure(
                  context,
                  loanID,
                );
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLoanClosure(BuildContext context, String? loanID) async {
    var result = await NetworkService().closeLoanUpdate(
      id: widget.customerID,
      loanID: loanID,
    );
    if (result != null && result['status'] == true) {
      if (!mounted) return;
      if (result['message'] != null && result['message'].isNotEmpty) {
        ToastUtil().showSnackBar(
          context: context,
          message: result['message'],
          isError: false,
        );
      }
      // All validations passed, navigate to the next screen
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Map<String, dynamic> data = {};
        data = {
          "tab_index": 0,
        };
        if (!mounted) return;
        Navigator.pushReplacementNamed(
          context,
          RoutingConstants.routeDashboardScreen,
          arguments: {"data": data},
        );
      });
    } else {
      if (!mounted) return;
      ToastUtil().showSnackBar(
        context: context,
        message: result['message'] ?? "Something went wrong",
        isError: true,
      );
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
                  IconButton.filled(
                    onPressed: () {
                      showEditSheet(cusID: widget.customerID);
                    },
                    icon: const Icon(
                      Icons.add_card_rounded,
                      color: ColorConstants.darkBlueColor,
                    ),
                    iconSize: 20.sp,
                    color: ColorConstants.darkBlueColor,
                  )
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
                        (searchDet?.emailId != null &&
                                searchDet!.emailId!.isNotEmpty)
                            ? Text(
                                searchDet?.emailId ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.emailId != null &&
                                searchDet!.emailId!.isNotEmpty)
                            ? SizedBox(
                                height: 3.sp,
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.address != null &&
                                searchDet!.address!.isNotEmpty)
                            ? Text(
                                searchDet?.address ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.address != null &&
                                searchDet!.address!.isNotEmpty)
                            ? SizedBox(
                                height: 10.sp,
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.locLink != null &&
                                searchDet!.locLink!.isNotEmpty)
                            ? Text(
                                searchDet?.locLinkText ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.darkBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.locLink != null &&
                                searchDet!.locLink!.isNotEmpty)
                            ? InkWell(
                                onTap: () =>
                                    _launchUrl(searchDet?.locLink ?? ""),
                                child: Text(
                                  searchDet?.locLink ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorConstants.lightBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.locLink != null &&
                                searchDet!.locLink!.isNotEmpty)
                            ? SizedBox(
                                height: 10.sp,
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.workLocationLink != null &&
                                searchDet!.workLocationLink!.isNotEmpty)
                            ? Text(
                                searchDet?.workLocationLinkText ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.darkBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : const SizedBox.shrink(),
                        (searchDet?.workLocationLink != null &&
                                searchDet!.workLocationLink!.isNotEmpty)
                            ? InkWell(
                                onTap: () => _launchUrl(
                                    searchDet?.workLocationLink ?? ""),
                                child: Text(
                                  searchDet?.workLocationLink ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorConstants.lightBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),

                        /* Withdraw Pigmy Savings */
                        (searchDet?.withdrawPigmyText != null &&
                                searchDet!.withdrawPigmyText!.isNotEmpty)
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                                  child: InkWell(
                                    onTap: () => onWithdrawPigmyAction(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            searchDet?.withdrawPigmyText ?? "",
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
                                ),
                              )
                            : const SizedBox.shrink(),
                        /* Withdraw Pigmy Savings */

                        /* Withdraw Pigmy Savings */
                        (searchDet?.closeLoanText != null &&
                                searchDet!.closeLoanText!.isNotEmpty)
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                                  child: InkWell(
                                    onTap: () =>
                                        _showCloseLoanConfirmationDialog(
                                      context,
                                      searchDet?.loanID,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            searchDet?.closeLoanText ?? "",
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
                                ),
                              )
                            : const SizedBox.shrink(),
                        /* Withdraw Pigmy Savings */

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
                                      Text(
                                        searchDet!.docsList![index].subTitle ??
                                            "",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      (searchDet!.docsList![index].imagePath !=
                                                  null &&
                                              searchDet!.docsList![index]
                                                  .imagePath!.isNotEmpty)
                                          ? SizedBox(
                                              height: 3.sp,
                                            )
                                          : const SizedBox.shrink(),
                                      (searchDet!.docsList![index].imagePath !=
                                                  null &&
                                              searchDet!.docsList![index]
                                                  .imagePath!.isNotEmpty)
                                          ? ImageData(
                                              imagePath: searchDet!
                                                      .docsList![index]
                                                      .imagePath ??
                                                  "",
                                            )
                                          : const SizedBox.shrink(),
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
                        ListView.separated(
                          padding: EdgeInsets.symmetric(vertical: 12.sp),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SectionList(
                              listMenuDetails:
                                  searchDet!.listDetails![index].listDetMenu ??
                                      [],
                              onPayAction: onPayAction,
                              title:
                                  searchDet!.listDetails![index].listDetTitle ??
                                      "",
                              listDetails:
                                  searchDet!.listDetails![index].listDet ?? [],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.sp,
                            );
                          },
                          itemCount: searchDet!.listDetails!.length,
                        ),
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
                  state: 2,
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
          if (widget.type == "1") {
            Navigator.pushNamed(
              context,
              RoutingConstants.routeAgentUpdatePaymentDetailsScreen,
              arguments: {"data": data},
            );
          } else {
            Navigator.pushNamed(
              context,
              RoutingConstants.routeUpdateGroupPaymentDetailsScreen,
              arguments: {"data": data},
            );
          }
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

  void showEditSheet({
    required String? cusID,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      clipBehavior: Clip.none,
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(4.sp),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjusts padding for the keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16.sp,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /* Alternate Mobile Number Input Field */
                Text(
                  "Mobile Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: ColorConstants.lightBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextInputField(
                  focusnodes: _altPhNumFocusNode,
                  suffixWidget: const Icon(
                    Icons.phone_locked,
                    color: ColorConstants.darkBlueColor,
                  ),
                  placeholderText: "Enter Mobile Number",
                  textEditingController: _altPhNumController,
                  inputFormattersList: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^[6-9][0-9]*$'),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(r"\s\s"),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(
                          r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                    ),
                  ],
                  keyboardtype: TextInputType.number,
                  validationFunc: (value) {
                    return ValidationUtil.validateMobileNumber(
                      value,
                    );
                  },
                ),
                /* Alternate Mobile Number Input Field */

                /* Street Address Input Field*/
                Text(
                  "Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: ColorConstants.lightBlackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextInputField(
                  focusnodes: _streetAddressFocusNode,
                  suffixWidget: const Icon(
                    Icons.location_on,
                    color: ColorConstants.darkBlueColor,
                  ),
                  placeholderText: "Address",
                  textEditingController: _streetAddressController,
                  inputFormattersList: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(
                      RegExp(r"\s\s"),
                    ),
                    FilteringTextInputFormatter.deny(
                      RegExp(
                          r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                    ),
                  ],
                  validationFunc: (value) {
                    return ValidationUtil.validateLocation(value, 1);
                  },
                ),
                /* Street Address Input Field */

                buttonWidgetHelperUtil(
                  isDisabled: false,
                  buttonText: "Update",
                  onButtonTap: () => onUpdateAction(cusID: cusID),
                  context: context,
                  internetAlert: internetAlert,
                  borderradius: 8.sp,
                  toastError: () => onUpdateAction(cusID: cusID),
                ),
                SizedBox(
                  height: 32.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onUpdateAction({
    required String? cusID,
  }) {
    InternetUtil().checkInternetConnection().then((internet) async {
      if (internet) {
        if (_altPhNumController.text.isNotEmpty ||
            _streetAddressController.text.isNotEmpty) {
// API CAll
          Navigator.pop(context);
          var result = await NetworkService().updateAddressPhNumDetails(
            customerID: widget.customerID,
            mobNum: _altPhNumController.text,
            streetAddress: _streetAddressController.text,
          );

          if (result != null && result['status'] == true) {
            if (!mounted) return;
            if (result['message'] != null && result['message'].isNotEmpty) {
              ToastUtil().showSnackBar(
                context: context,
                message: result['message'],
                isError: false,
              );
            }

            Future.delayed(const Duration(seconds: 1)).then((value) {
              // All validations passed, navigate to the next screen
              Map<String, dynamic> data = {};
              data = {
                "tab_index": 1,
              };
              Navigator.pushReplacementNamed(
                context,
                RoutingConstants.routeDashboardScreen,
                arguments: {"data": data},
              );
            });
          } else {
            if (!mounted) return;
            ToastUtil().showSnackBar(
              context: context,
              message: result['message'] ?? "Something went wrong",
              isError: true,
            );
          }
        }
      } else {
        ToastUtil().showSnackBar(
          context: context,
          message: internetAlert,
          isError: true,
        );
      }
    });
  }
}
