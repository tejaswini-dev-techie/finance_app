class GroupMembersDetailsDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  GroupMembersDetailsDataModel(
      {this.status, this.logout, this.message, this.data});

  GroupMembersDetailsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    logout = json['logout'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['logout'] = logout;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GroupMembersList>? groupMembersList;

  Data({this.groupMembersList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['group_members_list'] != null) {
      groupMembersList = <GroupMembersList>[];
      json['group_members_list'].forEach((v) {
        groupMembersList!.add(GroupMembersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groupMembersList != null) {
      data['group_members_list'] =
          groupMembersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupMembersList {
  String? groupId;
  String? headerText;
  String? profileImg;
  String? memName;
  String? joinedDate;
  String? footerText;
  String? amtText;
  String? payStatus;
  String? payStatusType;
  String? accStatus;
  String? accStatusType;

  GroupMembersList(
      {this.groupId,
      this.headerText,
      this.profileImg,
      this.memName,
      this.joinedDate,
      this.footerText,
      this.amtText,
      this.payStatus,
      this.payStatusType,
      this.accStatus,
      this.accStatusType});

  GroupMembersList.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    headerText = json['header_text'];
    profileImg = json['profile_img'];
    memName = json['mem_name'];
    joinedDate = json['joined_date'];
    footerText = json['footer_text'];
    amtText = json['amt_text'];
    payStatus = json['pay_status'];
    payStatusType = json['pay_status_type'];
    accStatus = json['acc_status'];
    accStatusType = json['acc_status_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['header_text'] = headerText;
    data['profile_img'] = profileImg;
    data['mem_name'] = memName;
    data['joined_date'] = joinedDate;
    data['footer_text'] = footerText;
    data['amt_text'] = amtText;
    data['pay_status'] = payStatus;
    data['pay_status_type'] = payStatusType;
    data['acc_status'] = accStatus;
    data['acc_status_type'] = accStatusType;
    return data;
  }
}
