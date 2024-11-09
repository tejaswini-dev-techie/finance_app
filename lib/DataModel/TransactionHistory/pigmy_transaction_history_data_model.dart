class PigmyTransactionHistoryDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  PigmyTransactionHistoryDataModel(
      {this.status, this.logout, this.message, this.data});

  PigmyTransactionHistoryDataModel.fromJson(Map<String, dynamic> json) {
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
  List<PigmyHistList>? pigmyHistList;

  Data({this.pigmyHistList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['pigmy_hist_list'] != null) {
      pigmyHistList = <PigmyHistList>[];
      json['pigmy_hist_list'].forEach((v) {
        pigmyHistList!.add(PigmyHistList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pigmyHistList != null) {
      data['pigmy_hist_list'] = pigmyHistList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PigmyHistList {
  String? id;
  String? headerText;
  String? memName;
  String? paymentDate;
  String? footerText;
  String? amtText;
  String? payStatus;
  String? payStatusType; //1-PAID|2-DUE|3-WITHDRAW
  String? accStatus;
  String? accStatusType; //1-ACTIVE|2-CLOSED

  PigmyHistList(
      {this.id,
      this.headerText,
      this.memName,
      this.paymentDate,
      this.footerText,
      this.amtText,
      this.payStatus,
      this.payStatusType,
      this.accStatus,
      this.accStatusType});

  PigmyHistList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headerText = json['header_text'];
    memName = json['mem_name'];
    paymentDate = json['payment_date'];
    footerText = json['footer_text'];
    amtText = json['amt_text'];
    payStatus = json['pay_status'];
    payStatusType = json['pay_status_type']; //1-PAID|2-DUE|3-WITHDRAW
    accStatus = json['acc_status'];
    accStatusType = json['acc_status_type']; //1-ACTIVE|2-CLOSED
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['header_text'] = headerText;
    data['mem_name'] = memName;
    data['payment_date'] = paymentDate;
    data['footer_text'] = footerText;
    data['amt_text'] = amtText;
    data['pay_status'] = payStatus;
    data['pay_status_type'] = payStatusType; //1-PAID|2-DUE|3-WITHDRAW
    data['acc_status'] = accStatus;
    data['acc_status_type'] = accStatusType; //1-ACTIVE|2-CLOSED
    return data;
  }
}
