import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/loans_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'loans_event.dart';
part 'loans_state.dart';

class LoansBloc extends Bloc<LoansEvent, LoansState> {
  LoansBloc() : super(LoansLoading()) {
    on<GetLoanDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  Data? loanData;

  Future<void> _mapGetDetailsEventToState(
      GetLoanDetails event, Emitter<LoansState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .loanDetailsService()
            .then((LoansDataModel? respObj) {
          if (respObj != null && respObj.data != null) {
            loanData = respObj.data;
            return loanData;
          }
        });
        return loanData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        loanData = await getUserDetails();
        (loanData != null) ? emit(LoansLoaded()) : emit(LoansError());
      } else {
        //Internet state
        emit(LoansNoInternet());
      }
    } catch (e) {
      emit(LoansError());
    }
  }
}
