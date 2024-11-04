import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/pigmy_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'pigmy_event.dart';
part 'pigmy_state.dart';

class PigmyBloc extends Bloc<PigmyEvent, PigmyState> {
  PigmyBloc() : super(PigmyLoading()) {
    on<GetPigmyDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  Data? pigmyData;

  Future<void> _mapGetDetailsEventToState(
      GetPigmyDetails event, Emitter<PigmyState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .pigmyDetailsService()
            .then((PigmyDataModel? respObj) {
          if (respObj != null && respObj.data != null) {
            pigmyData = respObj.data;
            return pigmyData;
          }
        });
        return pigmyData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        pigmyData = await getUserDetails();
        (pigmyData != null) ? emit(PigmyLoaded()) : emit(PigmyError());
      } else {
        //Internet state
        emit(PigmyNoInternet());
      }
    } catch (e) {
      emit(PigmyError());
    }
  }


}
