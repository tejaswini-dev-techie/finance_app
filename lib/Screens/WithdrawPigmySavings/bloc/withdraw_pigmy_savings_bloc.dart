import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/WithdrawPigmy/withdraw_pigmy_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'withdraw_pigmy_savings_event.dart';
part 'withdraw_pigmy_savings_state.dart';

class WithdrawPigmySavingsBloc
    extends Bloc<WithdrawPigmySavingsEvent, WithdrawPigmySavingsState> {
  WithdrawPigmySavingsBloc() : super(WithdrawPigmySavingsLoading()) {
    on<WithdrawPigmySavingsDetailsEvent>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  String internetAlert = "";
  String withdrawPigmySavingsText = "";
  String withdrawPigmySavingsTitle = "";
  String withdrawPigmySavingsSubtitle = "";
  String withdrawNowText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String altPhNumText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String emailText = "";
  String emailPlaceholderText = "";
  String streetAddressText = "";
  String cityText = "";
  String stateText = "";
  String zipText = "";
  String countryText = "";
  String withdrawAmtText = "";
  String withdrawAmtPlaceholderText = "";
  String reasonText = "";
  String reasonPlaceholderText = "";

  String noteText = "";
  String noteDescText = "";
  String footerText = "";

  Data? userData;

  Future<void> _mapGetDetailsEventToState(
      WithdrawPigmySavingsDetailsEvent event,
      Emitter<WithdrawPigmySavingsState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        if (event.type == "2") {
          await NetworkService()
              .withdrawPIGMYFetchDetailsbyAgent(
            customerID: event.customerID,
          )
              .then((WithdrawPigmyDataModel? respObj) {
            if (respObj != null && respObj.data != null) {
              userData = respObj.data;

              return userData;
            }
          });
        } else {
          await NetworkService()
              .withdrawPIGMYFetchDetails()
              .then((WithdrawPigmyDataModel? respObj) {
            if (respObj != null && respObj.data != null) {
              userData = respObj.data;

              return userData;
            }
          });
        }

        return userData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";

        withdrawPigmySavingsTitle =
            appContent['withdraw_pigmy_savings_acc']['withdraw_title'] ?? "";
        withdrawPigmySavingsSubtitle =
            appContent['withdraw_pigmy_savings_acc']['withdraw_subtitle'] ?? "";
        withdrawNowText =
            appContent['withdraw_pigmy_savings_acc']['withdraw_now_text'] ?? "";
        withdrawPigmySavingsText =
            appContent['withdraw_pigmy_savings_acc']['withdraw_text'] ?? "";
        nameText = appContent['withdraw_pigmy_savings_acc']['name_text'] ?? "";
        namePlaceHolderText = appContent['withdraw_pigmy_savings_acc']
                ['name_placeholder_text'] ??
            "";
        phNumText = appContent['withdraw_pigmy_savings_acc']['ph_text'] ?? "";
        phNumPlaceholderText = appContent['withdraw_pigmy_savings_acc']
                ['ph_placeholder_text'] ??
            "";
        altPhNumText =
            appContent['withdraw_pigmy_savings_acc']['alt_ph_text'] ?? "";
        emailText =
            appContent['withdraw_pigmy_savings_acc']['email_text'] ?? "";
        emailPlaceholderText = appContent['withdraw_pigmy_savings_acc']
                ['email_placeholder_text'] ??
            "";
        streetAddressText = appContent['withdraw_pigmy_savings_acc']
                ['street_address_text'] ??
            "";
        cityText = appContent['withdraw_pigmy_savings_acc']['city_text'] ?? "";
        stateText =
            appContent['withdraw_pigmy_savings_acc']['state_text'] ?? "";
        zipText = appContent['withdraw_pigmy_savings_acc']['zip_text'] ?? "";
        countryText =
            appContent['withdraw_pigmy_savings_acc']['country_text'] ?? "";
        withdrawAmtText =
            appContent['withdraw_pigmy_savings_acc']['withdraw_amt_text'] ?? "";
        withdrawAmtPlaceholderText = appContent['withdraw_pigmy_savings_acc']
                ['withdraw_amt_placeholder_text'] ??
            "";
        noteText = appContent['withdraw_pigmy_savings_acc']['note_text'] ?? "";
        noteDescText =
            appContent['withdraw_pigmy_savings_acc']['note_desc'] ?? "";
        footerText =
            appContent['withdraw_pigmy_savings_acc']['footer_text'] ?? "";
        reasonText =
            appContent['withdraw_pigmy_savings_acc']['reason_text'] ?? "";
        reasonPlaceholderText = appContent['withdraw_pigmy_savings_acc']
                ['reason_placeholder_text'] ??
            "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        userData = await getUserDetails();
        (userData != null)
            ? emit(WithdrawPigmySavingsLoaded())
            : emit(WithdrawPigmySavingsError());
      } else {
        //Internet state
        emit(WithdrawPigmySavingsNoInternet());
      }
    } catch (e) {
      emit(WithdrawPigmySavingsError());
    }
  }
}
