import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/pigmy_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'group_pigmy_event.dart';
part 'group_pigmy_state.dart';

class GroupPigmyBloc extends Bloc<GroupPigmyEvent, GroupPigmyState> {
  GroupPigmyBloc() : super(GroupPigmyLoading()) {
    on<GetGroupPigmyDetails>((event, emit) async {
      await _mapGetGroupPigmyDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  Data? pigmyData;

  Future<void> _mapGetGroupPigmyDetailsEventToState(
      GetGroupPigmyDetails event, Emitter<GroupPigmyState> emit) async {
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
        (pigmyData != null)
            ? emit(GroupPigmyLoaded())
            : emit(GroupPigmyError());
      } else {
        //Internet state
        emit(GroupPigmyNoInternet());
      }
    } catch (e) {
      emit(GroupPigmyError());
    }
  }
}
