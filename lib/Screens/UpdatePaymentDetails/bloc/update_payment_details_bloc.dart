import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/PaymentDetails/update_payment_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'update_payment_details_event.dart';
part 'update_payment_details_state.dart';

class UpdatePaymentDetailsBloc
    extends Bloc<UpdatePaymentDetailsEvent, UpdatePaymentDetailsState> {
  UpdatePaymentDetailsBloc() : super(UpdatePaymentDetailsLoading()) {
    on<GetPaymentDetailsEvent>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

/* JSON Text */
  String? internetAlert = "";
  /* JSON Text */

  String updatePaymentDetailsText = "Payment";
  String updateText = "Update";

  String nameText = "";
  String namePlaceHolderText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String loanCodeText = "";
  String loanCodePlaceholderText = "";
  String agentCodeText = "";
  String agentCodePlaceholderText = "";
  String amtPaidText = "";
  String amtPaidPlaceholderText = "";
  String paymentDateText = "";
  String paymentDatePlaceholderText = "";
  String amtDueText = "";
  String amtDuePlaceholderText = "";
  String paymentTypeText = "";
  String paymentTypePlaceholderText = "";
  String paymentModeText = "";
  String paymentModePlaceholderText = "";
  String paymentStatusText = "";
  String paymentStatusPlaceholderText = "";

  Data? userData;

  Future<void> _mapGetDetailsEventToState(GetPaymentDetailsEvent event,
      Emitter<UpdatePaymentDetailsState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .updatePaymentPrefetchDetailsService(
          id: event.cusID ?? "",
          type: event.type,
        )
            .then((UpdatePaymentDetailsDataModel? respObj) {
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
        updateText =
            appContent['update_customers_payment_details']['update_text'] ?? "";
        nameText =
            appContent['update_customers_payment_details']['name_text'] ?? "";
        namePlaceHolderText = appContent['update_customers_payment_details']
                ['name_placeholder_text'] ??
            "";
        phNumText =
            appContent['update_customers_payment_details']['ph_text'] ?? "";
        phNumPlaceholderText = appContent['update_customers_payment_details']
                ['ph_placeholder_text'] ??
            "";
        updatePaymentDetailsText =
            appContent['update_customers_payment_details']
                    ['update_payment_details_text'] ??
                "";
        loanCodeText = appContent['update_customers_payment_details']
                ['loan_code_text'] ??
            "";
        loanCodePlaceholderText = appContent['update_customers_payment_details']
                ['loan_code_placeholder_text'] ??
            "";
        agentCodeText = appContent['update_customers_payment_details']
                ['agent_code_text'] ??
            "";
        agentCodePlaceholderText =
            appContent['update_customers_payment_details']
                    ['agent_code_placeholder_text'] ??
                "";
        amtPaidText = appContent['update_customers_payment_details']
                ['amt_paid_text'] ??
            "";
        amtPaidPlaceholderText = appContent['update_customers_payment_details']
                ['amt_paid_placeholder_text'] ??
            "";
        paymentDateText = appContent['update_customers_payment_details']
                ['payment_date_text'] ??
            "";
        paymentDatePlaceholderText =
            appContent['update_customers_payment_details']
                    ['payment_date_placeholder_text'] ??
                "";
        amtDueText = appContent['update_customers_payment_details']
                ['amt_due_text'] ??
            "";
        amtDuePlaceholderText = appContent['update_customers_payment_details']
                ['amt_due_placeholder_text'] ??
            "";
        paymentTypeText = appContent['update_customers_payment_details']
                ['payment_type_text'] ??
            "";
        paymentTypePlaceholderText =
            appContent['update_customers_payment_details']
                    ['payment_type_placeholder_text'] ??
                "";
        paymentModeText = appContent['update_customers_payment_details']
                ['payment_mode_text'] ??
            "";
        paymentModePlaceholderText =
            appContent['update_customers_payment_details']
                    ['payment_mode_placeholder_text'] ??
                "";
        paymentStatusText = appContent['update_customers_payment_details']
                ['payment_status_text'] ??
            "";
        paymentStatusPlaceholderText =
            appContent['update_customers_payment_details']
                    ['payment_status_placeholder_text'] ??
                "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        userData = await getUserDetails();
        (userData != null)
            ? emit(UpdatePaymentDetailsLoaded())
            : emit(UpdatePaymentDetailsError());
      } else {
        //Internet state
        emit(UpdatePaymentDetailsNoInternet());
      }
    } catch (e) {
      emit(UpdatePaymentDetailsError());
    }
  }
}
