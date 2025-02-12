class AgentsDashboardDataModel {
  bool? status;
  bool? logout;
  String? message;
  Data? data;

  AgentsDashboardDataModel({this.status, this.logout, this.message, this.data});

  AgentsDashboardDataModel.fromJson(Map<String, dynamic> json) {
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
  List<AgentMenusList>? agentMenusList;
  String? findBtnText;
  String? finGrpBtnTxt;
  String? verifyBtnText;
  String? updatePaymentDetText;
  String? grpCreationText;
  String? addGrpCustomer;
  String? registerIndividualCustomer;
  String? createPigmyBtnText;
  String? filterText;
  String? accFeeText;

  Data({
    this.agentMenusList,
    this.findBtnText,
    this.verifyBtnText,
    this.updatePaymentDetText,
    this.finGrpBtnTxt,
    this.grpCreationText,
    this.addGrpCustomer,
    this.registerIndividualCustomer,
    this.createPigmyBtnText,
    this.filterText,
    this.accFeeText,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['agent_menus_list'] != null) {
      agentMenusList = <AgentMenusList>[];
      json['agent_menus_list'].forEach((v) {
        agentMenusList!.add(AgentMenusList.fromJson(v));
      });
    }
    findBtnText = json['find_btn_text'] ?? "Find Customers Details";
    verifyBtnText = json['verify_btn_text'] ?? "Verify Customers Dashboard";
    finGrpBtnTxt = json['find_grp_btn_text'] ?? "Find Group Details";
    updatePaymentDetText = json['update_payment_det_text'] ?? "";
    grpCreationText = json['group_creation'] ?? "Open Group Account";
    addGrpCustomer = json['add_group_customer'] ?? "Add Group Customer";
    registerIndividualCustomer = json['register_individual_customer'] ??
        "Register Individual Customer Account";
    createPigmyBtnText = json['create_pigmy_text'] ?? "Open PIGMY Account";
    filterText = json['filterText'] ?? "Filter";
    accFeeText = json['acc_fee_text'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agentMenusList != null) {
      data['agent_menus_list'] =
          agentMenusList!.map((v) => v.toJson()).toList();
    }
    data['find_btn_text'] = findBtnText;
    data['verify_btn_text'] = verifyBtnText;
    data['update_payment_det_text'] = updatePaymentDetText;
    data['find_grp_btn_text'] = finGrpBtnTxt;
    data['group_creation'] = grpCreationText;
    data['add_group_customer'] = addGrpCustomer;
    data['register_individual_customer'] = registerIndividualCustomer;
    data['filterText'] = filterText;
    data['acc_fee_text'] = accFeeText;
    return data;
  }
}

class AgentMenusList {
  String? menuId;
  String? menuTitle;
  String? menuImg;
  String? menuSubtile;

  AgentMenusList({this.menuId, this.menuTitle, this.menuImg, this.menuSubtile});

  AgentMenusList.fromJson(Map<String, dynamic> json) {
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
