class WithdrawPigmyDataModel {
  bool? status;
  bool? logout;
  Data? data;

  WithdrawPigmyDataModel({this.status, this.logout, this.data});

  WithdrawPigmyDataModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? fatherName;
  String? mobNum;
  String? altMobNum;
  String? emailAddress;
  String? annualIncome;
  String? streetAddress;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? balance;
  String? balanceAmt;

  Data({
    this.name,
    this.fatherName,
    this.mobNum,
    this.altMobNum,
    this.emailAddress,
    this.annualIncome,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.balance,
    this.balanceAmt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fatherName = json['father_name'];
    mobNum = json['mob_num'];
    altMobNum = json['alt_mob_num'];
    emailAddress = json['email_address'];
    annualIncome = json['annual_income'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    balance = json['balance'];
    balanceAmt = json['balance_amt'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['father_name'] = fatherName;
    data['mob_num'] = mobNum;
    data['alt_mob_num'] = altMobNum;
    data['email_address'] = emailAddress;
    data['annual_income'] = annualIncome;
    data['street_address'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    data['balance'] = balance;
    data['balance_amt'] = balanceAmt;
    return data;
  }
}
