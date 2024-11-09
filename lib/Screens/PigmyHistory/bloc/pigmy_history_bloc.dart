import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/TransactionHistory/pigmy_transaction_history_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'pigmy_history_event.dart';
part 'pigmy_history_state.dart';

class PigmyHistoryBloc extends Bloc<PigmyHistoryEvent, PigmyHistoryState> {
  PigmyHistoryBloc() : super(PigmyHistoryLoading()) {
    on<GetPigmyTransactionDetailsEvent>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "";
  String pigmyHistoryText = "PIGMY Transaction History";
  String? noDataFoundText = "";

  Data? pigmyTransactionData;

  List<PigmyHistList>? pigmyHistoryList = [];
  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Future<void> _mapGetDetailsEventToState(GetPigmyTransactionDetailsEvent event,
      Emitter<PigmyHistoryState> emit) async {
    page = event.page ?? 1;
    if (event.page == 1) {
      pigmyHistoryList?.clear();
      saving = false;
      endPage = false;
      emit(PigmyHistoryLoading());
    }
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .pigmyTransactionHistoryDetailsService(
          page: event.page,
        )
            .then((PigmyTransactionHistoryDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              pigmyTransactionData = responseObj.data;
              if (responseObj.data?.pigmyHistList != null &&
                  responseObj.data!.pigmyHistList!.isNotEmpty) {
                pigmyHistoryList = responseObj.data?.pigmyHistList ?? [];
              }

              if (pigmyHistoryList != null &&
                  pigmyHistoryList!.isNotEmpty &&
                  event.oldPigmyHistoryList != null &&
                  event.oldPigmyHistoryList!.isNotEmpty) {
                event.oldPigmyHistoryList?.addAll(pigmyHistoryList ?? []);
                pigmyHistoryList = event.oldPigmyHistoryList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldPigmyHistoryList != null &&
                event.oldPigmyHistoryList!.isNotEmpty) {
              pigmyHistoryList = event.oldPigmyHistoryList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return pigmyTransactionData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        pigmyHistoryText =
            appContent['pigmy_history']['pigmy_history_text'] ?? "";
        noDataFoundText = appContent['action_items']['no_data'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        pigmyTransactionData = await getUserDetails();
        (pigmyTransactionData != null)
            ? emit(PigmyHistoryLoaded())
            : emit(PigmyHistoryError());
      } else {
        //Internet state
        emit(PigmyHistoryNoInternet());
      }
    } catch (e) {
      emit(PigmyHistoryError());
    }
  }
}
