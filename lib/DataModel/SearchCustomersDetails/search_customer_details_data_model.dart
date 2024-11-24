class SearchCustomerDetailsDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  SearchCustomerDetailsDataModel(
      {this.status, this.logout, this.message, this.data});

  SearchCustomerDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  List<SearchMembersList>? searchMembersList;

  Data({this.searchMembersList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['search_members_list'] != null) {
      searchMembersList = <SearchMembersList>[];
      json['search_members_list'].forEach((v) {
        searchMembersList!.add(SearchMembersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (searchMembersList != null) {
      data['search_members_list'] =
          searchMembersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchMembersList {
  String? memberId;
  String? profileImg;
  String? memName;
  String? loanCode;
  String? location;
  String? phNum;
  String? accStatus;
  String? accStatusType;

  SearchMembersList(
      {this.memberId,
      this.profileImg,
      this.memName,
      this.loanCode,
      this.location,
      this.phNum,
      this.accStatus,
      this.accStatusType});

  SearchMembersList.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    profileImg = json['profile_img'];
    memName = json['mem_name'];
    loanCode = json['loan_code'];
    location = json['location'];
    phNum = json['ph_num'];
    accStatus = json['acc_status'];
    accStatusType = json['acc_status_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['member_id'] = memberId;
    data['profile_img'] = profileImg;
    data['mem_name'] = memName;
    data['loan_code'] = loanCode;
    data['location'] = location;
    data['ph_num'] = phNum;
    data['acc_status'] = accStatus;
    data['acc_status_type'] = accStatusType;
    return data;
  }
}
