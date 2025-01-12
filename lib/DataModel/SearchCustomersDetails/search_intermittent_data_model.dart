class SearchIntermittentDetailsDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  SearchIntermittentDetailsDataModel(
      {this.status, this.logout, this.message, this.data});

  SearchIntermittentDetailsDataModel.fromJson(Map<String, dynamic> json) {
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
  String? profileImage;
  String? name;
  String? phNum;
  String? emailId;
  String? address;
  String? documentsText;
  List<DocsList>? docsList;
  List<ListDetails>? listDetails;
  String? withdrawPigmyText;
  String? closeLoanText;
  String? loanID;

  Data({
    this.profileImage,
    this.name,
    this.phNum,
    this.emailId,
    this.address,
    this.documentsText,
    this.docsList,
    this.listDetails,
    this.withdrawPigmyText,
    this.closeLoanText,
    this.loanID,
  });

  Data.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    name = json['name'];
    phNum = json['ph_num'];
    emailId = json['email_id'];
    address = json['address'];
    documentsText = json['documents_text'];
    withdrawPigmyText = json['withdraw_pigmy_text'] ?? "Withdraw PIGMY Savings";
    closeLoanText = json['close_loan_text'] ?? "Close Loan";
    loanID = json['loanID'] ?? "";
    if (json['docs_list'] != null) {
      docsList = <DocsList>[];
      json['docs_list'].forEach((v) {
        docsList!.add(DocsList.fromJson(v));
      });
    }
    if (json['list_details'] != null) {
      listDetails = <ListDetails>[];
      json['list_details'].forEach((v) {
        listDetails!.add(ListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_image'] = profileImage;
    data['name'] = name;
    data['ph_num'] = phNum;
    data['email_id'] = emailId;
    data['address'] = address;
    data['documents_text'] = documentsText;
    data['withdraw_pigmy_text'] = withdrawPigmyText;
    data['close_loan_text'] = closeLoanText;
    data['loanID'] = loanID;
    if (docsList != null) {
      data['docs_list'] = docsList!.map((v) => v.toJson()).toList();
    }
    if (listDetails != null) {
      data['list_details'] = listDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocsList {
  String? id;
  String? title;
  String? subTitle;
  String? imagePath;

  DocsList({this.id, this.title, this.imagePath, this.subTitle});

  DocsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subtile'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_path'] = imagePath;
    data['subtile'] = subTitle;
    return data;
  }
}

class ListDetails {
  String? listDetTitle;
  List<ListDet>? listDet;
  List<ListDetMenu>? listDetMenu;

  ListDetails({this.listDetTitle, this.listDet, this.listDetMenu});

  ListDetails.fromJson(Map<String, dynamic> json) {
    listDetTitle = json['list_det_title'];
    if (json['list_det'] != null) {
      listDet = <ListDet>[];
      json['list_det'].forEach((v) {
        listDet!.add(ListDet.fromJson(v));
      });
    }
    if (json['list_det_menu'] != null) {
      listDetMenu = <ListDetMenu>[];
      json['list_det_menu'].forEach((v) {
        listDetMenu!.add(ListDetMenu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['list_det_title'] = listDetTitle;
    if (listDet != null) {
      data['list_det'] = listDet!.map((v) => v.toJson()).toList();
    }
    if (listDetMenu != null) {
      data['list_det_menu'] = listDetMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDet {
  String? id;
  String? title;
  String? subtitle;
  String? amt;
  String? payNowText;

  ListDet({this.id, this.title, this.subtitle, this.amt, this.payNowText});

  ListDet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    amt = json['amt'];
    payNowText = json['pay_now_tex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['amt'] = amt;
    data['pay_now_tex'] = payNowText;
    return data;
  }
}

class ListDetMenu {
  String? menuId;
  String? menuTitle;
  String? menuImg;
  String? menuSubtile;

  ListDetMenu({this.menuId, this.menuTitle, this.menuImg, this.menuSubtile});

  ListDetMenu.fromJson(Map<String, dynamic> json) {
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
