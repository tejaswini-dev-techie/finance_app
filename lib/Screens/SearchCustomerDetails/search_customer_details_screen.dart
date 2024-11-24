import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/SearchCustomerDetails/bloc/search_customer_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class SearchCustomerDetails extends StatefulWidget {
  const SearchCustomerDetails({super.key});

  @override
  State<SearchCustomerDetails> createState() => _SearchCustomerDetailsState();
}

class _SearchCustomerDetailsState extends State<SearchCustomerDetails> {
  final SearchCustomerBloc searchCustomerBloc = SearchCustomerBloc();

  String searchText = "Search Name, Phone Number, Loan Code";

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  /* Controllers */
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Timer? searchOnStoppedTyping;

  @override
  void initState() {
    super.initState();
    searchCustomerBloc.add(GetSearchDetails(
      page: 1,
      showLoading: true,
      searchKey: _searchController.text,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    searchOnStoppedTyping?.cancel();
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
    }
    _searchController.dispose();
    _searchFocusNode.dispose();
    _refreshController.dispose();
    searchCustomerBloc.close();
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
                        onChangeFunc: (val) {
                          const duration = Duration(milliseconds: 500);
                          searchOnStoppedTyping?.cancel();
                          searchOnStoppedTyping = Timer(
                            duration,
                            () {
                              searchCustomerBloc.add(
                                GetSearchDetails(
                                  page: 1,
                                  showLoading: true,
                                  searchKey: _searchController.text.trim(),
                                ),
                              );
                            },
                          );
                        },
                        validationFunc: (value) {
                          return null;
                        },
                        prefixWidget: const Icon(
                          Icons.search_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        suffixWidget: InkWell(
                          onTap: () {
                            _searchController.clear();
                            searchCustomerBloc.add(
                              GetSearchDetails(
                                page: 1,
                                showLoading: true,
                                searchKey: _searchController.text,
                              ),
                            );
                          },
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
          body: BlocBuilder<SearchCustomerBloc, SearchCustomerState>(
            bloc: searchCustomerBloc,
            builder: (context, state) {
              if (state is SearchCustomerLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is SearchCustomerLoaded) {
                return (searchCustomerBloc.searchCusDataList != null &&
                        searchCustomerBloc.searchCusDataList!.isNotEmpty)
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!searchCustomerBloc.saving) {
                            if (!searchCustomerBloc.endPage) {
                              searchCustomerBloc.saving = true;
                              searchCustomerBloc.add(
                                GetSearchDetails(
                                  showLoading: false,
                                  page: searchCustomerBloc.page,
                                  oldSearchCusDataList:
                                      searchCustomerBloc.searchCusDataList ??
                                          [],
                                  searchKey: _searchController.text,
                                ),
                              );
                            }
                          }
                          return true;
                        },
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          header: const MaterialClassicHeader(
                            distance: 40,
                            color: ColorConstants.whiteColor,
                            backgroundColor: ColorConstants.greenColor,
                          ),
                          enablePullUp: searchCustomerBloc.endPage
                              ? false
                              : (searchCustomerBloc.isNetworkConnected == false)
                                  ? false
                                  : true,
                          onRefresh: () {
                            InternetUtil().checkInternetConnection().then(
                              (internet) {
                                if (internet) {
                                  searchCustomerBloc.add(
                                    GetSearchDetails(
                                      page: 1,
                                      showLoading: true,
                                      searchKey: _searchController.text,
                                    ),
                                  );
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();

                                  ToastUtil().showSnackBar(
                                    context: context,
                                    message: searchCustomerBloc.internetAlert,
                                    isError: true,
                                  );
                                }
                              },
                            );
                          },
                          child: ListView.separated(
                            itemCount:
                                searchCustomerBloc.searchCusDataList!.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 24.sp,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  InternetUtil()
                                      .checkInternetConnection()
                                      .then((internet) {
                                    if (internet) {
                                      if (!mounted) return;
                                      Map<String, dynamic> data = {};
                                      data = {
                                        "customerID": searchCustomerBloc
                                            .searchCusDataList![index].memberId,
                                      };

                                      Navigator.pushNamed(
                                        context,
                                        RoutingConstants
                                            .routeSearchIntermittentScreen,
                                        arguments: {"data": data},
                                      );
                                    } else {
                                      if (!mounted) return;
                                      ToastUtil().showSnackBar(
                                        context: context,
                                        message:
                                            searchCustomerBloc.internetAlert,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            tileCards(
                                              type: 1,
                                              iconWidget: Icon(
                                                Icons.person,
                                                size: 13.sp,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              title: searchCustomerBloc
                                                  .searchCusDataList![index]
                                                  .memName,
                                            ),
                                            tileCards(
                                              iconWidget: Icon(
                                                Icons.phone,
                                                size: 13.sp,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              title: searchCustomerBloc
                                                  .searchCusDataList![index]
                                                  .phNum,
                                            ),
                                            tileCards(
                                              iconWidget: Icon(
                                                Icons.contacts_rounded,
                                                size: 13.sp,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              title: searchCustomerBloc
                                                  .searchCusDataList![index]
                                                  .loanCode,
                                            ),
                                            tileCards(
                                              iconWidget: Icon(
                                                Icons.location_on_rounded,
                                                size: 13.sp,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              title: searchCustomerBloc
                                                  .searchCusDataList![index]
                                                  .location,
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
                                              searchCustomerBloc
                                                      .searchCusDataList![index]
                                                      .accStatus ??
                                                  "",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700,
                                                color: (searchCustomerBloc
                                                            .searchCusDataList![
                                                                index]
                                                            .accStatusType ==
                                                        "2")
                                                    ? ColorConstants
                                                        .mintRedColor
                                                    : ColorConstants
                                                        .mintGreenColor,
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
                      )
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 84.sp,
                            ),
                            Container(
                              width: SizerUtil.width,
                              height: 250.sp,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageConstants.noDataFoundImage,
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              child: Text(
                                searchCustomerBloc.noDataFoundText ??
                                    "No Data found!!!",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              } else if (state is SearchCustomerNoInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => searchCustomerBloc.add(GetSearchDetails(
                    page: 1,
                    showLoading: true,
                    searchKey: _searchController.text,
                  )),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => searchCustomerBloc.add(GetSearchDetails(
                    page: 1,
                    showLoading: true,
                    searchKey: _searchController.text,
                  )),
                  state: 2,
                );
              }
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
