import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/report_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'group_pigmy_reports_event.dart';
part 'group_pigmy_reports_state.dart';

class GroupPigmyReportsBloc
    extends Bloc<GroupPigmyReportsEvent, GroupPigmyReportsState> {
  GroupPigmyReportsBloc() : super(GroupPigmyReportsLoading()) {
    on<GetGroupPigmyReports>((event, emit) async {
      await _mapGetPigmyReportsDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  String? noDataFoundText = "No Data Found";
  /* JSON Text */

  List<ReportList>? reportsDetList = [];

  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Data? reportData;

  Future<void> _mapGetPigmyReportsDetailsEventToState(
      GetGroupPigmyReports event, Emitter<GroupPigmyReportsState> emit) async {
    try {
      bool isInternetConnected = true;
      page = event.page ?? 1;
      if (event.page == 1) {
        reportsDetList?.clear();
        saving = false;
        endPage = false;
        emit(GroupPigmyReportsLoading());
      }

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .reportHistoryDetailsService(
          page: event.page,
          type: event.type, // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
        )
            .then((ReportDetailsDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              reportData = responseObj.data;
              if (responseObj.data?.reportList != null &&
                  responseObj.data!.reportList!.isNotEmpty) {
                reportsDetList = responseObj.data?.reportList ?? [];
              }

              if (reportsDetList != null &&
                  reportsDetList!.isNotEmpty &&
                  event.oldReportList != null &&
                  event.oldReportList!.isNotEmpty) {
                event.oldReportList?.addAll(reportsDetList ?? []);
                reportsDetList = event.oldReportList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldReportList != null &&
                event.oldReportList!.isNotEmpty) {
              reportsDetList = event.oldReportList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return reportData;
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
        reportData = await getUserDetails();
        (reportData != null)
            ? emit(GroupPigmyReportsLoaded())
            : emit(GroupPigmyReportsError());
      } else {
        //Internet state
        emit(GroupPigmyReportsNoInternet());
      }
    } catch (e) {
      emit(GroupPigmyReportsError());
    }
  }
}
