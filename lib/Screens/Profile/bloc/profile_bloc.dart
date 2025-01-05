import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/Profile/profile_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<GetUserProfileDetails>((event, emit) async {
      await _mapGetDetailsEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "Please check your internet connection!";

  String profileText = "";
  String saveText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String altPhNumText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String pswdText = "";
  String pswdPlaceholderText = "";
  String confirmPassordText = "";
  String emailText = "";
  String emailPlaceholderText = "";
  String streetAddressText = "";
  String cityText = "";
  String stateText = "";
  String zipText = "";
  String countryText = "";

  String profileTitleText = "";
  String profileSubTitleText = "";

  String resetPasswordText = "";
  String viewCustomerInfoText = "";
  /* JSON Text */
  Data? userData;

  ValueNotifier<bool> updateProfileImage = ValueNotifier<bool>(false);

  Future<void> _mapGetDetailsEventToState(
      GetUserProfileDetails event, Emitter<ProfileState> emit) async {
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .profileDetails(
          type: event.type, // type 1 - My Profile | 2 - Others Profile
          customerID: event.customerID,
        )
            .then((ProfileDataModel? respObj) {
          if (respObj != null && respObj.data != null) {
            userData = respObj.data;
            resetPasswordText = respObj.data?.resetText ?? "";
            viewCustomerInfoText = respObj.data?.lookUpCustomerDataText ?? "";

            return userData;
          }
        });
        return userData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        profileText = appContent['profile']['profile_text'] ?? "";
        nameText = appContent['profile']['name_text'] ?? "";
        namePlaceHolderText =
            appContent['profile']['name_placeholder_text'] ?? "";
        phNumText = appContent['profile']['ph_text'] ?? "";
        phNumPlaceholderText =
            appContent['profile']['ph_placeholder_text'] ?? "";
        altPhNumText = appContent['profile']['alt_ph_text'] ?? "";
        saveText = appContent['profile']['save_text'] ?? "";
        emailText = appContent['profile']['email_text'] ?? "";
        emailPlaceholderText =
            appContent['profile']['email_placeholder_text'] ?? "";
        streetAddressText = appContent['profile']['street_address_text'] ?? "";
        cityText = appContent['profile']['city_text'] ?? "";
        stateText = appContent['profile']['state_text'] ?? "";
        zipText = appContent['profile']['zip_text'] ?? "";
        countryText = appContent['profile']['country_text'] ?? "";
        profileTitleText = appContent['profile']['profile_title_text'] ?? "";
        profileSubTitleText =
            appContent['profile']['profile_subtitle_text'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        userData = await getUserDetails();
        (userData != null) ? emit(ProfileLoaded()) : emit(ProfileError());
      } else {
        //Internet state
        emit(ProfileNoInternet());
      }
    } catch (e) {
      emit(ProfileError());
    }
  }
}
