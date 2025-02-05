import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/agents_tab.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/VerfifyCustomers/widgets/add_doc_image_placeholder.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class CreatePigmySavingsAccountScreen extends StatefulWidget {
  final String? type; /* type: 1 - Individual | 2 - Agent */
  final String?
      pageType; /* pageType: 1 - Individual PIGMY | 2 - Individual GPIGMY*/
  const CreatePigmySavingsAccountScreen(
      {super.key, this.type = "1", this.pageType = "1"});

  @override
  State<CreatePigmySavingsAccountScreen> createState() =>
      _CreatePigmySavingsAccountScreenState();
}

class _CreatePigmySavingsAccountScreenState
    extends State<CreatePigmySavingsAccountScreen> {
  String internetAlert = "";
  String createAccText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String altPhNumText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String pswdText = "";
  String pswdPlaceholderText = "";
  String confirmPassordText = "";
  String emailText = "";
  String emailPlaceholderText = "";
  String streetAddressText = "";
  String cityText = "";
  String stateText = "";
  String zipText = "";
  String countryText = "";
  String depositAmtText = "";
  String depositAmtPlaceholderText = "";
  String frequencyText = "";
  String frequencyPlaceholderText = "";
  String openAccText = "";

  String nomineeNameText = "";
  String nomineeRelationText = "";
  String nomineePhoneNumberText = "";
  String nomineeAadhaarNumberText = "";
  String nomineePanNumberText = "";
  String nomineeBankNameText = "";
  String nomineeAccountNumberText = "";
  String nomineeAccountNameText = "";
  String nomineeIFSCText = "";
  String nomineeBranchText = "";

  String aadhaarNumPlaceholderText = "";
  String panNumPlaceholderText = "";

  String bankName = "";
  String accNumber = "";
  String bankBranch = "";
  String ifscCode = "";
  String photoText = "";

  String addText = "CLICK HERE TO ADD";

  /* Photo Image */
  ValueNotifier<bool> refreshphotoImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosphotoList = [];
  String? photoImagePath = "";
  /* Photo Image */

  /* Signature */
  ValueNotifier<bool> refreshSignImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosSignList = [];
  String? signatureImagePath = "";
  /* Signature */

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _altPhNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _depositAmountController =
      TextEditingController();

  final TextEditingController _nomineeNameController = TextEditingController();
  final TextEditingController _nomineeRelationController =
      TextEditingController();
  final TextEditingController _nomineePhoneNumberController =
      TextEditingController();
  final TextEditingController _nomineeAadhaarNumberController =
      TextEditingController();
  final TextEditingController _nomineePanNumberController =
      TextEditingController();
  final TextEditingController _nomineeBankNameController =
      TextEditingController();
  final TextEditingController _nomineeAccountNumberController =
      TextEditingController();
  final TextEditingController _nomineeAccountNameController =
      TextEditingController();
  final TextEditingController _nomineeIFSCController = TextEditingController();
  final TextEditingController _nomineeBranchController =
      TextEditingController();
  final TextEditingController _startDateInput = TextEditingController();
  final TextEditingController _endDateInput = TextEditingController();
  final TextEditingController _agentNameController = TextEditingController();
  final TextEditingController _agentPhNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accNumController = TextEditingController();
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _bankIFSCcodeController = TextEditingController();
  final TextEditingController _locationLinkController = TextEditingController();
  final TextEditingController _workLocationLinkController =
      TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _altPhNumFocusNode = FocusNode();
  final FocusNode _permanentAddressFocusNode = FocusNode();
  final FocusNode _streetAddressFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _zipFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _depositAmountFocusNode = FocusNode();
  final FocusNode _frequencyFocusNode = FocusNode();
  final FocusNode _nomineeNameFocusNode = FocusNode();
  final FocusNode _nomineeRelationFocusNode = FocusNode();
  final FocusNode _nomineePhoneNumberFocusNode = FocusNode();
  final FocusNode _nomineeAadhaarNumberFocusNode = FocusNode();
  final FocusNode _nomineePanNumberFocusNode = FocusNode();
  final FocusNode _nomineeBankNameFocusNode = FocusNode();
  final FocusNode _nomineeAccountNumberFocusNode = FocusNode();
  final FocusNode _nomineeAccountNameFocusNode = FocusNode();
  final FocusNode _nomineeIFSCFocusNode = FocusNode();
  final FocusNode _nomineeBranchFocusNode = FocusNode();
  final FocusNode _startdateInputFocusNode = FocusNode();
  final FocusNode _enddateInputFocusNode = FocusNode();
  final FocusNode _agentNameFocusNode = FocusNode();
  final FocusNode _agentPhNumFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _bankNameFocusNode = FocusNode();
  final FocusNode _bankBranchFocusNode = FocusNode();
  final FocusNode _bankIFSCCodeFocusNode = FocusNode();
  final FocusNode _bankAccNumFocusNode = FocusNode();
  final FocusNode _aadhaarFocusNode = FocusNode();
  final FocusNode _panFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  List<String> frequencyOptions = [
    "Select PIGMY Frequency",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  ValueNotifier<String?> selectedValue = ValueNotifier<String>("Monthly");

  /* Group Pigmy */
  ValueNotifier<bool> refreshGroupPigmyCheckbox = ValueNotifier<bool>(true);
  bool? isGroupPigmy = false;

  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _referenceNumController = TextEditingController();

  final FocusNode _referenceFocusNode = FocusNode();
  final FocusNode _referenceNumFocusNode = FocusNode();
  /* Group Pigmy */

  /* Same as Permanent Address */
  ValueNotifier<bool> refreshAddress = ValueNotifier<bool>(true);
  bool? sameAsPermanentAddress = false;
  /* Same as Permanent Address */

  ValueNotifier<bool> refreshStartDate = ValueNotifier<bool>(true);

  List<String> pigmyOptions = ["Select PIGMY plans", "6", "12", "24", "36"];
  ValueNotifier<String?> selectedPigmyPlanValue =
      ValueNotifier<String>("Select PIGMY plans");

  @override
  void initState() {
    super.initState();
    getAppContentDet();
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _altPhNumController.addListener(_validateFields);
    _permanentAddressController.addListener(_validateFields);
    _streetAddressController.addListener(_validateFields);
    _cityController.addListener(_validateFields);
    _stateController.addListener(_validateFields);
    _zipController.addListener(_validateFields);
    _countryController.addListener(_validateFields);
    _depositAmountController.addListener(_validateFields);
    _nomineeNameController.addListener(_validateFields);
    _nomineeRelationController.addListener(_validateFields);
    _nomineePhoneNumberController.addListener(_validateFields);
    _nomineeAadhaarNumberController.addListener(_validateFields);
    _nomineePanNumberController.addListener(_validateFields);
    _nomineeAccountNumberController.addListener(_validateFields);
    _nomineeAccountNameController.addListener(_validateFields);
    _nomineeIFSCController.addListener(_validateFields);
    _nomineeBranchController.addListener(_validateFields);
    _nomineeBankNameController.addListener(_validateFields);
    _startDateInput.addListener(_validateFields);
    _endDateInput.addListener(_validateFields);
    _agentNameController.addListener(_validateFields);
    _agentPhNumController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _bankNameController.addListener(_validateFields);
    _accNumController.addListener(_validateFields);
    _bankBranchController.addListener(_validateFields);
    _bankIFSCcodeController.addListener(_validateFields);
    _aadhaarController.addListener(_validateFields);
    _panController.addListener(_validateFields);
  }

  void _validateFields() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid && selectedValue.value != "Select your PIGMY Frequency") {
      isDisabled.value = false; // Enable the button
    } else {
      isDisabled.value = true; // Disable the button
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phNumController.dispose();
    _altPhNumController.dispose();
    _emailController.dispose();
    _permanentAddressController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _depositAmountController.dispose();
    _nomineeNameController.dispose();
    _nomineeRelationController.dispose();
    _nomineePhoneNumberController.dispose();
    _nomineeAadhaarNumberController.dispose();
    _nomineePanNumberController.dispose();
    _nomineeAccountNumberController.dispose();
    _nomineeAccountNameController.dispose();
    _nomineeIFSCController.dispose();
    _nomineeBranchController.dispose();
    _startDateInput.dispose();
    _endDateInput.dispose();
    _agentNameController.dispose();
    _agentPhNumController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _permanentAddressFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();
    _depositAmountFocusNode.dispose();
    _frequencyFocusNode.dispose();
    _nomineeNameFocusNode.dispose();
    _nomineeRelationFocusNode.dispose();
    _nomineePhoneNumberFocusNode.dispose();
    _nomineeAadhaarNumberFocusNode.dispose();
    _nomineePanNumberFocusNode.dispose();
    _nomineeAccountNumberFocusNode.dispose();
    _nomineeAccountNameFocusNode.dispose();
    _nomineeIFSCFocusNode.dispose();
    _nomineeBranchFocusNode.dispose();
    _nomineeBankNameFocusNode.dispose();
    _startdateInputFocusNode.dispose();
    _enddateInputFocusNode.dispose();
    _agentNameFocusNode.dispose();
    _agentPhNumFocusNode.dispose();
    _passwordFocusNode.dispose();
    _bankNameController.dispose();
    _accNumController.dispose();
    _bankBranchController.dispose();
    _bankIFSCcodeController.dispose();
    _locationLinkController.dispose();
    _workLocationLinkController.dispose();
    _aadhaarController.dispose();
    _panController.dispose();
    _aadhaarFocusNode.dispose();
    _panFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _permanentAddressController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);
    _depositAmountController.removeListener(_validateFields);
    _nomineeNameController.removeListener(_validateFields);
    _nomineeRelationController.removeListener(_validateFields);
    _nomineePhoneNumberController.removeListener(_validateFields);
    _nomineeAadhaarNumberController.removeListener(_validateFields);
    _nomineePanNumberController.removeListener(_validateFields);
    _nomineeAccountNumberController.removeListener(_validateFields);
    _nomineeAccountNameController.removeListener(_validateFields);
    _nomineeIFSCController.removeListener(_validateFields);
    _nomineeBranchController.removeListener(_validateFields);
    _nomineeBankNameController.removeListener(_validateFields);
    _startDateInput.removeListener(_validateFields);
    _endDateInput.removeListener(_validateFields);
    _agentNameController.removeListener(_validateFields);
    _agentPhNumController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _bankNameController.removeListener(_validateFields);
    _accNumController.removeListener(_validateFields);
    _bankBranchController.removeListener(_validateFields);
    _bankIFSCcodeController.removeListener(_validateFields);
    _aadhaarController.removeListener(_validateFields);
    _panController.removeListener(_validateFields);

    _scrollController.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    createAccText = appContent['create_pigmy_savings_acc']['create_text'] ?? "";
    nameText = appContent['create_pigmy_savings_acc']['name_text'] ?? "";
    namePlaceHolderText =
        appContent['create_pigmy_savings_acc']['name_placeholder_text'] ?? "";
    phNumText = appContent['create_pigmy_savings_acc']['ph_text'] ?? "";
    phNumPlaceholderText =
        appContent['create_pigmy_savings_acc']['ph_placeholder_text'] ?? "";
    altPhNumText = appContent['create_pigmy_savings_acc']['alt_ph_text'] ?? "";
    openAccText = appContent['create_pigmy_savings_acc']['open_acc_text'] ?? "";
    emailText = appContent['create_pigmy_savings_acc']['email_text'] ?? "";
    emailPlaceholderText =
        appContent['create_pigmy_savings_acc']['email_placeholder_text'] ?? "";
    streetAddressText =
        appContent['create_pigmy_savings_acc']['street_address_text'] ?? "";
    cityText = appContent['create_pigmy_savings_acc']['city_text'] ?? "";
    stateText = appContent['create_pigmy_savings_acc']['state_text'] ?? "";
    zipText = appContent['create_pigmy_savings_acc']['zip_text'] ?? "";
    countryText = appContent['create_pigmy_savings_acc']['country_text'] ?? "";
    depositAmtText =
        appContent['create_pigmy_savings_acc']['deposit_amt_text'] ?? "";
    depositAmtPlaceholderText = appContent['create_pigmy_savings_acc']
            ['deposit_amt_placeholder_text'] ??
        "";
    frequencyText =
        appContent['create_pigmy_savings_acc']['frequency_text'] ?? "";
    frequencyPlaceholderText = appContent['create_pigmy_savings_acc']
            ['frequency_placeholder_text'] ??
        "";
    aadhaarNumPlaceholderText =
        appContent['verify_customers']['aadhhar_placeholder_text'] ?? "";
    panNumPlaceholderText =
        appContent['verify_customers']['pan_placeholder_text'] ?? "";
    nomineeNameText =
        appContent['create_pigmy_savings_acc']['nominee_name_text'] ?? "";
    nomineeRelationText =
        appContent['create_pigmy_savings_acc']['nominee_realtion_text'] ?? "";
    nomineePhoneNumberText =
        appContent['create_pigmy_savings_acc']['nominee_ph_num_text'] ?? "";
    nomineeAadhaarNumberText = appContent['create_pigmy_savings_acc']
            ['nominee_aadhaar_number_text'] ??
        "";
    nomineePanNumberText =
        appContent['create_pigmy_savings_acc']['nominee_pan_number_text'] ?? "";
    nomineeBankNameText =
        appContent['create_pigmy_savings_acc']['nominee_bank_name_text'] ?? "";
    nomineeAccountNumberText = appContent['create_pigmy_savings_acc']
            ['nominee_account_num_text'] ??
        "";
    nomineeAccountNameText = appContent['create_pigmy_savings_acc']
            ['nominee_account_name_text'] ??
        "";
    nomineeIFSCText =
        appContent['create_pigmy_savings_acc']['nominee_IFSC_text'] ?? "";
    nomineeBranchText =
        appContent['create_pigmy_savings_acc']['nominee_branch_text'] ?? "";
    pswdText = appContent['create_account']['pswd_text'] ?? "";
    pswdPlaceholderText =
        appContent['create_account']['pswd_placeholder_text'] ?? "";

    bankName = appContent['verify_customers']['bank_name'] ?? "";
    bankBranch = appContent['verify_customers']['bank_branch'] ?? "";
    ifscCode = appContent['verify_customers']['ifsc_code'] ?? "";
    accNumber = appContent['verify_customers']['acc_num'] ?? "";
    setState(() {});
  }

  backAction() {
    if (widget.type == "2") {
      Map<String, dynamic> data = {};
      data = {
        "tab_index": 0,
      };
      Navigator.pushReplacementNamed(
        context,
        RoutingConstants.routeDashboardScreen,
        arguments: {"data": data},
      );
    } else {
      Map<String, dynamic> data = {};
      data = {
        "tab_index": (widget.pageType == "1") ? 1 : 2,
      };
      Navigator.pushReplacementNamed(
        context,
        RoutingConstants.routeDashboardScreen,
        arguments: {"data": data},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backAction();
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            /* Hide Keyboard */
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: ColorConstants.whiteColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.sp),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                width: SizerUtil.width,
                height: 50.sp,
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.shadowBlackColor,
                      blurRadius: 8.sp,
                      offset: const Offset(0, 4),
                      spreadRadius: 4.sp,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => backAction(),
                      child: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 16.sp,
                        color: ColorConstants.darkBlueColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    // const Spacer(),
                    Expanded(
                      child: Text(
                        createAccText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorConstants.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // const Spacer(),
                    SizedBox(
                      width: 4.sp,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              child: /* SIGN IN CTA */
                  Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16.sp,
                  horizontal: 16.sp,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.shadowBlackColor,
                      blurRadius: 8.sp,
                      offset: const Offset(0, 4),
                      spreadRadius: 4.sp,
                    )
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: isDisabled,
                  builder: (context, bool values, _) {
                    return buttonWidgetHelperUtil(
                      isDisabled: false,
                      buttonText: openAccText,
                      onButtonTap: () => onOpenAccNowAction(),
                      context: context,
                      internetAlert: internetAlert,
                      borderradius: 8.sp,
                      toastError: () => onOpenAccNowAction(),
                    );
                  },
                ),
              ), /* SIGN IN CTA */
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  (accFeeText != null && accFeeText!.isNotEmpty)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.sp, horizontal: 16.sp),
                          child: Text(
                            accFeeText ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorConstants.darkBlueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: ValueListenableBuilder(
                      valueListenable: refreshInputFields,
                      builder: (context, bool vals, _) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /* Name Input Field*/
                              Text(
                                nameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                // key: _formFieldKeys[0],
                                focusnodes: _nameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.person_pin_circle_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: namePlaceHolderText,
                                textEditingController: _nameController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateName(value);
                                },
                              ),
                              /* Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Mobile Number Input Field */
                              Text(
                                phNumText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _phNumFocusNode,
                                suffixWidget: const Icon(
                                  Icons.phone_locked,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: phNumPlaceholderText,
                                textEditingController: _phNumController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[6-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateMobileNumber(
                                      value);
                                },
                              ),
                              /* Mobile Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Alternate Mobile Number Input Field */
                              Text(
                                altPhNumText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _altPhNumFocusNode,
                                suffixWidget: const Icon(
                                  Icons.phone_locked,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: phNumPlaceholderText,
                                textEditingController: _altPhNumController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[6-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateAltMobileNumber(
                                    value,
                                    _phNumController.text,
                                  );
                                },
                              ),
                              /* Alternate Mobile Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Email Address Input Field */
                              Text(
                                emailText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _emailFocusNode,
                                textcapitalization: TextCapitalization.none,
                                suffixWidget: const Icon(
                                  Icons.email,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: emailPlaceholderText,
                                textEditingController: _emailController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.emailAddress,
                                validationFunc: (value) {
                                  return ValidationUtil.validateEmailAddress(
                                      value);
                                },
                              ),
                              /* Email Address Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Aadhaar Input Field */
                              Text(
                                "Aadhaar Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _aadhaarFocusNode,
                                suffixWidget: const Icon(
                                  Icons.assignment_ind_sharp,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: aadhaarNumPlaceholderText,
                                textEditingController: _aadhaarController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateAadhaar(
                                    value,
                                  );
                                },
                              ),
                              /* Aadhaar Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* PAN Input Field */
                              Text(
                                "PAN Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _panFocusNode,
                                suffixWidget: const Icon(
                                  Icons.inventory_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: panNumPlaceholderText,
                                textEditingController: _panController,
                                textcapitalization:
                                    TextCapitalization.characters,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[A-Z]{0,5}[0-9]{0,4}[A-Z]?$'),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.text,
                                validationFunc: (value) {
                                  return ValidationUtil.validatePAN(
                                    value,
                                  );
                                },
                              ),
                              /* PAN Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Bank Name Input Field*/
                              Text(
                                bankName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _bankNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: bankName,
                                textEditingController: _bankNameController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateBankName(value);
                                },
                              ),
                              /* Bank Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Account Number Input Field */
                              Text(
                                accNumber,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _bankAccNumFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: accNumber,
                                textEditingController: _accNumController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(18),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateAccountNumber(
                                      value);
                                },
                              ),
                              /* Account Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Bank IFSC Code Input Field */
                              Text(
                                ifscCode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _bankIFSCCodeFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: ifscCode,
                                textEditingController: _bankIFSCcodeController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                        r'^[A-Z0-9]+$'), // Allows only uppercase letters and numbers
                                  ),
                                  LengthLimitingTextInputFormatter(
                                      11), // Limit input to 11 characters
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s")), // Disallow whitespace
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.text,
                                textcapitalization:
                                    TextCapitalization.characters,
                                validationFunc: (value) {
                                  return null;
                                  // ValidationUtil.validateIFSC(value);
                                },
                              ),
                              /* Bank IFSC Code Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Bank Branch Name Input Field*/
                              Text(
                                bankBranch,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _bankBranchFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: bankBranch,
                                textEditingController: _bankBranchController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateBranchName(
                                      value);
                                },
                              ),
                              /* Bank Branch Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Permanent Address Input Field*/
                              Text(
                                "Permanent Address",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _permanentAddressFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: "Address",
                                textEditingController:
                                    _permanentAddressController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                validationFunc: (value) {
                                  return ValidationUtil.validateLocation(
                                      value, 5);
                                },
                              ),
                              /* Permanent Address Input Field */

                              SizedBox(
                                height: 8.sp,
                              ),
                              ValueListenableBuilder(
                                  valueListenable: refreshAddress,
                                  builder: (context, val, _) {
                                    return InkWell(
                                      onTap: () {
                                        sameAsPermanentAddress =
                                            !sameAsPermanentAddress!;
                                        if (sameAsPermanentAddress == true) {
                                          _streetAddressController.text =
                                              _permanentAddressController.text;
                                        } else {
                                          _streetAddressController.clear();
                                        }

                                        refreshAddress.value =
                                            !refreshAddress.value;
                                      },
                                      child: Row(
                                        spacing: 2.sp,
                                        children: [
                                          (sameAsPermanentAddress == true)
                                              ? Icon(
                                                  Icons.check_box,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  size: 20.sp,
                                                ),
                                          Text(
                                            "Same as Permanent Address",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: ColorConstants.blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 8.sp,
                              ),

                              /* Street Address Input Field*/
                              Text(
                                streetAddressText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _streetAddressFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: streetAddressText,
                                textEditingController: _streetAddressController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                validationFunc: (value) {
                                  return ValidationUtil.validateLocation(
                                      value, 1);
                                },
                              ),
                              /* Street Address Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* City Input Field*/
                              Text(
                                cityText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _cityFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: cityText,
                                textEditingController: _cityController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateLocation(
                                      value, 3);
                                },
                              ),
                              /* City Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* State Input Field*/
                              Text(
                                stateText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _stateFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: stateText,
                                textEditingController: _stateController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateLocation(
                                      value, 2);
                                },
                              ),
                              /* State Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Pincode Input Field */
                              Text(
                                zipText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _zipFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: zipText,
                                textEditingController: _zipController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validatePinCode(value);
                                },
                              ),
                              /* Pincode Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Country Input Field*/
                              Text(
                                countryText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _countryFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: countryText,
                                textEditingController: _countryController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateLocation(
                                      value, 4);
                                },
                              ),
                              /* Country Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Deposit Amount Input Field */
                              Text(
                                depositAmtText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _depositAmountFocusNode,
                                suffixWidget: const Icon(
                                  Icons.attach_money_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: depositAmtPlaceholderText,
                                textEditingController: _depositAmountController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateDepositAmount(
                                      value);
                                },
                              ),
                              /* Deposit Amount Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Frequency Input Field */
                              Text(
                                frequencyText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: selectedValue,
                                builder: (context, String? vals, _) {
                                  String? errorText =
                                      ValidationUtil.validateFrequency(
                                          selectedValue.value);
                                  bool isError =
                                      ValidationUtil.validateFrequency(
                                              selectedValue.value) !=
                                          null;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: (isError)
                                                ? ColorConstants.redColor
                                                : ColorConstants
                                                    .lightShadeBlueColor, // Replace with your border color
                                            width: 1
                                                .sp, // Adjust the width of the border
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  8.sp)), // Rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.sp,
                                          vertical: 4.sp,
                                        ),
                                        child: DropdownButton<String>(
                                          focusNode: _frequencyFocusNode,
                                          value: selectedValue.value,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          underline: const SizedBox.shrink(),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.timer,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          onTap: () {},
                                          style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.sp,
                                          ),
                                          hint: Text(
                                            frequencyPlaceholderText,
                                            style: TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          items: frequencyOptions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            selectedValue.value = newValue;
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              if (selectedValue.value !=
                                                  "Select your PIGMY Frequency") {
                                                isDisabled.value = false;
                                              } else {
                                                isDisabled.value = true;
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      if (isError) // Conditionally show error message
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.sp),
                                          child: Text(
                                            errorText ?? "",
                                            style: TextStyle(
                                              color: ColorConstants.redColor,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              /* Frequency Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Name Input Field*/
                              Text(
                                nomineeNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.person_pin_circle_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeNameText,
                                textEditingController: _nomineeNameController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateNomineeName(
                                      value);
                                },
                              ),
                              /* Nominee Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Mobile Number Input Field */
                              Text(
                                nomineePhoneNumberText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineePhoneNumberFocusNode,
                                suffixWidget: const Icon(
                                  Icons.phone_locked,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: phNumPlaceholderText,
                                textEditingController:
                                    _nomineePhoneNumberController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[6-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateMobileNumber(
                                      value);
                                },
                              ),
                              /* Nominee Mobile Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Relation Input Field */
                              Text(
                                nomineeRelationText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeRelationFocusNode,
                                suffixWidget: const Icon(
                                  Icons.person_pin_circle_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeRelationText,
                                textEditingController:
                                    _nomineeRelationController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateNomineeRelation(
                                      value);
                                },
                              ),
                              /* Nominee Relation Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Aadhaar Number Input Field */
                              Text(
                                nomineeAadhaarNumberText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeAadhaarNumberFocusNode,
                                suffixWidget: const Icon(
                                  Icons.assignment_ind_sharp,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: aadhaarNumPlaceholderText,
                                textEditingController:
                                    _nomineeAadhaarNumberController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateAadhaar(
                                    value,
                                  );
                                },
                              ),
                              /* Nominee Aadhaar Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee PAN Number Input Field */
                              Text(
                                nomineePanNumberText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineePanNumberFocusNode,
                                suffixWidget: const Icon(
                                  Icons.inventory_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: panNumPlaceholderText,
                                textEditingController:
                                    _nomineePanNumberController,
                                textcapitalization:
                                    TextCapitalization.characters,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[A-Z]{0,5}[0-9]{0,4}[A-Z]?$'),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.text,
                                validationFunc: (value) {
                                  return ValidationUtil.validatePAN(
                                    value,
                                  );
                                },
                              ),
                              /* Nominee PAN Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Bank Account Holder Name Input Field */
                              Text(
                                nomineeAccountNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeAccountNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.person_pin_circle_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeAccountNameText,
                                textEditingController:
                                    _nomineeAccountNameController,
                                validationFunc: (value) {
                                  return ValidationUtil
                                      .validateNomineeAccHolderName(value);
                                },
                              ),
                              /* Nominee Bank Account Holder Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Bank Name Input Field */
                              Text(
                                nomineeBankNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeBankNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeBankNameText,
                                textEditingController:
                                    _nomineeBankNameController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateBankName(value);
                                },
                              ),
                              /* Nominee Bank Name Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Bank Acc Number Input Field */
                              Text(
                                nomineeAccountNumberText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeAccountNumberFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeAccountNumberText,
                                textEditingController:
                                    _nomineeAccountNumberController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(18),
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*$'),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateAccountNumber(
                                      value);
                                },
                              ),
                              /* Nominee Bank Acc Number Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Bank IFSC Code Input Field */
                              Text(
                                nomineeIFSCText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeIFSCFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeIFSCText,
                                textEditingController: _nomineeIFSCController,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                        r'^[A-Z0-9]+$'), // Allows only uppercase letters and numbers
                                  ),
                                  LengthLimitingTextInputFormatter(
                                      11), // Limit input to 11 characters
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s")), // Disallow whitespace
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                  ),
                                ],
                                keyboardtype: TextInputType.text,
                                textcapitalization:
                                    TextCapitalization.characters,
                                validationFunc: (value) {
                                  return null;
                                  // ValidationUtil.validateIFSC(value);
                                },
                              ),
                              /* Nominee Bank IFSC Code Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Nominee Bank Branch Input Field */
                              Text(
                                nomineeBranchText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _nomineeBranchFocusNode,
                                suffixWidget: const Icon(
                                  Icons.account_balance,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: nomineeBranchText,
                                textEditingController: _nomineeBranchController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateBranchName(
                                      value);
                                },
                              ),
                              /* Nominee Bank Branch Input Field */

                              // /* Group Pigmy Check Box */
                              // ValueListenableBuilder(
                              //     valueListenable: refreshGroupPigmyCheckbox,
                              //     builder: (context, val, _) {
                              //       return Column(
                              //         children: [
                              //           SizedBox(
                              //             height: 8.sp,
                              //           ),
                              //           InkWell(
                              //             onTap: () {
                              //               isGroupPigmy = !isGroupPigmy!;
                              //               refreshGroupPigmyCheckbox.value =
                              //                   !refreshGroupPigmyCheckbox
                              //                       .value;
                              //             },
                              //             child: Row(
                              //               spacing: 2.sp,
                              //               children: [
                              //                 (isGroupPigmy == true)
                              //                     ? Icon(
                              //                         Icons.check_box,
                              //                         color: ColorConstants
                              //                             .darkBlueColor,
                              //                         size: 20.sp,
                              //                       )
                              //                     : Icon(
                              //                         Icons
                              //                             .check_box_outline_blank,
                              //                         color: ColorConstants
                              //                             .lightBlackColor,
                              //                         size: 20.sp,
                              //                       ),
                              //                 Text(
                              //                   "Group Pigmy",
                              //                   style: TextStyle(
                              //                     fontSize: 10.sp,
                              //                     color:
                              //                         ColorConstants.blackColor,
                              //                     fontWeight: FontWeight.w400,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),

                              //           /* Group Pigmy Check Box */

                              //           /* Reference Input Field*/
                              //           (isGroupPigmy == true)
                              //               ? Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     SizedBox(
                              //                       height: 16.sp,
                              //                     ),
                              //                     Text(
                              //                       "Reference -  Group Leader Name",
                              //                       textAlign: TextAlign.center,
                              //                       style: TextStyle(
                              //                         fontSize: 10.sp,
                              //                         color: ColorConstants
                              //                             .lightBlackColor,
                              //                         fontWeight:
                              //                             FontWeight.w500,
                              //                       ),
                              //                     ),
                              //                     TextInputField(
                              //                       focusnodes:
                              //                           _referenceFocusNode,
                              //                       suffixWidget: const Icon(
                              //                         Icons.person_pin_rounded,
                              //                         color: ColorConstants
                              //                             .darkBlueColor,
                              //                       ),
                              //                       placeholderText:
                              //                           "Enter Reference Name",
                              //                       textEditingController:
                              //                           _referenceController,
                              //                       validationFunc: (value) {
                              //                         return ValidationUtil
                              //                             .validateReferenceName(
                              //                                 value);
                              //                       },
                              //                     ),
                              //                     SizedBox(
                              //                       height: 16.sp,
                              //                     ),

                              //                     /* Reference Mobile Number Input Field */
                              //                     Text(
                              //                       "Reference Contact Details",
                              //                       textAlign: TextAlign.center,
                              //                       style: TextStyle(
                              //                         fontSize: 10.sp,
                              //                         color: ColorConstants
                              //                             .lightBlackColor,
                              //                         fontWeight:
                              //                             FontWeight.w500,
                              //                       ),
                              //                     ),
                              //                     TextInputField(
                              //                       focusnodes:
                              //                           _referenceNumFocusNode,
                              //                       suffixWidget: const Icon(
                              //                         Icons.phone_locked,
                              //                         color: ColorConstants
                              //                             .darkBlueColor,
                              //                       ),
                              //                       placeholderText:
                              //                           "Enter Reference Mobile Number",
                              //                       textEditingController:
                              //                           _referenceNumController,
                              //                       inputFormattersList: <TextInputFormatter>[
                              //                         FilteringTextInputFormatter
                              //                             .digitsOnly,
                              //                         LengthLimitingTextInputFormatter(
                              //                             10),
                              //                         FilteringTextInputFormatter
                              //                             .allow(
                              //                           RegExp(
                              //                               r'^[6-9][0-9]*$'),
                              //                         ),
                              //                         FilteringTextInputFormatter
                              //                             .deny(
                              //                           RegExp(r"\s\s"),
                              //                         ),
                              //                         FilteringTextInputFormatter
                              //                             .deny(
                              //                           RegExp(
                              //                               r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                              //                         ),
                              //                       ],
                              //                       keyboardtype:
                              //                           TextInputType.number,
                              //                       validationFunc: (value) {
                              //                         return ValidationUtil
                              //                             .validateReferenceMobileNumber(
                              //                           value,
                              //                         );
                              //                       },
                              //                     ),
                              //                     /* Reference Mobile Number Input Field */
                              //                   ],
                              //                 )
                              //               : const SizedBox
                              //                   .shrink(), /* Reference Input Field */
                              //         ],
                              //       );
                              //     }),

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Start Date Input Field */
                              Text(
                                "Start Date",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: refreshStartDate,
                                  builder: (context, val, _) {
                                    return TextFormField(
                                      controller: _startDateInput,
                                      //editing controller of this TextField
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.calendar_month,
                                          color: ColorConstants.darkBlueColor,
                                        ),
                                        errorStyle: TextStyle(
                                          color: ColorConstants.redColor,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.sp,
                                        ),
                                        filled: true,
                                        fillColor: ColorConstants.whiteColor,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants.redColor,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants.redColor,
                                          ),
                                        ),
                                        hintText: "Start Date",
                                        hintStyle: TextStyle(
                                          color: ColorConstants.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      readOnly: true,
                                      focusNode: _startdateInputFocusNode,
                                      style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2010),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2040),
                                        );

                                        if (pickedDate != null) {
                                          //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(pickedDate);
                                          //formatted date output using intl package =>  2021-03-16

                                          _startDateInput.text =
                                              formattedDate; //set output date to TextField value.
                                          refreshStartDate.value =
                                              !refreshStartDate.value;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select a start date';
                                        }
                                        // You can add more complex validation if needed, such as checking date ranges.
                                        return null;
                                      },
                                    );
                                  }),
                              /* Start Date Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Pigmy Plan Input Field */
                              Text(
                                "Pigmy Plan (MONTHS)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: selectedPigmyPlanValue,
                                builder: (context, String? vals, _) {
                                  String? errorText =
                                      ValidationUtil.validatePigmyPlan(
                                          selectedPigmyPlanValue.value);
                                  bool isError =
                                      ValidationUtil.validatePigmyPlan(
                                              selectedPigmyPlanValue.value) !=
                                          null;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: (isError)
                                                ? ColorConstants.redColor
                                                : ColorConstants
                                                    .lightShadeBlueColor, // Replace with your border color
                                            width: 1
                                                .sp, // Adjust the width of the border
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  8.sp)), // Rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.0.sp,
                                          vertical: 4.sp,
                                        ),
                                        child: DropdownButton<String>(
                                          focusNode: _frequencyFocusNode,
                                          value: selectedPigmyPlanValue.value,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          underline: const SizedBox.shrink(),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.timer,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          onTap: () {},
                                          style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.sp,
                                          ),
                                          hint: Text(
                                            "PGMY Plan (MONTHS)",
                                            style: TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          items:
                                              pigmyOptions.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            selectedPigmyPlanValue.value =
                                                newValue;
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              if (selectedPigmyPlanValue
                                                      .value !=
                                                  "Select PIGMY Plan") {
                                                isDisabled.value = false;
                                              } else {
                                                isDisabled.value = true;
                                              }
                                            }
                                            // Recalculate the End Date when Pigmy Plan changes
                                            if (_startDateInput
                                                    .text.isNotEmpty &&
                                                newValue != null) {
                                              DateTime startDate = DateFormat(
                                                      'dd/MM/yyyy')
                                                  .parse(_startDateInput.text);
                                              int months =
                                                  int.tryParse(newValue) ?? 0;
                                              DateTime endDate =
                                                  calculateEndDate(
                                                      startDate, months);
                                              _endDateInput.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(endDate);
                                            }
                                          },
                                        ),
                                      ),
                                      if (isError) // Conditionally show error message
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.sp),
                                          child: Text(
                                            errorText ?? "",
                                            style: TextStyle(
                                              color: ColorConstants.redColor,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              /* Pigmy Plan Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),
                              /* End Date Input Field */
                              Text(
                                "End Date",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: refreshStartDate,
                                  builder: (context, val, _) {
                                    return TextFormField(
                                      controller: _endDateInput,
                                      //editing controller of this TextField
                                      decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.calendar_month,
                                          color: ColorConstants.darkBlueColor,
                                        ),
                                        errorStyle: TextStyle(
                                          color: ColorConstants.redColor,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.sp,
                                        ),
                                        filled: true,
                                        fillColor: ColorConstants.whiteColor,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants
                                                .lightShadeBlueColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants.redColor,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          borderSide: BorderSide(
                                            width: 1.sp,
                                            color: ColorConstants.redColor,
                                          ),
                                        ),
                                        hintText: "End Date",
                                        hintStyle: TextStyle(
                                          color: ColorConstants.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                      readOnly: true,
                                      focusNode: _enddateInputFocusNode,
                                      style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select a end date';
                                        }
                                        // You can add more complex validation if needed, such as checking date ranges.
                                        return null;
                                      },
                                    );
                                  }),
                              /* End Date Input Field */

                              /* Agent Input Field*/
                              (widget.type == "2")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Password Input Field */
                                        Text(
                                          pswdText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _passwordFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.lock,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: pswdPlaceholderText,
                                          textEditingController:
                                              _passwordController,
                                          inputFormattersList: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r"\s")),
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r"\s\s")),
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                          ],
                                          obscureTextVal: true,
                                          validationFunc: (value) {
                                            return ValidationUtil
                                                .validatePassword(value);
                                          },
                                        ),
                                        /* Password Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Agent Name */
                                        Text(
                                          "Lead - Agent Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _agentNameFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.person_pin_rounded,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: "Enter Agent Name",
                                          textEditingController:
                                              _agentNameController,
                                          validationFunc: (value) {
                                            return ValidationUtil
                                                .validateAgentName(value);
                                          },
                                        ),
                                        /* Agent Name */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Agent Mobile Number Input Field */
                                        Text(
                                          "Agent Contact Details",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _agentPhNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              "Enter Agent Mobile Number",
                                          textEditingController:
                                              _agentPhNumController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'^[6-9][0-9]*$'),
                                            ),
                                            FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\s"),
                                            ),
                                            FilteringTextInputFormatter.deny(
                                              RegExp(
                                                  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                            ),
                                          ],
                                          keyboardtype: TextInputType.number,
                                          validationFunc: (value) {
                                            return ValidationUtil
                                                .validateReferenceMobileNumber(
                                              value,
                                            );
                                          },
                                        ),
                                        /* Agent Mobile Number Input Field */
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              /* Agent Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Photo Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshphotoImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      placeholderText: "Add Photo",
                                      addText: addText,
                                      imagePath: photoImagePath ?? "",
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosphotoList = [];
                                                compressedPhotosphotoList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosphotoList,
                                                );

                                                photoImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosphotoList[0]
                                                      .path,
                                                );

                                                refreshphotoImage.value =
                                                    !refreshphotoImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosphotoList = [];
                                                compressedPhotosphotoList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosphotoList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );

                                                photoImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosphotoList[0]
                                                      .path,
                                                );

                                                refreshphotoImage.value =
                                                    !refreshphotoImage.value;
                                              },
                                            );
                                          } else {
                                            ToastUtil().showSnackBar(
                                              context: context,
                                              message: internetAlert,
                                              isError: true,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  }),
                              /* Add Photo Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Signature Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshSignImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: signatureImagePath ?? "",
                                      placeholderText: "Add Signature Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosSignList = [];
                                                compressedPhotosSignList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosSignList,
                                                  // invalidFormatErrorText: "Invalid",
                                                );
                                                print(
                                                    "signatureImagePath: 1 ${compressedPhotosSignList[0].path}");
                                                signatureImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosSignList[0]
                                                      .path,
                                                );
                                                print(
                                                    "signatureImagePath: 2$signatureImagePath");
                                                refreshSignImage.value =
                                                    !refreshSignImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosSignList = [];
                                                compressedPhotosSignList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosSignList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );
                                                print(
                                                    "signatureImagePath: 1 ${compressedPhotosSignList[0].path}");
                                                signatureImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosSignList[0]
                                                      .path,
                                                );

                                                refreshSignImage.value =
                                                    !refreshSignImage.value;
                                              },
                                            );
                                          } else {
                                            ToastUtil().showSnackBar(
                                              context: context,
                                              message: internetAlert,
                                              isError: true,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  }),
                              /* Add Signature Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Location Link */
                              Text(
                                "Location Link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextField(
                                controller: _locationLinkController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.paste,
                                      color: ColorConstants.darkBlueColor,
                                    ),
                                    onPressed: () => _pasteText(context),
                                  ),
                                  errorStyle: TextStyle(
                                    color: ColorConstants.redColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.redColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.redColor,
                                    ),
                                  ),
                                  hintText: 'Paste text here',
                                  hintStyle: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                ),
                              ),

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Work Location Link */
                              Text(
                                "Work Location Link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextField(
                                controller: _workLocationLinkController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.paste,
                                      color: ColorConstants.darkBlueColor,
                                    ),
                                    onPressed: () =>
                                        _pasteWorkLocLinkText(context),
                                  ),
                                  errorStyle: TextStyle(
                                    color: ColorConstants.redColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                  filled: true,
                                  fillColor: ColorConstants.whiteColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.lightShadeBlueColor,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.redColor,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.sp)),
                                    borderSide: BorderSide(
                                      width: 1.sp,
                                      color: ColorConstants.redColor,
                                    ),
                                  ),
                                  hintText: 'Paste text here',
                                  hintStyle: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                ),
                              ),

                              /* Work Location Link */

                              SizedBox(height: 10.sp),
                              Text(
                                'Long-press in the TextField to see the context menu with paste option.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              /* Location Link */

                              SizedBox(
                                height: 32.sp,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onOpenAccNowAction() async {
    // Validation checks
    String? nameError = ValidationUtil.validateName(_nameController.text);
    String? mobileError =
        ValidationUtil.validateMobileNumber(_phNumController.text);
    String? emailError =
        ValidationUtil.validateEmailAddress(_emailController.text);
    String? aadhaarError =
        ValidationUtil.validateAadhaar(_aadhaarController.text);
    String? panError = ValidationUtil.validatePAN(_panController.text);
    String? bankNameError =
        ValidationUtil.validateBankName(_bankNameController.text);
    String? accNumError =
        ValidationUtil.validateAccountNumber(_accNumController.text);
    String? userbankBranchError =
        ValidationUtil.validateBranchName(_bankBranchController.text);
    String? altMobileError = ValidationUtil.validateAltMobileNumber(
        _altPhNumController.text, _phNumController.text);
    String? permanentAddressError =
        ValidationUtil.validateLocation(_permanentAddressController.text, 5);
    String? streetAddressError =
        ValidationUtil.validateLocation(_streetAddressController.text, 1);
    String? cityError =
        ValidationUtil.validateLocation(_cityController.text, 3);
    String? stateError =
        ValidationUtil.validateLocation(_stateController.text, 2);
    String? zipError = ValidationUtil.validatePinCode(_zipController.text);
    String? countryError =
        ValidationUtil.validateLocation(_countryController.text, 4);
    String? depositAmountError =
        ValidationUtil.validateDepositAmount(_depositAmountController.text);
    String? frequencyError =
        ValidationUtil.validateFrequency(selectedValue.value);
    String? nomineeNameError =
        ValidationUtil.validateNomineeName(_nomineeNameController.text);
    String? nomineePhNumError =
        ValidationUtil.validateMobileNumber(_nomineePhoneNumberController.text);
    String? nomineeRelationError =
        ValidationUtil.validateNomineeRelation(_nomineeRelationController.text);
    String? nomineeAadhaarError =
        ValidationUtil.validateAadhaar(_nomineeAadhaarNumberController.text);
    String? nomineePanNumError =
        ValidationUtil.validatePAN(_nomineePanNumberController.text);
    String? nomineeAccHolderNameError =
        ValidationUtil.validateNomineeAccHolderName(
            _nomineeAccountNameController.text);
    String? nomineeBankNameError =
        ValidationUtil.validateBankName(_nomineeBankNameController.text);
    String? nomineeAccNumError = ValidationUtil.validateAccountNumber(
        _nomineeAccountNumberController.text);
    // String? ifscCodeError =
    //     ValidationUtil.validateIFSC(_nomineeIFSCController.text);
    String? bankBranchError =
        ValidationUtil.validateBranchName(_nomineeBranchController.text);
    String? referenceError =
        ValidationUtil.validateReferenceName(_referenceController.text);
    String? passwordError =
        ValidationUtil.validatePassword(_passwordController.text);
    String? agentNameError =
        ValidationUtil.validateAgentName(_agentNameController.text);
    String? agentPhNumError =
        ValidationUtil.validateMobileNumber(_agentPhNumController.text);
    String? photoImageError = ValidationUtil.validateImage(photoImagePath, 8);
    String? signatureImageError =
        ValidationUtil.validateImage(signatureImagePath, 7);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      if (selectedValue.value != "Select your PIGMY Frequency") {
        isDisabled.value = false;

        var result;

        if (widget.type == "2") {
          result = await NetworkService().createPIGMYDetailsbyAgent(
            userName: _nameController.text,
            mobNum: _phNumController.text,
            altMobNum: _altPhNumController.text,
            emailAddress: _emailController.text,
            streetAddress: _streetAddressController.text,
            city: _cityController.text,
            state: _stateController.text,
            zipCode: _zipController.text,
            country: _countryController.text,
            depositAmount: _depositAmountController.text,
            frequency: selectedValue.value,
            nomineeAadhaarNumber: _nomineeAadhaarNumberController.text,
            nomineeAccountName: _nomineeAccountNameController.text,
            nomineeAccountNumber: _nomineeAccountNumberController.text,
            nomineeBankName: _nomineeBankNameController.text,
            nomineeBranch: _nomineeBranchController.text,
            nomineeIFSC: _nomineeIFSCController.text,
            nomineeName: _nomineeNameController.text,
            nomineePanNumber: _nomineePanNumberController.text,
            nomineePhoneNumber: _nomineePhoneNumberController.text,
            nomineeRelation: _nomineeRelationController.text,
            permanentAddress: _permanentAddressController.text,
            isGroupPigmy: isGroupPigmy,
            reference: _referenceController.text,
            referenceNum: _referenceNumController.text,
            startDate: _startDateInput.text,
            pigmyPlan: selectedPigmyPlanValue.value,
            endDate: _endDateInput.text,
            agentName: _agentNameController.text,
            agentPhNum: _agentPhNumController.text,
            password: _passwordController.text,
            bankName: _bankNameController.text,
            bankBranchName: _bankBranchController.text,
            bankIFSCCode: _bankIFSCcodeController.text,
            accNumber: _accNumController.text,
            photoImagePath: photoImagePath,
            signatureImage: signatureImagePath,
            locLink: _locationLinkController.text,
            workLocLink: _workLocationLinkController.text,
            aadhaarNum: _aadhaarController.text,
            panNum: _panController.text,
          );
        } else {
          result = await NetworkService().createPIGMYDetails(
            userName: _nameController.text,
            mobNum: _phNumController.text,
            altMobNum: _altPhNumController.text,
            emailAddress: _emailController.text,
            streetAddress: _streetAddressController.text,
            city: _cityController.text,
            state: _stateController.text,
            zipCode: _zipController.text,
            country: _countryController.text,
            depositAmount: _depositAmountController.text,
            frequency: selectedValue.value,
            nomineeAadhaarNumber: _nomineeAadhaarNumberController.text,
            nomineeAccountName: _nomineeAccountNameController.text,
            nomineeAccountNumber: _nomineeAccountNumberController.text,
            nomineeBankName: _nomineeBankNameController.text,
            nomineeBranch: _nomineeBranchController.text,
            nomineeIFSC: _nomineeIFSCController.text,
            nomineeName: _nomineeNameController.text,
            nomineePanNumber: _nomineePanNumberController.text,
            nomineePhoneNumber: _nomineePhoneNumberController.text,
            nomineeRelation: _nomineeRelationController.text,
            permanentAddress: _permanentAddressController.text,
            isGroupPigmy: isGroupPigmy,
            reference: _referenceController.text,
            referenceNum: _referenceNumController.text,
            startDate: _startDateInput.text,
            pigmyPlan: selectedPigmyPlanValue.value,
            endDate: _endDateInput.text,
            bankName: _bankNameController.text,
            bankBranchName: _bankBranchController.text,
            bankIFSCCode: _bankIFSCcodeController.text,
            accNumber: _accNumController.text,
            photoImagePath: photoImagePath,
            signatureImage: signatureImagePath,
            locLink: _locationLinkController.text,
            workLocLink: _workLocationLinkController.text,
            aadhaarNum: _aadhaarController.text,
            panNum: _panController.text,
          );
        }

        if (result != null && result['status'] == true) {
          if (!mounted) return;
          if (result['message'] != null && result['message'].isNotEmpty) {
            ToastUtil().showSnackBar(
              context: context,
              message: result['message'],
              isError: false,
            );
          }
          // All validations passed, navigate to the next screen
          Future.delayed(const Duration(seconds: 1)).then((value) {
            Map<String, dynamic> data = {};
            data = {
              "tab_index": 1,
            };
            if (!mounted) return;
            Navigator.pushReplacementNamed(
              context,
              RoutingConstants.routeDashboardScreen,
              arguments: {"data": data},
            );
          });
        } else {
          if (!mounted) return;
          ToastUtil().showSnackBar(
            context: context,
            message: result['message'] ?? "Something went wrong",
            isError: true,
          );
        }
      }
    } else {
      // Check for individual errors and focus accordingly
      if (nameError != null) {
        _showErrorAndFocus(_nameFocusNode, nameError);
      } else if (mobileError != null) {
        _showErrorAndFocus(_phNumFocusNode, mobileError);
      } else if (altMobileError != null) {
        _showErrorAndFocus(_altPhNumFocusNode, altMobileError);
      } else if (emailError != null) {
        _showErrorAndFocus(_emailFocusNode, emailError);
      } else if (aadhaarError != null) {
        _showErrorAndFocus(_aadhaarFocusNode, aadhaarError);
      } else if (panError != null) {
        _showErrorAndFocus(_panFocusNode, panError);
      } else if (bankNameError != null) {
        _showErrorAndFocus(_bankNameFocusNode, bankNameError);
      } else if (accNumError != null) {
        _showErrorAndFocus(_bankAccNumFocusNode, accNumError);
      } else if (userbankBranchError != null) {
        _showErrorAndFocus(_bankBranchFocusNode, userbankBranchError);
      } else if (permanentAddressError != null) {
        _showErrorAndFocus(_permanentAddressFocusNode, permanentAddressError);
      } else if (streetAddressError != null) {
        _showErrorAndFocus(_streetAddressFocusNode, streetAddressError);
      } else if (cityError != null) {
        _showErrorAndFocus(_cityFocusNode, cityError);
      } else if (stateError != null) {
        _showErrorAndFocus(_stateFocusNode, stateError);
      } else if (zipError != null) {
        _showErrorAndFocus(_zipFocusNode, zipError);
      } else if (countryError != null) {
        _showErrorAndFocus(_countryFocusNode, countryError);
      } else if (depositAmountError != null) {
        _showErrorAndFocus(_depositAmountFocusNode, depositAmountError);
      } else if (selectedValue.value == "Select PIGMY Frequency") {
        ToastUtil().showSnackBar(
          context: context,
          message: frequencyError,
          isError: true,
        );
      } else if (nomineeNameError != null) {
        _showErrorAndFocus(_nomineeNameFocusNode, nomineeNameError);
      } else if (nomineePhNumError != null) {
        _showErrorAndFocus(_nomineePhoneNumberFocusNode, nomineePhNumError);
      } else if (nomineeRelationError != null) {
        _showErrorAndFocus(_nomineeRelationFocusNode, nomineeRelationError);
      } else if (nomineeAadhaarError != null) {
        _showErrorAndFocus(_nomineeAadhaarNumberFocusNode, nomineeAadhaarError);
      } else if (nomineePanNumError != null) {
        _showErrorAndFocus(_nomineePanNumberFocusNode, nomineePanNumError);
      } else if (nomineeAccHolderNameError != null) {
        _showErrorAndFocus(
            _nomineeAccountNameFocusNode, nomineeAccHolderNameError);
      } else if (nomineeBankNameError != null) {
        _showErrorAndFocus(_nomineeBankNameFocusNode, nomineeBankNameError);
      } else if (nomineeAccNumError != null) {
        _showErrorAndFocus(_nomineeAccountNumberFocusNode, nomineeAccNumError);
      }
      // else if (ifscCodeError != null) {
      //   _showErrorAndFocus(_nomineeIFSCFocusNode, ifscCodeError);
      // }
      else if (bankBranchError != null) {
        _showErrorAndFocus(_nomineeBranchFocusNode, bankBranchError);
      } else if ((isGroupPigmy == true) && (referenceError != null)) {
        _showErrorAndFocus(_referenceFocusNode, referenceError);
      } else if (selectedPigmyPlanValue.value == "Select PIGMY plans") {
        ToastUtil().showSnackBar(
          context: context,
          message: "Please select PIGMY plans",
          isError: true,
        );
      } else if ((widget.type == "2") && (passwordError != null)) {
        _showErrorAndFocus(_passwordFocusNode, passwordError);
      } else if ((widget.type == "2") && agentNameError != null) {
        _showErrorAndFocus(_agentNameFocusNode, agentNameError);
      } else if ((widget.type == "2") && agentPhNumError != null) {
        _showErrorAndFocus(_agentPhNumFocusNode, agentPhNumError);
      } else if (photoImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: photoImageError,
          isError: true,
        );
      } else if (signatureImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: signatureImageError,
          isError: true,
        );
      }
    }
  }

