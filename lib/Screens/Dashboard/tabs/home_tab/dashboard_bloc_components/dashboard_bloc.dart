import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<GetUserDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "Please check your internet connection!";
  /* JSON Text */
  Data? userData;

  Future<void> _mapGetDetailsEventToState(
      GetUserDetails event, Emitter<DashboardState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService().dashboard().then((UserDashboard? respObj) {
          if (respObj != null && respObj.data != null) {
            userData = respObj.data;

            return userData;
          }
        });
        return userData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        userData = await getUserDetails();
        (userData != null) ? emit(DashboardLoaded()) : emit(DashboardError());
      } else {
        //Internet state
        emit(DashboardNoInternet());
      }
    } catch (e) {
      emit(DashboardError());
    }
  }
}
