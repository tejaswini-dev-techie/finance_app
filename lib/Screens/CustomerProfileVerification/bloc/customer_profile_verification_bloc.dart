import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Dashboard/verify_info_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'customer_profile_verification_event.dart';
part 'customer_profile_verification_state.dart';

class CustomerProfileVerificationBloc extends Bloc<
    CustomerProfileVerificationEvent, CustomerProfileVerificationState> {
  CustomerProfileVerificationBloc()
      : super(CustomerProfileVerificationLoading()) {
    on<GetCustomerVerificationDetails>((event, emit) async {
      await _mapGetCustomerVerificationDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String? internetAlert = "Please check your internet connection!";
  String? noDataFoundText = "No Data Found";
  /* JSON Text */

  List<InfoList>? infoDetList = [];

  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Data? reportData;

  Future<void> _mapGetCustomerVerificationDetailsEventToState(
      GetCustomerVerificationDetails event,
      Emitter<CustomerProfileVerificationState> emit) async {
    try {
      bool isInternetConnected = true;
      page = event.page ?? 1;
      if (event.page == 1) {
        infoDetList?.clear();
        saving = false;
        endPage = false;
        emit(CustomerProfileVerificationLoading());
      }

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .verifyCustomerDetailsListService(
          page: event.page,
        )
            .then((VerifyInformationDetailsDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              reportData = responseObj.data;
              if (responseObj.data?.infoList != null &&
                  responseObj.data!.infoList!.isNotEmpty) {
                infoDetList = responseObj.data?.infoList ?? [];
              }

              if (infoDetList != null &&
                  infoDetList!.isNotEmpty &&
                  event.oldInfoList != null &&
                  event.oldInfoList!.isNotEmpty) {
                event.oldInfoList?.addAll(infoDetList ?? []);
                infoDetList = event.oldInfoList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldInfoList != null && event.oldInfoList!.isNotEmpty) {
              infoDetList = event.oldInfoList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return reportData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        noDataFoundText = appContent['action_items']['no_data'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        reportData = await getUserDetails();
        (reportData != null)
            ? emit(CustomerProfileVerificationLoaded())
            : emit(CustomerProfileVerificationError());
      } else {
        //Internet state
        emit(CustomerProfileVerificationNoInternet());
      }
    } catch (e) {
      emit(CustomerProfileVerificationError());
    }
  }
}
