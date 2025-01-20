class UpdatePaymentDetailsDataModel {
  bool? status;
  bool? logout;
  Data? data;

  UpdatePaymentDetailsDataModel({this.status, this.logout, this.data});

  UpdatePaymentDetailsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    logout = json['logout'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['logout'] = logout;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? mobNum;
  String? codeId;
  String? agent;
  String? amtToBePaid;
  String? date;
  String? due;
  String? amtToBePaidBy;
  bool? showAmtToPaidBy;
  String? type; /* 1 - Weekly & Daily | 2 - Monthly */

  Data({
    this.id,
    this.name,
    this.mobNum,
    this.codeId,
    this.agent,
    this.amtToBePaid,
    this.date,
    this.due,
    this.amtToBePaidBy,
    this.showAmtToPaidBy,
    this.type,
    /* 1 - Weekly & Daily | 2 - Monthly */
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobNum = json['mob_num'];
    codeId = json['code_id'];
    agent = json['agent'];
    amtToBePaid = json['amt_to_be_paid'];
    date = json['date'];
    due = json['due'];
    amtToBePaidBy = json['amount_type'];
    showAmtToPaidBy = json['showAmtToPaidBy'] ?? false;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mob_num'] = mobNum;
    data['code_id'] = codeId;
    data['agent'] = agent;
    data['amt_to_be_paid'] = amtToBePaid;
    data['date'] = date;
    data['due'] = due;
    data['amount_type'] = amtToBePaidBy;
    data['showAmtToPaidBy'] = showAmtToPaidBy;
    data['type'] = type;
    return data;
  }
}
