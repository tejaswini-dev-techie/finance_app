import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/report_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'loans_reports_event.dart';
part 'loans_reports_state.dart';

class LoansReportsBloc extends Bloc<LoansReportsEvent, LoansReportsState> {
  LoansReportsBloc() : super(LoansReportsLoading()) {
    on<GetLoanReports>((event, emit) async {
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
      GetLoanReports event, Emitter<LoansReportsState> emit) async {
    try {
      bool isInternetConnected = true;
      page = event.page ?? 1;
      if (event.page == 1) {
        reportsDetList?.clear();
        saving = false;
        endPage = false;
        emit(LoansReportsLoading());
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
            ? emit(LoansReportsLoaded())
            : emit(LoansReportsError());
      } else {
        //Internet state
        emit(LoansReportsNoInternet());
      }
    } catch (e) {
      emit(LoansReportsError());
    }
  }
}