// Helper function to show error and focus the respective field
  void _showErrorAndFocus(FocusNode focusNode, String error) {
    focusNode.unfocus(); // Unfocus first to reset focus
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        focusNode.requestFocus(); // Refocus after a short delay

        refreshInputFields.value = !refreshInputFields.value;

        ToastUtil().showSnackBar(
          context: context,
          message: error,
          isError: true,
        );
      },
    );
  }

  // Add this method for calculating the end date
  DateTime calculateEndDate(DateTime startDate, int months) {
    return DateTime(startDate.year, startDate.month + months, startDate.day);
  }

  /* Pick Image from Gallery */
  Future<List<File>> pickPhotos({
    required int maxImagesCount,
    required BuildContext? context,
    required List<File> compressedPhotosList,
    required String invalidFormatErrorText,
  }) async {
    try {
      Map<Permission, PermissionStatus> permissionStatus;
      bool isGrantedPermission = false;
      final RegExp regExpImgFor = RegExp(r'\.(jpg|jpeg|png)$');

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          permissionStatus = await permissionServices(
              permissionRequestList: [Permission.storage]);
          isGrantedPermission =
              (permissionStatus[Permission.storage]!.isGranted);
        } else {
          permissionStatus = await permissionServices(
              permissionRequestList: [Permission.photos]);
          isGrantedPermission =
              (permissionStatus[Permission.photos]!.isGranted);
        }
      } else {
        permissionStatus = await permissionServices(
            permissionRequestList: [Permission.photos]);
        isGrantedPermission = (permissionStatus[Permission.photos]!.isGranted);
      }
      if (isGrantedPermission) {
        List<PlatformFile>? photosList = [];
        FilePickerResult? picResult;
        if (Platform.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;
          (androidInfo.version.sdkInt <= 29)
              ? picResult = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                  allowCompression: true,
                  allowMultiple: false,
                )
              : picResult = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowCompression: true,
                  allowMultiple: false,
                );
        } else {
          picResult = await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowCompression: true,
            allowMultiple: false,
          );
        }

        photosList = picResult?.files;

        if (photosList != null && photosList.isNotEmpty) {
          for (int i = 0; i < photosList.length; i++) {
            if (!regExpImgFor.hasMatch(photosList[i].path!.split('/').last)) {
              // ignore: use_build_context_synchronously
              print("Invalid Image Format");
            } else {
              XFile? photoCompressedFile =
                  await compressImage(File(photosList[i].path ?? ""));
              compressedPhotosList.insert(
                0,
                File(photoCompressedFile!.path),
              );
            }
          }
        }
        return compressedPhotosList;
      }
    } catch (e) {
      return compressedPhotosList;
    }
    return compressedPhotosList;
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices(
      {required List<Permission> permissionRequestList}) async {
    Map<Permission, PermissionStatus>? statuses =
        await permissionRequestList.request();
    for (var request in permissionRequestList) {
      if (Platform.isAndroid) {
        if (statuses[request]!.isPermanentlyDenied) {
        } else if (statuses[request]!.isGranted) {
        } else if (statuses[request]!.isDenied) {}
      }
    }

    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  /* Alert Dialog for Updating KYC Docs */
  void showDocsAlertDialog({
    required BuildContext context,
    required Function onCaptureAction,
    required Function onGalleryAction,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 40.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  16.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCaptureAction();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Capture a Photo',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: ColorConstants.blackColor,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onGalleryAction();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Pick from Gallery',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: ColorConstants.blackColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Dismiss',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  /* Alert Dialog for Updating KYC Docs */

  /* Capture Picture */
  Future<List<File>> capturePhoto(
      {required maxImagesCount,
      required BuildContext? context,
      required List<File> compressedPhotosList,
      required int type, // 1: means  default, 2 : means only picture
      required String screenName}) async {
    try {
      RegExp regExpImg = RegExp(
        r'.png|.jp|.heic',
        caseSensitive: false,
        multiLine: false,
      );
      Map<Permission, PermissionStatus> permissionStatus;
      bool isGrantedPermission = false;
      permissionStatus = await permissionServices(
        permissionRequestList: [
          Permission.camera,
          if (type != 2) Permission.microphone,
        ],
      );
      isGrantedPermission = ((type != 2)
          ? (permissionStatus[Permission.camera]!.isGranted &&
              permissionStatus[Permission.microphone]!.isGranted)
          : (permissionStatus[Permission.camera]!.isGranted));

      if (isGrantedPermission) {
        PrintUtil().printMsg("enter granted");
        if (maxImagesCount == 1) {
          compressedPhotosList = [];
        }
        if (compressedPhotosList.length != maxImagesCount) {
          List photosList = [];
          Map<String, dynamic> data = {};
          data = {
            "type": type,
          };

          var res = await Navigator.pushNamed(
            context!,
            RoutingConstants.routeCapturePhotoCamera,
            arguments: {'data': data},
          );
          print("Result: $res");
          if (res != null) {
            photosList.add(res);
          }

          if (photosList.isNotEmpty) {
            for (int i = 0; i < photosList.length; i++) {
              if (!regExpImg.hasMatch(photosList[i].split('/').last)) {
                // ignore: use_build_context_synchronously
                ToastUtil().showSnackBar(
                    context: context,
                    message: "Invalid file format",
                    isError: true);
              } else {
                PrintUtil().printMsg("photoCompressedFile: ${photosList[i]}");
                XFile? photoCompressedFile =
                    await compressImage(File(photosList[i]));
                PrintUtil().printMsg(
                    "photoCompressedFile: ${photoCompressedFile?.path}");
                compressedPhotosList.insert(
                  0,
                  File(photoCompressedFile?.path ?? ""),
                );
              }
            }
          }
        }
        return compressedPhotosList;
      }
    } catch (e) {
      return compressedPhotosList;
    }
    return compressedPhotosList;
  }

  Future<void> _pasteText(BuildContext context) async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text != null) {
      _locationLinkController.text = clipboardData!.text!;
      ToastUtil().showSnackBar(
        context: context,
        message: 'Pasted from clipboard!',
        isError: false,
      );
    } else {
      ToastUtil().showSnackBar(
        context: context,
        message: 'Clipboard is empty',
        isError: false,
      );
    }
  }

  Future<void> _pasteWorkLocLinkText(BuildContext context) async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text != null) {
      _workLocationLinkController.text = clipboardData!.text!;
      ToastUtil().showSnackBar(
        context: context,
        message: 'Pasted from clipboard!',
        isError: false,
      );
    } else {
      ToastUtil().showSnackBar(
        context: context,
        message: 'Clipboard is empty',
        isError: false,
      );
    }
  }
}
