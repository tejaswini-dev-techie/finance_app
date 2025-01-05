import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/SearchCollection/bloc/search_collection_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:sizer/sizer.dart';

class SearchCollectionDetails extends StatefulWidget {
  final String? type; // type: 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans

  const SearchCollectionDetails({
    super.key,
    this.type = "1", // type: 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
  });

  @override
  State<SearchCollectionDetails> createState() =>
      _SearchCollectionDetailsState();
}

class _SearchCollectionDetailsState extends State<SearchCollectionDetails> {
  final SearchCollectionBloc searchCollectionBloc = SearchCollectionBloc();

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
    searchCollectionBloc.add(GetSearchDetails(
      page: 1,
      showLoading: true,
      searchKey: _searchController.text,
      type: widget.type,
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
    searchCollectionBloc.close();
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": int.parse(widget.type ?? "0"),
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
                              searchCollectionBloc.add(
                                GetSearchDetails(
                                  page: 1,
                                  showLoading: true,
                                  searchKey: _searchController.text.trim(),
                                  type: widget.type,
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
                            searchCollectionBloc.add(
                              GetSearchDetails(
                                page: 1,
                                showLoading: true,
                                searchKey: _searchController.text,
                                type: widget.type,
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
          body: BlocBuilder<SearchCollectionBloc, SearchCollectionState>(
            bloc: searchCollectionBloc,
            builder: (context, state) {
              if (state is SearchCollectionLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                );
              } else if (state is SearchCollectionLoaded) {
                return (searchCollectionBloc.searchCusDataList != null &&
                        searchCollectionBloc.searchCusDataList!.isNotEmpty)
                    ? NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!searchCollectionBloc.saving) {
                            if (!searchCollectionBloc.endPage) {
                              searchCollectionBloc.saving = true;
                              searchCollectionBloc.add(
                                GetSearchDetails(
                                  showLoading: false,
                                  page: searchCollectionBloc.page,
                                  oldSearchCusDataList:
                                      searchCollectionBloc.searchCusDataList ??
                                          [],
                                  searchKey: _searchController.text,
                                  type: widget.type,
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
                          enablePullUp: searchCollectionBloc.endPage
                              ? false
                              : (searchCollectionBloc.isNetworkConnected ==
                                      false)
                                  ? false
                                  : true,
                          onRefresh: () {
                            InternetUtil().checkInternetConnection().then(
                              (internet) {
                                if (internet) {
                                  searchCollectionBloc.add(
                                    GetSearchDetails(
                                      page: 1,
                                      showLoading: true,
                                      searchKey: _searchController.text,
                                      type: widget.type,
                                    ),
                                  );
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();

                                  ToastUtil().showSnackBar(
                                    context: context,
                                    message: searchCollectionBloc.internetAlert,
                                    isError: true,
                                  );
                                }
                              },
                            );
                          },
                          child: ListView.separated(
                            itemCount:
                                searchCollectionBloc.searchCusDataList!.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                              vertical: 24.sp,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      InternetUtil()
                                          .checkInternetConnection()
                                          .then(
                                        (internet) async {
                                          if (internet) {
                                            Map<String, dynamic> data = {};
                                            data = {
                                              "customerID": searchCollectionBloc
                                                      .searchCusDataList![index]
                                                      .id ??
                                                  "",
                                              "type": searchCollectionBloc
                                                      .searchCusDataList![index]
                                                      .type ??
                                                  "",
                                            };

                                            Navigator.pushNamed(
                                              context,
                                              RoutingConstants
                                                  .routeAgentUpdatePaymentDetailsScreen,
                                              arguments: {"data": data},
                                            );
                                          } else {
                                            ToastUtil().showSnackBar(
                                              context: context,
                                              message: searchCollectionBloc
                                                      .internetAlert ??
                                                  "Please check your internet connection",
                                              isError: true,
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 4.sp),
                                                child: Image.asset(
                                                  ImageConstants.profileImage,
                                                  width: 24.sp,
                                                  height: 24.sp,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    if (searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .headerText !=
                                                            null &&
                                                        searchCollectionBloc
                                                            .searchCusDataList![
                                                                index]
                                                            .headerText!
                                                            .isNotEmpty)
                                                      Text(
                                                        searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .headerText ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorConstants
                                                              .lightBlackColor,
                                                        ),
                                                      ),
                                                    Text(
                                                      searchCollectionBloc
                                                              .searchCusDataList![
                                                                  index]
                                                              .memName ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorConstants
                                                            .blackColor,
                                                      ),
                                                    ),
                                                    if (searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .phNum !=
                                                            null &&
                                                        searchCollectionBloc
                                                            .searchCusDataList![
                                                                index]
                                                            .phNum!
                                                            .isNotEmpty)
                                                      Text(
                                                        searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .phNum ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorConstants
                                                              .lightBlackColor,
                                                        ),
                                                      ),
                                                    if (searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .paymentDate !=
                                                            null &&
                                                        searchCollectionBloc
                                                            .searchCusDataList![
                                                                index]
                                                            .paymentDate!
                                                            .isNotEmpty)
                                                      Text(
                                                        searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .paymentDate ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorConstants
                                                              .lightBlackColor,
                                                        ),
                                                      ),
                                                    if (searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .footerText !=
                                                            null &&
                                                        searchCollectionBloc
                                                            .searchCusDataList![
                                                                index]
                                                            .footerText!
                                                            .isNotEmpty)
                                                      Text(
                                                        searchCollectionBloc
                                                                .searchCusDataList![
                                                                    index]
                                                                .footerText ??
                                                            "",
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorConstants
                                                              .lightBlackColor,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchCollectionBloc
                                                        .searchCusDataList![
                                                            index]
                                                        .amtText ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                              ),
                                              Text(
                                                searchCollectionBloc
                                                        .searchCusDataList![
                                                            index]
                                                        .payStatus ??
                                                    "",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: (searchCollectionBloc
                                                              .searchCusDataList![
                                                                  index]
                                                              .payStatusType !=
                                                          "1") // 1-PAID | 2-DUE | 3-WITHDRAW | 4-FAILED | 5-OVERDUE
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
                                ],
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
                                searchCollectionBloc.noDataFoundText ??
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
              } else if (state is SearchCollectionNoInternet) {
                return noInternetWidget(
                  context: context,
                  retryAction: () => searchCollectionBloc.add(GetSearchDetails(
                    page: 1,
                    showLoading: true,
                    searchKey: _searchController.text,
                    type: widget.type,
                  )),
                  state: 1,
                );
              } else {
                return noInternetWidget(
                  context: context,
                  retryAction: () => searchCollectionBloc.add(GetSearchDetails(
                    page: 1,
                    showLoading: true,
                    searchKey: _searchController.text,
                    type: widget.type,
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
