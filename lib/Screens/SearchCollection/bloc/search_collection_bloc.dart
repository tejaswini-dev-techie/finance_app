import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/report_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'search_collection_event.dart';
part 'search_collection_state.dart';

class SearchCollectionBloc
    extends Bloc<SearchCollectionEvent, SearchCollectionState> {
  SearchCollectionBloc() : super(SearchCollectionLoading()) {
    on<GetSearchDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "";
  String? noDataFoundText = "";

  Data? searchData;

  List<ReportList>? searchCusDataList = [];
  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Future<void> _mapGetDetailsEventToState(
      GetSearchDetails event, Emitter<SearchCollectionState> emit) async {
    page = event.page ?? 1;
    if (event.page == 1) {
      searchCusDataList?.clear();
      saving = false;
      endPage = false;
      emit(SearchCollectionLoading());
    }
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .searchCollectionDetailsService(
          page: event.page,
          searchKey: event.searchKey,
          type: event.type,
        )
            .then((ReportDetailsDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              searchData = responseObj.data;
              if (responseObj.data?.reportList != null &&
                  responseObj.data!.reportList!.isNotEmpty) {
                searchCusDataList = responseObj.data?.reportList ?? [];
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
            ? emit(SearchCollectionLoaded())
            : emit(SearchCollectionError());
      } else {
        //Internet state
        emit(SearchCollectionNoInternet());
      }
    } catch (e) {
      emit(SearchCollectionError());
    }
  }
}
