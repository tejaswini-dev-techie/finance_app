import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_customer_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'search_customer_event.dart';
part 'search_customer_state.dart';

class SearchCustomerBloc
    extends Bloc<SearchCustomerEvent, SearchCustomerState> {
  SearchCustomerBloc() : super(SearchCustomerLoading()) {
    on<GetSearchDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "";
  String? noDataFoundText = "";

  Data? searchData;

  List<SearchMembersList>? searchCusDataList = [];
  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Future<void> _mapGetDetailsEventToState(
      GetSearchDetails event, Emitter<SearchCustomerState> emit) async {
    page = event.page ?? 1;
    if (event.page == 1) {
      searchCusDataList?.clear();
      saving = false;
      endPage = false;
      emit(SearchCustomerLoading());
    }
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .searchCusDetailsService(
          page: event.page,
          searchKey: event.searchKey,
          type: event.type,
        )
            .then((SearchCustomerDetailsDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              searchData = responseObj.data;
              if (responseObj.data?.searchMembersList != null &&
                  responseObj.data!.searchMembersList!.isNotEmpty) {
                searchCusDataList = responseObj.data?.searchMembersList ?? [];
              }

              if (searchCusDataList != null &&
                  searchCusDataList!.isNotEmpty &&
                  event.oldSearchCusDataList != null &&
                  event.oldSearchCusDataList!.isNotEmpty) {
                event.oldSearchCusDataList?.addAll(searchCusDataList ?? []);
                searchCusDataList = event.oldSearchCusDataList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldSearchCusDataList != null &&
                event.oldSearchCusDataList!.isNotEmpty) {
              searchCusDataList = event.oldSearchCusDataList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return searchData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        noDataFoundText = appContent['action_items']['no_data'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        searchData = await getUserDetails();
        (searchData != null)
            ? emit(SearchCustomerLoaded())
            : emit(SearchCustomerError());
      } else {
        //Internet state
        emit(SearchCustomerNoInternet());
      }
    } catch (e) {
      emit(SearchCustomerError());
    }
  }
}
