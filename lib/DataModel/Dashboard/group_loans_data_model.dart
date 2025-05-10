class GroupLoansDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  GroupLoansDataModel({this.status, this.logout, this.message, this.data});

  GroupLoansDataModel.fromJson(Map<String, dynamic> json) {
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
  String? noGloanTitle;
  String? noGloanSubtitle;
  String? btnText;
  List<LoansMenusList>? loansMenusList;
  String? repayAllText;
  String? transactionHistoryText;
  String? groupMemDet;
  String? upcomingText;
  List<UpcomingList>? upcomingList;
  PayAllNudge? payAllNudge;

  Data(
      {this.noGloanTitle,
      this.noGloanSubtitle,
      this.btnText,
      this.loansMenusList,
      this.repayAllText,
      this.transactionHistoryText,
      this.groupMemDet,
      this.upcomingText,
      this.upcomingList,
      this.payAllNudge});

  Data.fromJson(Map<String, dynamic> json) {
    noGloanTitle = json['no_gloan_title'];
    noGloanSubtitle = json['no_gloan_subtitle'];
    btnText = json['btn_text'];
    if (json['loans_menus_list'] != null) {
      loansMenusList = <LoansMenusList>[];
      json['loans_menus_list'].forEach((v) {
        loansMenusList!.add(LoansMenusList.fromJson(v));
      });
    }
    repayAllText = json['repay_all_text'];
    transactionHistoryText = json['transaction_history_text'];
    groupMemDet = json['group_mem_det'] ?? "";
    upcomingText = json['upcoming_text'];
    if (json['upcoming_list'] != null) {
      upcomingList = <UpcomingList>[];
      json['upcoming_list'].forEach((v) {
        upcomingList!.add(UpcomingList.fromJson(v));
      });
    }
    payAllNudge = json['pay_all_nudge'] != null
        ? PayAllNudge.fromJson(json['pay_all_nudge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_gloan_title'] = noGloanTitle;
    data['no_gloan_subtitle'] = noGloanSubtitle;
    data['btn_text'] = btnText;
    if (loansMenusList != null) {
      data['loans_menus_list'] =
          loansMenusList!.map((v) => v.toJson()).toList();
    }
    data['repay_all_text'] = repayAllText;
    data['transaction_history_text'] = transactionHistoryText;
    data['group_mem_det'] = groupMemDet;
    data['upcoming_text'] = upcomingText;
    if (upcomingList != null) {
      data['upcoming_list'] = upcomingList!.map((v) => v.toJson()).toList();
    }
    if (payAllNudge != null) {
      data['pay_all_nudge'] = payAllNudge!.toJson();
    }
    return data;
  }
}

class LoansMenusList {
  String? menuId;
  String? menuTitle;
  String? menuImg;
  String? menuSubtile;

  LoansMenusList({this.menuId, this.menuTitle, this.menuImg, this.menuSubtile});

  LoansMenusList.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    menuTitle = json['menu_title'];
    menuImg = json['menu_img'];
    menuSubtile = json['menu_subtile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['menu_title'] = menuTitle;
    data['menu_img'] = menuImg;
    data['menu_subtile'] = menuSubtile;
    return data;
  }
}

class UpcomingList {
  String? id;
  String? title;
  String? subtitle;
  String? amt;
  String? payNowTex;

  UpcomingList({this.id, this.title, this.subtitle, this.amt, this.payNowTex});

  UpcomingList.fromJson(Map<String, dynamic> json) {
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

class PayAllNudge {
  String? payAllText;
  String? loadCodeText;
  String? primaryBtnText;
  String? secBtnText;
  List<InstallmentDetList>? installmentDetList;

  PayAllNudge(
      {this.payAllText,
      this.loadCodeText,
      this.primaryBtnText,
      this.secBtnText,
      this.installmentDetList});

  PayAllNudge.fromJson(Map<String, dynamic> json) {
    payAllText = json['pay_all_text'];
    loadCodeText = json['load_code_text'];
    primaryBtnText = json['primary_btn_text'];
    secBtnText = json['sec_btn_text'];
    if (json['installment_det_list'] != null) {
      installmentDetList = <InstallmentDetList>[];
      json['installment_det_list'].forEach((v) {
        installmentDetList!.add(InstallmentDetList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pay_all_text'] = payAllText;
    data['load_code_text'] = loadCodeText;
    data['primary_btn_text'] = primaryBtnText;
    data['sec_btn_text'] = secBtnText;
    if (installmentDetList != null) {
      data['installment_det_list'] =
          installmentDetList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstallmentDetList {
  String? title;
  String? subtitle;

  InstallmentDetList({this.title, this.subtitle});

  InstallmentDetList.fromJson(Map<String, dynamic> json) {
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
