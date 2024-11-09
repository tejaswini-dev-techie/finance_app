class TransactionHistoryDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  TransactionHistoryDataModel(
      {this.status, this.logout, this.message, this.data});

  TransactionHistoryDataModel.fromJson(Map<String, dynamic> json) {
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
  List<TransactionHistList>? transactionHistList;

  Data({this.transactionHistList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transaction_hist_list'] != null) {
      transactionHistList = <TransactionHistList>[];
      json['transaction_hist_list'].forEach((v) {
        transactionHistList!.add(TransactionHistList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transactionHistList != null) {
      data['transaction_hist_list'] =
          transactionHistList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistList {
  String? id;
  String? headerText;
  String? memName;
  String? paymentDate;
  String? footerText;
  String? amtText;
  String? payStatus;
  String? payStatusType;
  TransactionDetails? transactionDetails;

  TransactionHistList(
      {this.id,
      this.headerText,
      this.memName,
      this.paymentDate,
      this.footerText,
      this.amtText,
      this.payStatus,
      this.payStatusType,
      this.transactionDetails});

  TransactionHistList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headerText = json['header_text'];
    memName = json['mem_name'];
    paymentDate = json['payment_date'];
    footerText = json['footer_text'];
    amtText = json['amt_text'];
    payStatus = json['pay_status'];
    payStatusType = json['pay_status_type'];
    transactionDetails = json['transaction_details'] != null
        ? TransactionDetails.fromJson(json['transaction_details'])
        : null;
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
    data['pay_status_type'] = payStatusType;
    if (transactionDetails != null) {
      data['transaction_details'] = transactionDetails!.toJson();
    }
    return data;
  }
}

class TransactionDetails {
  String? headerText;
  String? title;
  String? subtitle;
  String? amtText;
  String? payStatus;
  String? payStatusType;
  String? transId;
  String? transNum;
  String? bankNameText;
  String? bankName;
  String? utrNumText;
  String? utrNum;
  String? accNumText;
  String? accNum;
  String? accStatusText;
  String? accStatus;
  String? accStatusType;

  TransactionDetails({
    this.headerText,
    this.title,
    this.subtitle,
    this.amtText,
    this.payStatus,
    this.payStatusType,
    this.transId,
    this.transNum,
    this.bankNameText,
    this.bankName,
    this.utrNumText,
    this.utrNum,
    this.accNumText,
    this.accNum,
    this.accStatusText,
    this.accStatus,
    this.accStatusType,
  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    headerText = json['header_text'];
    title = json['title'];
    subtitle = json['subtitle'];
    amtText = json['amt_text'];
    payStatus = json['pay_status'];
    payStatusType = json['pay_status_type'];
    transId = json['trans_id'];
    transNum = json['trans_num'];
    bankNameText = json['bank_name_text'];
    bankName = json['bank_name'];
    utrNumText = json['utr_num_text'];
    utrNum = json['utr_num'];
    accNumText = json['acc_num_text'];
    accNum = json['acc_num'];
    accStatusText = json['acc_status_text'];
    accStatus = json['acc_status'];
    accStatusType = json['acc_status_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['header_text'] = headerText;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['amt_text'] = amtText;
    data['pay_status'] = payStatus;
    data['pay_status_type'] = payStatusType;
    data['trans_id'] = transId;
    data['trans_num'] = transNum;
    data['bank_name_text'] = bankNameText;
    data['bank_name'] = bankName;
    data['utr_num_text'] = utrNumText;
    data['utr_num'] = utrNum;
    data['acc_num_text'] = accNumText;
    data['acc_num'] = accNum;
    data['acc_status_text'] = accStatusText;
    data['acc_status'] = accStatus;
    data['acc_status_type'] = accStatusType;

    return data;
  }
}
