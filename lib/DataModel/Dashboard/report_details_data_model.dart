class ReportDetailsDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  ReportDetailsDataModel({this.status, this.logout, this.message, this.data});

  ReportDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  List<ReportList>? reportList;

  Data({this.title, this.reportList});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['report_list'] != null) {
      reportList = <ReportList>[];
      json['report_list'].forEach((v) {
        reportList!.add(ReportList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (reportList != null) {
      data['report_list'] = reportList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportList {
  String? id;
  String? type;
  String? headerText;
  String? memName;
  String? phNum;
  String? paymentDate;
  String? footerText;
  String? amtText;
  String? payStatus;
  String? payStatusType;

  ReportList(
      {this.id,
      this.type,
      this.headerText,
      this.phNum,
      this.memName,
      this.paymentDate,
      this.footerText,
      this.amtText,
      this.payStatus,
      this.payStatusType});

  ReportList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    headerText = json['header_text'];
    phNum = json['ph_num'];
    memName = json['mem_name'];
    paymentDate = json['payment_date'];
    footerText = json['footer_text'];
    amtText = json['amt_text'];
    payStatus = json['pay_status'];
    payStatusType = json['pay_status_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['header_text'] = headerText;
    data['mem_name'] = memName;
    data['ph_num'] = phNum;
    data['payment_date'] = paymentDate;
    data['footer_text'] = footerText;
    data['amt_text'] = amtText;
    data['pay_status'] = payStatus;
    data['pay_status_type'] = payStatusType;
    return data;
  }
}
