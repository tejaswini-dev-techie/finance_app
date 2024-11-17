import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/group_mem_details_data_model.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';

part 'group_members_details_event.dart';
part 'group_members_details_state.dart';

class GroupMembersDetailsBloc
    extends Bloc<GroupMembersDetailsEvent, GroupMembersDetailsState> {
  GroupMembersDetailsBloc() : super(GroupMembersDetailsLoading()) {
    on<GetGroupMemDetEvent>((event, emit) async {
      await _mapGetGroupMemDetEventToState(event, emit);
    });
  }

  /* JSON Text */
  String internetAlert = "Please check your internet connection!!!";
  String? noDataFoundText = "No Data Found";
  String groupMembersDetailsText = "Group Members";

  Data? grpMemData;

  List<GroupMembersList>? grpMemList = [];
  bool saving = true;
  int page = 1;
  bool endPage = false;
  bool isNetworkConnected = true;

  Future<void> _mapGetGroupMemDetEventToState(
      GetGroupMemDetEvent event, Emitter<GroupMembersDetailsState> emit) async {
    page = event.page ?? 1;
    if (event.page == 1) {
      grpMemList?.clear();
      saving = false;
      endPage = false;
      emit(GroupMembersDetailsLoading());
    }
    try {
      bool isInternetConnected = true;

      Future<Data?> getUserDetails() async {
        await NetworkService()
            .groupMemDetailsService(
          page: event.page,
        )
            .then((GroupMembersDetailsDataModel? responseObj) {
          if (responseObj != null && responseObj.status == true) {
            if (responseObj.data != null) {
              grpMemData = responseObj.data;
              if (responseObj.data?.groupMembersList != null &&
                  responseObj.data!.groupMembersList!.isNotEmpty) {
                grpMemList = responseObj.data?.groupMembersList ?? [];
              }

              if (grpMemList != null &&
                  grpMemList!.isNotEmpty &&
                  event.oldGrpMemList != null &&
                  event.oldGrpMemList!.isNotEmpty) {
                event.oldGrpMemList?.addAll(grpMemList ?? []);
                grpMemList = event.oldGrpMemList ?? [];
              }
              page++;
              saving = false;
            }
          } else {
            if (event.oldGrpMemList != null &&
                event.oldGrpMemList!.isNotEmpty) {
              grpMemList = event.oldGrpMemList ?? [];
            }
            endPage = true;
            saving = true;
          }
        });
        return grpMemData;
      }

      getAppContentDet() async {
        var appContent = await AppLanguageUtil().getAppContentDetails();
        internetAlert = appContent['action_items']['internet_alert'] ?? "";
        noDataFoundText = appContent['action_items']['no_data'] ?? "";
        groupMembersDetailsText =
            appContent['group_mem_det']['group_mem_det_text'] ?? "";
      }

      await getAppContentDet();
      isInternetConnected = await InternetUtil().checkInternetConnection();
      if (isInternetConnected) {
        //Loaded
        grpMemData = await getUserDetails();
        (grpMemData != null)
            ? emit(GroupMembersDetailsLoaded())
            : emit(GroupMembersDetailsError());
      } else {
        //Internet state
        emit(GroupMembersDetailsNoInternet());
      }
    } catch (e) {
      emit(GroupMembersDetailsError());
    }
  }
}
