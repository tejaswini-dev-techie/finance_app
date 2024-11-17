import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:sizer/sizer.dart';

class SearchCustomerDetails extends StatefulWidget {
  const SearchCustomerDetails({super.key});

  @override
  State<SearchCustomerDetails> createState() => _SearchCustomerDetailsState();
}

class _SearchCustomerDetailsState extends State<SearchCustomerDetails> {
  String internetAlert = "";
  String searchText = "Search Name, Phone Number, Loan Code";

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";

    setState(() {});
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": 0,
    };
    Navigator.pushReplacementNamed(
      context,
      RoutingConstants.routeDashboardScreen,
      arguments: {"data": data},
    );
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.sp),
                      child: TextInputField(
                        textEditingController: _searchController,
                        focusnodes: _searchFocusNode,
                        placeholderText: searchText,
                        obscureTextVal: false,
                        keyboardtype: TextInputType.text,
                        textcapitalization: TextCapitalization.words,
                        validationFunc: (value) {
                          return null;
                        },
                        prefixWidget: const Icon(
                          Icons.search_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        suffixWidget: InkWell(
                          onTap: () => _searchController.clear(),
                          child: const Icon(
                            Icons.close,
                            color: ColorConstants.darkBlueColor,
                          ),
                        ),
                        inputFormattersList: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(
                            RegExp(r"\s\s"),
                          ),
                          FilteringTextInputFormatter.deny(
                            RegExp(
                                r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                          ),
                        ],
                      ),
                    ),
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
                  InternetUtil().checkInternetConnection().then((internet) {
                    if (internet) {
                      Map<String, dynamic> data = {};
                      data = {
                        "customerID": "0",
                      };
                      Navigator.pushNamed(
                        context,
                        RoutingConstants.routeSearchIntermittentScreen,
                        arguments: {"data": data},
                      );
                    } else {
                      ToastUtil().showSnackBar(
                        context: context,
                        message: internetAlert,
                        isError: true,
                      );
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.sp,
                    horizontal: 10.sp,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    color: ColorConstants.whiteColor,
                    border: Border.all(
                      color: ColorConstants.lightGreyColor,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            tileCards(
                              type: 1,
                              iconWidget: Icon(
                                Icons.person,
                                size: 13.sp,
                                color: ColorConstants.darkBlueColor,
                              ),
                              title: "RAM",
                            ),
                            tileCards(
                              iconWidget: Icon(
                                Icons.phone,
                                size: 13.sp,
                                color: ColorConstants.darkBlueColor,
                              ),
                              title: "+91 7285668744",
                            ),
                            tileCards(
                              iconWidget: Icon(
                                Icons.contacts_rounded,
                                size: 13.sp,
                                color: ColorConstants.darkBlueColor,
                              ),
                              title: "LOANCODE1234",
                            ),
                            tileCards(
                              iconWidget: Icon(
                                Icons.location_on_rounded,
                                size: 13.sp,
                                color: ColorConstants.darkBlueColor,
                              ),
                              title:
                                  "Banashankri 2nd Stage, Bangalore, Karnataka",
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
                            // Text(
                            //   (index == 1)
                            //       ? '\u002D \u20B91500'
                            //       : '\u002B \u20B94200',
                            //   style: TextStyle(
                            //     fontSize: 12.sp,
                            //     fontWeight: FontWeight.w700,
                            //     color: ColorConstants.darkBlueColor,
                            //   ),
                            // ),
                            // Text(
                            //   (index == 1) ? "WITHDRAW" : "PAID",
                            //   textAlign: TextAlign.right,
                            //   style: TextStyle(
                            //     fontSize: 10.sp,
                            //     fontWeight: FontWeight.w700,
                            //     color: (index == 1)
                            //         ? ColorConstants.mintRedColor
                            //         : ColorConstants.mintGreenColor,
                            //   ),
                            // ),
                            Text(
                              (index == 1) ? "CLOSED" : "ACTIVE",
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
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.sp,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget tileCards(
      {required String? title, required Icon iconWidget, int? type = 2}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconWidget,
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.sp),
            child: Text(
              title ?? "",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: (type == 1) ? FontWeight.w700 : FontWeight.w500,
                color: (type == 1)
                    ? ColorConstants.blackColor
                    : ColorConstants.lightBlackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
