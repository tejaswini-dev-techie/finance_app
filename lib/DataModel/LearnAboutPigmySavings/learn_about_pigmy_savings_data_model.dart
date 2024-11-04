class LearnAboutPigmySavings {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  LearnAboutPigmySavings({this.status, this.logout, this.message, this.data});

  LearnAboutPigmySavings.fromJson(Map<String, dynamic> json) {
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
  String? btnText;
  String? footerText;
  String? title;
  String? subtitle;
  String? howItWorksText;
  List<HowItWorksList>? howItWorksList;
  String? depositSchemesText;
  List<SchemesList>? schemesList;
  String? termsCondnText;
  List<TermsList>? termsList;

  Data(
      {this.btnText,
      this.footerText,
      this.title,
      this.subtitle,
      this.howItWorksText,
      this.howItWorksList,
      this.depositSchemesText,
      this.schemesList,
      this.termsCondnText,
      this.termsList});

  Data.fromJson(Map<String, dynamic> json) {
    btnText = json['btn_text'];
    footerText = json['footer_text'];
    title = json['title'];
    subtitle = json['subtitle'];
    howItWorksText = json['how_it_works_text'];
    if (json['how_it_works_list'] != null) {
      howItWorksList = <HowItWorksList>[];
      json['how_it_works_list'].forEach((v) {
        howItWorksList!.add(HowItWorksList.fromJson(v));
      });
    }
    depositSchemesText = json['deposit_schemes_text'];
    if (json['schemes_list'] != null) {
      schemesList = <SchemesList>[];
      json['schemes_list'].forEach((v) {
        schemesList!.add(SchemesList.fromJson(v));
      });
    }
    termsCondnText = json['terms_condn_text'];
    if (json['terms_list'] != null) {
      termsList = <TermsList>[];
      json['terms_list'].forEach((v) {
        termsList!.add(TermsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['btn_text'] = btnText;
    data['footer_text'] = footerText;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['how_it_works_text'] = howItWorksText;
    if (howItWorksList != null) {
      data['how_it_works_list'] =
          howItWorksList!.map((v) => v.toJson()).toList();
    }
    data['deposit_schemes_text'] = depositSchemesText;
    if (schemesList != null) {
      data['schemes_list'] = schemesList!.map((v) => v.toJson()).toList();
    }
    data['terms_condn_text'] = termsCondnText;
    if (termsList != null) {
      data['terms_list'] = termsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HowItWorksList {
  String? title;
  String? subtitle;

  HowItWorksList({this.title, this.subtitle});

  HowItWorksList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    return data;
  }
}

class SchemesList {
  String? title;
  List<String>? schemesDet;

  SchemesList({this.title, this.schemesDet});

  SchemesList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    schemesDet = json['schemes_det'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['schemes_det'] = schemesDet;
    return data;
  }
}

class TermsList {
  String? title;
  List<String>? schemesDet;

  TermsList({this.title, this.schemesDet});

  TermsList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    schemesDet = json['schemes_det'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['schemes_det'] = schemesDet;
    return data;
  }
}
