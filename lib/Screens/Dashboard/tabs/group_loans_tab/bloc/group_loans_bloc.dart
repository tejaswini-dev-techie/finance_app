import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/group_loans_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'group_loans_event.dart';
part 'group_loans_state.dart';

class GroupLoansBloc extends Bloc<GroupLoansEvent, GroupLoansState> {
  GroupLoansBloc() : super(GroupLoansLoading()) {
    on<GetGroupDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  Data? grouploanData;

  Future<void> _mapGetDetailsEventToState(
      GetGroupDetails event, Emitter<GroupLoansState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .groupLoanDetailsService()
            .then((GroupLoansDataModel? respObj) {
          if (respObj != null && respObj.data != null) {
            grouploanData = respObj.data;
            return grouploanData;
          }
        });
        return grouploanData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        grouploanData = await getUserDetails();
        (grouploanData != null)
            ? emit(GroupLoansLoaded())
            : emit(GroupLoansError());
      } else {
        //Internet state
        emit(GroupLoansNoInternet());
      }
    } catch (e) {
      emit(GroupLoansError());
    }
  }
}
