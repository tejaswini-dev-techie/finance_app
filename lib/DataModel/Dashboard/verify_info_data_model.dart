class VerifyInformationDetailsDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  VerifyInformationDetailsDataModel(
      {this.status, this.logout, this.message, this.data});

  VerifyInformationDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  List<InfoList>? infoList;

  Data({this.title, this.infoList});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['info_list'] != null) {
      infoList = <InfoList>[];
      json['info_list'].forEach((v) {
        infoList!.add(InfoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (infoList != null) {
      data['info_list'] = infoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfoList {
  String? id;
  String? memName;
  String? footerText;
  String? status;
  String? payStatusType;
  String? type;
  String? phNum;

  InfoList({
    this.id,
    this.memName,
    this.footerText,
    this.status,
    this.payStatusType,
    this.type,
    this.phNum,
  });

  InfoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memName = json['mem_name'];
    footerText = json['footer_text'];
    status = json['status'];
    payStatusType = json['status_type'];
    type = json['type'] ?? "VERIFY";
    phNum = json['ph_num'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mem_name'] = memName;
    data['footer_text'] = footerText;
    data['status'] = status;
    data['status_type'] = payStatusType;
    data['type'] = type;
    data['ph_num'] = phNum;
    return data;
  }
}
