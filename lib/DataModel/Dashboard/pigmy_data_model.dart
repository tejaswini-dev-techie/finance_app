class PigmyDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  PigmyDataModel({this.status, this.logout, this.message, this.data});

  PigmyDataModel.fromJson(Map<String, dynamic> json) {
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
  String? noPigmyTitle;
  String? noPigmySubtitle;
  String? btnText;
  String? btnType; // 1 - Start Now | 2 - Request Call Back
  bool? showPigmyStatusNudge;
  String? pigmyStatusNudgeTitle;
  String? pigmyStatusNudgeSubtitle;
  String? pigmyStatusNudgeBtn;
  List<PigmyMenusList>? pigmyMenusList;
  String? learnPigmyBtnText;
  String? withdrawPigmyBtnText;
  String? pigmyTransactionHistoryBtnText;
  String? upcomingText;
  List<UpcomingList>? upcomingList;
  String? footerText;
  String? groupMemDet;

  Data({
    this.noPigmyTitle,
    this.noPigmySubtitle,
    this.btnText,
    this.btnType,
    this.showPigmyStatusNudge,
    this.pigmyStatusNudgeTitle,
    this.pigmyStatusNudgeSubtitle,
    this.pigmyStatusNudgeBtn,
    this.pigmyMenusList,
    this.learnPigmyBtnText,
    this.withdrawPigmyBtnText,
    this.pigmyTransactionHistoryBtnText,
    this.upcomingText,
    this.upcomingList,
    this.footerText,
    this.groupMemDet,
  });

  Data.fromJson(Map<String, dynamic> json) {
    noPigmyTitle = json['no_pigmy_title'];
    noPigmySubtitle = json['no_pigmy_subtitle'];
    btnText = json['btn_text'];
    btnType = json['btn_type']; // 1 - Start Now | 2 - Request Call Back
    showPigmyStatusNudge = json['show_pigmy_status_nudge'];
    pigmyStatusNudgeTitle = json['pigmy_status_nudge_title'];
    pigmyStatusNudgeSubtitle = json['pigmy_status_nudge_subtitle'];
    pigmyStatusNudgeBtn = json['pigmy_status_nudge_btn'];
    groupMemDet = json['group_mem_det'] ?? "Group Members Details";
    if (json['pigmy_menus_list'] != null) {
      pigmyMenusList = <PigmyMenusList>[];
      json['pigmy_menus_list'].forEach((v) {
        pigmyMenusList!.add(PigmyMenusList.fromJson(v));
      });
    }
    learnPigmyBtnText = json['learn_pigmy_btn_text'];
    withdrawPigmyBtnText = json['withdraw_pigmy_btn_text'];
    pigmyTransactionHistoryBtnText = json['pigmy_transaction_history_btn_text'];
    upcomingText = json['upcoming_text'];
    footerText = json['footer_text'];
    if (json['upcoming_list'] != null) {
      upcomingList = <UpcomingList>[];
      json['upcoming_list'].forEach((v) {
        upcomingList!.add(UpcomingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no_pigmy_title'] = noPigmyTitle;
    data['no_pigmy_subtitle'] = noPigmySubtitle;
    data['btn_text'] = btnText;
    data['btn_type'] = btnType; // 1 - Start Now | 2 - Request Call Back
    data['show_pigmy_status_nudge'] = showPigmyStatusNudge;
    data['pigmy_status_nudge_title'] = pigmyStatusNudgeTitle;
    data['pigmy_status_nudge_subtitle'] = pigmyStatusNudgeSubtitle;
    data['pigmy_status_nudge_btn'] = pigmyStatusNudgeBtn;
    if (pigmyMenusList != null) {
      data['pigmy_menus_list'] =
          pigmyMenusList!.map((v) => v.toJson()).toList();
    }
    data['learn_pigmy_btn_text'] = learnPigmyBtnText;
    data['withdraw_pigmy_btn_text'] = withdrawPigmyBtnText;
    data['pigmy_transaction_history_btn_text'] = pigmyTransactionHistoryBtnText;
    data['upcoming_text'] = upcomingText;
    data['group_mem_det'] = groupMemDet;
    data['footer_text'] = footerText;
    if (upcomingList != null) {
      data['upcoming_list'] = upcomingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PigmyMenusList {
  String? menuId;
  String? menuTitle;
  String? menuImg;
  String? menuSubtile;

  PigmyMenusList({this.menuId, this.menuTitle, this.menuImg, this.menuSubtile});

  PigmyMenusList.fromJson(Map<String, dynamic> json) {
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
  String? payNowText;

  UpcomingList({this.id, this.title, this.subtitle, this.amt, this.payNowText});

  UpcomingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    amt = json['amt'];
    payNowText = json['pay_now_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['amt'] = amt;
    data['pay_now_text'] = payNowText;
    return data;
  }
}
