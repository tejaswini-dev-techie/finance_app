import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class CreatePigmySavingsAccountScreen extends StatefulWidget {
  const CreatePigmySavingsAccountScreen({super.key});

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

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _altPhNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _altPhNumFocusNode = FocusNode();
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
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  List<String> frequencyOptions = [
    "Select your PIGMY Frequency",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  ValueNotifier<String?> selectedValue = ValueNotifier<String>("Monthly");

  @override
  void initState() {
    super.initState();
    getAppContentDet();
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _altPhNumController.addListener(_validateFields);
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

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
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

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
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
    setState(() {});
  }

  backAction() {
    Map<String, dynamic> data = {};
    data = {
      "tab_index": 1,
    };
    Navigator.pushReplacementNamed(
      context,
      RoutingConstants.routeDashboardScreen,
      arguments: {"data": data},
    );
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
    String? altMobileError = ValidationUtil.validateAltMobileNumber(
        _altPhNumController.text, _phNumController.text);
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

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      if (selectedValue.value != "Select your PIGMY Frequency") {
        isDisabled.value = false;

        var result = await NetworkService().createPIGMYDetails(
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
        );

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
      } else if (selectedValue.value == "Select your PIGMY Frequency") {
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
}
