import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/agents_dashboard_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'agents_tab_event.dart';
part 'agents_tab_state.dart';

class AgentsTabBloc extends Bloc<AgentsTabEvent, AgentsTabState> {
  AgentsTabBloc() : super(AgentsTabLoading()) {
    on<GetAgentsDetailsEvent>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  /* JSON Text */

  // String? findCustomerDetailsText = "Find Customer Details";
  // String? verifyCustomerDetailsText = "Verify Customer Details";
  // String? updatePaymentDetailsText = "Update Payment Details";

  Data? userData;

  Future<void> _mapGetDetailsEventToState(
      GetAgentsDetailsEvent event, Emitter<AgentsTabState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .agentsDashboardService()
            .then((AgentsDashboardDataModel? respObj) {
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
        (userData != null) ? emit(AgentsTabLoaded()) : emit(AgentsTabError());
      } else {
        //Internet state
        emit(AgentsTabNoInternet());
      }
    } catch (e) {
      emit(AgentsTabError());
    }
  }
}
