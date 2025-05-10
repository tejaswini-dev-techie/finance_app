import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/TransactionHistory/transaction_history_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'transaction_details_event.dart';
part 'transaction_details_state.dart';

class TransactionDetailsBloc
    extends Bloc<TransactionDetailsEvent, TransactionDetailsState> {
  TransactionDetailsBloc() : super(TransactionDetailsLoading()) {
    on<GetTransactionDetailsEvent>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "";
  String transactionHistoryText = "Transaction History";
  String transactiondetailsText = "Transaction Details";
  String? noDataFoundText = "";

  Data? transactionData;

  List<TransactionHistList>? transactionHistoryList = [];
  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Future<void> _mapGetDetailsEventToState(GetTransactionDetailsEvent event,
      Emitter<TransactionDetailsState> emit) async {
    page = event.page ?? 1;
    if (event.page == 1) {
      transactionHistoryList?.clear();
      saving = false;
      endPage = false;
      emit(TransactionDetailsLoading());
    }
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .transactionHistoryDetailsService(
          page: event.page,
          type: event.type,
        )
            .then((TransactionHistoryDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              transactionData = responseObj.data;
              if (responseObj.data?.transactionHistList != null &&
                  responseObj.data!.transactionHistList!.isNotEmpty) {
                transactionHistoryList =
                    responseObj.data?.transactionHistList ?? [];
              }

              if (transactionHistoryList != null &&
                  transactionHistoryList!.isNotEmpty &&
                  event.oldTransactionHistoryList != null &&
                  event.oldTransactionHistoryList!.isNotEmpty) {
                event.oldTransactionHistoryList
                    ?.addAll(transactionHistoryList ?? []);
                transactionHistoryList = event.oldTransactionHistoryList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldTransactionHistoryList != null &&
                event.oldTransactionHistoryList!.isNotEmpty) {
              transactionHistoryList = event.oldTransactionHistoryList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return transactionData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        transactionHistoryText =
            appContent['transaction_history']['transaction_history_text'] ?? "";
        transactiondetailsText =
            appContent['transaction_history']['transaction_details_text'] ?? "";
        noDataFoundText = appContent['action_items']['no_data'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        transactionData = await getUserDetails();
        (transactionData != null)
            ? emit(TransactionDetailsLoaded())
            : emit(TransactionDetailsError());
      } else {
        //Internet state
        emit(TransactionDetailsInternet());
      }
    } catch (e) {
      emit(TransactionDetailsError());
    }
  }
}
