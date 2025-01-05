class ProfileDataModel {
  bool? status;
  bool? logout;
  Data? data;

  ProfileDataModel({this.status, this.logout, this.data});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
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
  String? type; // type: 1 - User's Profile | 2 - Other's profile
  String? profileImg;
  String? name;
  String? mobNum;
  String? altMobNum;
  String? emailAddress;
  String? annualIncome;
  String? streetAddress;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? customerID;
  String? lookUpCustomerDataText;
  String? resetText;

  Data({
    this.type,
    this.profileImg,
    this.name,
    this.mobNum,
    this.altMobNum,
    this.emailAddress,
    this.annualIncome,
    this.streetAddress,
    this.city,
    this.state,
    this.country,
    this.pincode,
    this.customerID,
    this.lookUpCustomerDataText,
    this.resetText,
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    profileImg = json['profile_img'];
    name = json['name'];
    mobNum = json['mob_num'];
    altMobNum = json['alt_mob_num'];
    emailAddress = json['email_address'];
    annualIncome = json['annual_income'];
    streetAddress = json['street_address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    customerID = json['customer_id'];
    lookUpCustomerDataText = json['lookup_customer_data_text'] ?? "View Customer Information";
    resetText = json['reset_text'] ?? "Reset Password";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['profile_img'] = profileImg;
    data['name'] = name;
    data['mob_num'] = mobNum;
    data['alt_mob_num'] = altMobNum;
    data['email_address'] = emailAddress;
    data['annual_income'] = annualIncome;
    data['street_address'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    data['customer_id'] = customerID;
    data['reset_text'] = resetText;
    return data;
  }
}
