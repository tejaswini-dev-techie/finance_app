class UserDashboard {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  UserDashboard({this.status, this.logout, this.message, this.data});

  UserDashboard.fromJson(Map<String, dynamic> json) {
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
  List<BannerDetails>? bannerDetails;
  bool? showKycDet;
  KycDet? kycDet;
  String? servicesText;
  List<ServicesList>? servicesList;
  String? duesText;
  List<DuesSecList>? duesSecList;

  Data(
      {this.bannerDetails,
      this.showKycDet,
      this.kycDet,
      this.servicesText,
      this.servicesList,
      this.duesText,
      this.duesSecList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banner_details'] != null) {
      bannerDetails = <BannerDetails>[];
      json['banner_details'].forEach((v) {
        bannerDetails!.add(BannerDetails.fromJson(v));
      });
    }
    showKycDet = json['show_kyc_det'];
    kycDet = json['kyc_det'] != null ? KycDet.fromJson(json['kyc_det']) : null;
    servicesText = json['services_text'];
    if (json['services_list'] != null) {
      servicesList = <ServicesList>[];
      json['services_list'].forEach((v) {
        servicesList!.add(ServicesList.fromJson(v));
      });
    }
    duesText = json['dues_text'];
    if (json['dues_sec_list'] != null) {
      duesSecList = <DuesSecList>[];
      json['dues_sec_list'].forEach((v) {
        duesSecList!.add(DuesSecList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bannerDetails != null) {
      data['banner_details'] = bannerDetails!.map((v) => v.toJson()).toList();
    }
    data['show_kyc_det'] = showKycDet;
    if (kycDet != null) {
      data['kyc_det'] = kycDet!.toJson();
    }
    data['services_text'] = servicesText;
    if (servicesList != null) {
      data['services_list'] = servicesList!.map((v) => v.toJson()).toList();
    }
    data['dues_text'] = duesText;
    if (duesSecList != null) {
      data['dues_sec_list'] = duesSecList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerDetails {
  String? id;
  String? title;
  String? imgUrl;

  BannerDetails({this.id, this.title, this.imgUrl});

  BannerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img_url'] = imgUrl;
    return data;
  }
}

class KycDet {
  String? title;
  String? subtitle;
  String? btnText;
  String? type; // 1 - Complete KYC Now CTA | 2 - Contact Support CTA

  KycDet({this.title, this.subtitle, this.btnText});

  KycDet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    btnText = json['btn_text'];
    type = json['type']; // 1 - Complete KYC Now CTA | 2 - Contact Support CTA
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['btn_text'] = btnText;
    data['type'] = type; // 1 - Complete KYC Now CTA | 2 - Contact Support CTA
    return data;
  }
}

class ServicesList {
  String? id;
  String? title;
  String? imageUrl;

  ServicesList({this.id, this.title, this.imageUrl});

  ServicesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    return data;
  }
}

class DuesSecList {
  String? id;
  String? title;
  String? subtitle;
  String? amt;
  String? payNowTex;

  DuesSecList({this.id, this.title, this.subtitle, this.amt, this.payNowTex});

  DuesSecList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    amt = json['amt'];
    payNowTex = json['pay_now_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['amt'] = amt;
    data['pay_now_text'] = payNowTex;
    return data;
  }
}
