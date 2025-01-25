class UpdateGroupPaymentDetailsDataModel {
  bool? status;
  bool? logout;
  Data? data;

  UpdateGroupPaymentDetailsDataModel({this.status, this.logout, this.data});

  UpdateGroupPaymentDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  List<CustomersList>? customersList;

  Data(
      {this.id,
      this.name,
      this.mobNum,
      this.codeId,
      this.agent,
      this.amtToBePaid,
      this.date,
      this.due,
      this.amtToBePaidBy,
      this.customersList});

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
    if (json['customers_list'] != null) {
      customersList = <CustomersList>[];
      json['customers_list'].forEach((v) {
        customersList!.add(CustomersList.fromJson(v));
      });
    }
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
    if (customersList != null) {
      data['customers_list'] = customersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomersList {
  String? cusId;
  String? cusName;
  String? cusAmt;
  bool? isEditable;
  bool? isSelected;
  String? amtToBePaidBy;
  bool? showAmtToPaidBy;
  String? type; /* 1 - Weekly & Daily | 2 - Monthly */

  CustomersList({
    this.cusId,
    this.cusName,
    this.cusAmt,
    this.isEditable,
    this.isSelected,
    this.amtToBePaidBy,
    this.showAmtToPaidBy,
    this.type,
    /* 1 - Weekly & Daily | 2 - Monthly */
  });

  CustomersList.fromJson(Map<String, dynamic> json) {
    cusId = json['cus_id'];
    cusName = json['cus_name'];
    cusAmt = json['cus_amt'];
    isEditable = json['is_editable'];
    isSelected = json['is_selected'];
    amtToBePaidBy = json['amtType'];
    showAmtToPaidBy = json['showAmtToPaidBy'] ?? false;
    type = json['type']; /* 1 - Weekly & Daily | 2 - Monthly */
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cus_id'] = cusId;
    data['cus_name'] = cusName;
    data['cus_amt'] = cusAmt;
    data['is_editable'] = isEditable;
    data['is_selected'] = isSelected;
    data['amtType'] = amtToBePaidBy;
    data['showAmtToPaidBy'] = showAmtToPaidBy;
    data['type'] = type; /* 1 - Weekly & Daily | 2 - Monthly */
    return data;
  }
}
