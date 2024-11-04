import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/VerfifyCustomers/widgets/add_doc_image_placeholder.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class VerifyCustomersDetailsScreen extends StatefulWidget {
  final String? title;
  const VerifyCustomersDetailsScreen({super.key, this.title});

  @override
  State<VerifyCustomersDetailsScreen> createState() =>
      _VerifyCustomersDetailsScreenState();
}

class _VerifyCustomersDetailsScreenState
    extends State<VerifyCustomersDetailsScreen> {
  /* JSON Text */
  String? internetAlert = "";
  /* JSON Text */

  String customerVerificationText = "";
  String submitText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String altPhNumText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String emailText = "";
  String emailPlaceholderText = "";
  String streetAddressText = "";
  String cityText = "";
  String stateText = "";
  String zipText = "";
  String countryText = "";

  String aadhaarNumText = "";
  String aadhaarNumPlaceholderText = "";
  String panNumText = "";
  String panNumPlaceholderText = "";

  String rcHolderNameText = "";
  String propertyHolderNameText = "";
  String propertyDetailsText = "";
  String chequeNumberText = "";
  String chequeNumberPlaceHolderText = "";

  String bankName = "";
  String accNumber = "";
  String bankBranch = "";
  String ifscCode = "";

  String addText = "CLICK HERE TO ADD";

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
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _rcHolderNameController = TextEditingController();
  final TextEditingController _propertyHolderNameController =
      TextEditingController();
  final TextEditingController _propertyDetailsController =
      TextEditingController();
  final TextEditingController _chequeNumController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accNumController = TextEditingController();
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _bankIFSCcodeController = TextEditingController();
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
  final FocusNode _aadhaarFocusNode = FocusNode();
  final FocusNode _panFocusNode = FocusNode();
  final FocusNode _rcHolderNameFocusNode = FocusNode();
  final FocusNode _propertyHolderNameFocusNode = FocusNode();
  final FocusNode _propertyDetailsFocusNode = FocusNode();
  final FocusNode _chequeNumFocusNode = FocusNode();
  final FocusNode _bankNameFocusNode = FocusNode();
  final FocusNode _bankBranchFocusNode = FocusNode();
  final FocusNode _bankIFSCCodeFocusNode = FocusNode();
  final FocusNode _bankAccNumFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  /* Aadhaar Image */
  ValueNotifier<bool> refreshAadhaarImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosAadhaarList = [];
  String? aadhaarImagePath = "";
  /* Aadhaar Image */

  /* PAN Image */
  ValueNotifier<bool> refreshPanImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosPanList = [];
  String? panImagePath = "";
  /* PAN Image */

  /* Cheque Image */
  ValueNotifier<bool> refreshChequeImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosChequeList = [];
  String? chequeImagePath = "";
  /* Cheque Image */

  /* RC HOLDER Image */
  ValueNotifier<bool> refreshRCHOLDERImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosRCHOLDERList = [];
  String? rcHOLDERImagePath = "";
  /* RC HOLDER Image */

  /* Property Image */
  ValueNotifier<bool> refreshPropertyDocImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosPropertyDocList = [];
  String? propertyDocImagePath = "";
  /* Property Image */

  /* Pass Book */
  ValueNotifier<bool> refreshPassBookImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosPassBookList = [];
  String? passBookImagePath = "";
  /* Pass Book */

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
    _aadhaarController.addListener(_validateFields);
    _panController.addListener(_validateFields);
    _rcHolderNameController.addListener(_validateFields);
    _propertyHolderNameController.addListener(_validateFields);
    _propertyDetailsController.addListener(_validateFields);
    _chequeNumController.addListener(_validateFields);
    _bankNameController.addListener(_validateFields);
    _accNumController.addListener(_validateFields);
    _bankBranchController.addListener(_validateFields);
    _bankIFSCcodeController.addListener(_validateFields);
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
    _aadhaarController.dispose();
    _panController.dispose();
    _rcHolderNameController.dispose();
    _propertyHolderNameController.dispose();
    _propertyDetailsController.dispose();
    _chequeNumController.dispose();
    _bankNameController.dispose();
    _accNumController.dispose();
    _bankBranchController.dispose();
    _bankIFSCcodeController.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();
    _aadhaarFocusNode.dispose();
    _panFocusNode.dispose();
    _rcHolderNameFocusNode.dispose();
    _propertyHolderNameFocusNode.dispose();
    _propertyDetailsFocusNode.dispose();
    _chequeNumFocusNode.dispose();
    _bankNameFocusNode.dispose();
    _bankBranchFocusNode.dispose();
    _bankIFSCCodeFocusNode.dispose();
    _bankAccNumFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);
    _aadhaarController.removeListener(_validateFields);
    _panController.removeListener(_validateFields);
    _rcHolderNameController.removeListener(_validateFields);
    _propertyHolderNameController.removeListener(_validateFields);
    _propertyDetailsController.removeListener(_validateFields);
    _chequeNumController.removeListener(_validateFields);
    _bankNameController.removeListener(_validateFields);
    _accNumController.removeListener(_validateFields);
    _bankBranchController.removeListener(_validateFields);
    _bankIFSCcodeController.removeListener(_validateFields);

    _scrollController.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";

    nameText = appContent['verify_customers']['name_text'] ?? "";
    namePlaceHolderText =
        appContent['verify_customers']['name_placeholder_text'] ?? "";
    phNumText = appContent['verify_customers']['ph_text'] ?? "";
    phNumPlaceholderText =
        appContent['verify_customers']['ph_placeholder_text'] ?? "";
    altPhNumText = appContent['verify_customers']['alt_ph_text'] ?? "";
    emailText = appContent['verify_customers']['email_text'] ?? "";
    emailPlaceholderText =
        appContent['verify_customers']['email_placeholder_text'] ?? "";
    streetAddressText =
        appContent['verify_customers']['street_address_text'] ?? "";
    cityText = appContent['verify_customers']['city_text'] ?? "";
    stateText = appContent['verify_customers']['state_text'] ?? "";
    zipText = appContent['verify_customers']['zip_text'] ?? "";
    countryText = appContent['verify_customers']['country_text'] ?? "";
    customerVerificationText =
        appContent['verify_customers']['customer_verification_text'] ?? "";
    submitText = appContent['verify_customers']['submit_text'] ?? "";
    aadhaarNumText = appContent['verify_customers']['aadhhar_num_text'] ?? "";
    aadhaarNumPlaceholderText =
        appContent['verify_customers']['aadhhar_placeholder_text'] ?? "";
    panNumText = appContent['verify_customers']['pan_text'] ?? "";
    panNumPlaceholderText =
        appContent['verify_customers']['pan_placeholder_text'] ?? "";
    rcHolderNameText =
        appContent['verify_customers']['rc_holder_name_text'] ?? "";
    propertyHolderNameText =
        appContent['verify_customers']['property_holder_text'] ?? "";
    propertyDetailsText =
        appContent['verify_customers']['property_details_text'] ?? "";
    chequeNumberText = appContent['verify_customers']['cheque_num_text'] ?? "";
    chequeNumberPlaceHolderText =
        appContent['verify_customers']['cheque_num_placeholder_text'] ?? "";
    bankName = appContent['verify_customers']['bank_name'] ?? "";
    bankBranch = appContent['verify_customers']['bank_branch'] ?? "";
    ifscCode = appContent['verify_customers']['ifsc_code'] ?? "";
    accNumber = appContent['verify_customers']['acc_num'] ?? "";
    setState(() {});
  }

  void _validateFields() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      isDisabled.value = false; // Enable the button
    } else {
      isDisabled.value = true; // Disable the button
    }
  }

  backAction() {
    Navigator.pop(context);
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
                        widget.title ?? customerVerificationText,
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
              child: /* Withdraw Now CTA */
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
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isDisabled,
                      builder: (context, bool values, _) {
                        return buttonWidgetHelperUtil(
                          isDisabled: false,
                          buttonText: submitText,
                          onButtonTap: () => onSubmitAction(),
                          context: context,
                          internetAlert: internetAlert,
                          borderradius: 8.sp,
                          toastError: () => onSubmitAction(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              /* Withdraw Now CTA */
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 16.sp,
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

                              /* Aadhaar Input Field */
                              Text(
                                aadhaarNumText,
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
                                panNumText,
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

                              /* RC Holder Name Field */
                              Text(
                                rcHolderNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _rcHolderNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.assignment_ind_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: rcHolderNameText,
                                textEditingController: _rcHolderNameController,
                                textcapitalization: TextCapitalization.words,
                                inputFormattersList: <TextInputFormatter>[
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
                                  return ValidationUtil.validateRCHolderName(
                                    value,
                                  );
                                },
                              ),
                              /* RC Holder Name Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Property Holder Name Field */
                              Text(
                                propertyHolderNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _propertyHolderNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.badge_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: propertyHolderNameText,
                                textEditingController:
                                    _propertyHolderNameController,
                                textcapitalization:
                                    TextCapitalization.sentences,
                                inputFormattersList: <TextInputFormatter>[
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
                                  return ValidationUtil
                                      .validatePropertyHolderName(
                                    value,
                                  );
                                },
                              ),
                              /* Property Holder Name Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Property Details Field */
                              Text(
                                propertyDetailsText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _propertyDetailsFocusNode,
                                suffixWidget: const Icon(
                                  Icons.chalet_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: propertyDetailsText,
                                textEditingController:
                                    _propertyDetailsController,
                                textcapitalization:
                                    TextCapitalization.sentences,
                                inputFormattersList: <TextInputFormatter>[
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
                                  return ValidationUtil.validatePropertyDetails(
                                    value,
                                  );
                                },
                              ),
                              /* Property Details Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Cheque Number Field */
                              Text(
                                chequeNumberText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _chequeNumFocusNode,
                                suffixWidget: const Icon(
                                  Icons.money,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: chequeNumberPlaceHolderText,
                                textEditingController: _chequeNumController,
                                textcapitalization:
                                    TextCapitalization.characters,
                                inputFormattersList: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[0-9]*$'), // Allows only digits
                                  ),
                                  LengthLimitingTextInputFormatter(
                                      10), // Limits input to 10 characters (adjust if needed)
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r"\s\s"), // Prevents multiple spaces (though likely unnecessary for digits only)
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(
                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'), // Blocks certain unicode characters (emojis, special symbols)
                                  ),
                                ],
                                keyboardtype: TextInputType.number,
                                validationFunc: (value) {
                                  return ValidationUtil.validateChequeNumber(
                                    value,
                                  );
                                },
                              ),
                              /* Cheque Number Field */

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
                                  return ValidationUtil.validateIFSC(value);
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

                              /* Add Aadhaar Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshAadhaarImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      placeholderText: "Add Aadhaar Image",
                                      addText: addText,
                                      imagePath: aadhaarImagePath ?? "",
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            // Upload Profile Photo
                                            compressedPhotosAadhaarList = [];
                                            compressedPhotosAadhaarList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosAadhaarList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            aadhaarImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosAadhaarList[0]
                                                  .path,
                                            );

                                            refreshAadhaarImage.value =
                                                !refreshAadhaarImage.value;
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
                              /* Add Aadhaar Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add PAN Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshPanImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: panImagePath ?? "",
                                      placeholderText: "Add PAN Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            // Upload Profile Photo
                                            compressedPhotosPanList = [];
                                            compressedPhotosPanList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosPanList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            panImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosPanList[0].path,
                                            );

                                            refreshPanImage.value =
                                                !refreshPanImage.value;
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
                              /* Add PAN Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Cheque Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshChequeImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: chequeImagePath ?? "",
                                      placeholderText: "Add Cheque Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            // Upload Profile Photo
                                            compressedPhotosChequeList = [];
                                            compressedPhotosChequeList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosChequeList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            chequeImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosChequeList[0]
                                                  .path,
                                            );

                                            refreshChequeImage.value =
                                                !refreshChequeImage.value;
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
                              /* Add Cheque Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add RC Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshRCHOLDERImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: rcHOLDERImagePath ?? "",
                                      placeholderText: "Add RC Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            // Upload Profile Photo
                                            compressedPhotosRCHOLDERList = [];
                                            compressedPhotosRCHOLDERList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosRCHOLDERList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            rcHOLDERImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosRCHOLDERList[0]
                                                  .path,
                                            );

                                            refreshRCHOLDERImage.value =
                                                !refreshRCHOLDERImage.value;
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
                              /* Add RC Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Property Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshPropertyDocImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: propertyDocImagePath ?? "",
                                      placeholderText: "Add Property Doc Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            // Upload Profile Photo
                                            compressedPhotosPropertyDocList =
                                                [];
                                            compressedPhotosPropertyDocList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosPropertyDocList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            propertyDocImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosPropertyDocList[0]
                                                  .path,
                                            );

                                            refreshPropertyDocImage.value =
                                                !refreshPropertyDocImage.value;
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
                              /* Add Property Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Pass Book Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshPassBookImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: passBookImagePath ?? "",
                                      placeholderText:
                                          "Add Bank Pass Book Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            compressedPhotosPassBookList = [];
                                            compressedPhotosPassBookList =
                                                await pickPhotos(
                                              maxImagesCount: 1,
                                              context: context,
                                              compressedPhotosList:
                                                  compressedPhotosPassBookList,
                                              invalidFormatErrorText: "Invalid",
                                            );

                                            passBookImagePath =
                                                await NetworkService()
                                                    .imageUpload(
                                              compressedPhotosPassBookList[0]
                                                  .path,
                                            );

                                            refreshPassBookImage.value =
                                                !refreshPassBookImage.value;
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
                              /* Add Pass Book Doc Image */

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

  Future<void> onSubmitAction() async {
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
    String? aadhaarError =
        ValidationUtil.validateAadhaar(_aadhaarController.text);
    String? panError = ValidationUtil.validatePAN(_panController.text);
    String? rcHolderNameError =
        ValidationUtil.validateRCHolderName(_rcHolderNameController.text);
    String? propertyHolderNameError = ValidationUtil.validatePropertyHolderName(
        _propertyHolderNameController.text);
    String? propertyDetailsError =
        ValidationUtil.validatePropertyDetails(_propertyDetailsController.text);
    String? chequeNumError =
        ValidationUtil.validateChequeNumber(_chequeNumController.text);
    String? bankNameError =
        ValidationUtil.validateBankName(_bankNameController.text);
    String? accNumError =
        ValidationUtil.validateAccountNumber(_accNumController.text);
    String? bankIFSCError =
        ValidationUtil.validateIFSC(_bankIFSCcodeController.text);
    String? bankBranchError =
        ValidationUtil.validateBranchName(_bankBranchController.text);

    String? aadhaarImageError =
        ValidationUtil.validateImage(aadhaarImagePath, 1);
    String? panImageError = ValidationUtil.validateImage(panImagePath, 2);
    String? chequeImageError = ValidationUtil.validateImage(chequeImagePath, 3);
    String? rcImageError = ValidationUtil.validateImage(rcHOLDERImagePath, 4);
    String? propertyImageError =
        ValidationUtil.validateImage(propertyDocImagePath, 5);
    String? passbookImageError =
        ValidationUtil.validateImage(passBookImagePath, 6);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      if (aadhaarImagePath != null &&
          aadhaarImagePath!.isNotEmpty &&
          panImagePath != null &&
          panImagePath!.isNotEmpty &&
          chequeImagePath != null &&
          chequeImagePath!.isNotEmpty &&
          rcHOLDERImagePath != null &&
          rcHOLDERImagePath!.isNotEmpty &&
          propertyDocImagePath != null &&
          propertyDocImagePath!.isNotEmpty &&
          passBookImagePath != null &&
          passBookImagePath!.isNotEmpty) {
        // All validations passed, navigate to the next screen
        var result = await NetworkService().updateKYCDetails(
          userName: _nameController.text,
          mobNum: _phNumController.text,
          altMobNum: _altPhNumController.text,
          emailAddress: _emailController.text,
          streetAddress: _streetAddressController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
          country: _countryController.text,
          aadhaarImage: aadhaarImagePath ?? "",
          panImage: panImagePath ?? "",
          chequeImage: chequeImagePath ?? "",
          panNumber: _panController.text,
          aadhaarNumber: _aadhaarController.text,
          rcHolderName: _rcHolderNameController.text,
          rcImage: rcHOLDERImagePath ?? "",
          houseImage: propertyDocImagePath,
          propertyDetails: _propertyDetailsController.text,
          propertyHolderName: _propertyHolderNameController.text,
          chequeNumber: _chequeNumController.text,
          bankName: _bankNameController.text,
          bankBranchName: _bankBranchController.text,
          bankIFSCCode: _bankIFSCcodeController.text,
          accNumber: _accNumController.text,
          passbookImage: passBookImagePath,
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
          Map<String, dynamic> data = {};
          data = {
            "tab_index": 1,
          };
          Navigator.pushReplacementNamed(
            context,
            RoutingConstants.routeDashboardScreen,
            arguments: {"data": data},
          );
        } else {
          if (!mounted) return;
          ToastUtil().showSnackBar(
            context: context,
            message: result['message'] ?? "Something went wrong",
            isError: true,
          );
        }
      } else if (aadhaarImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: aadhaarImageError,
          isError: true,
        );
      } else if (panImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: panImageError,
          isError: true,
        );
      } else if (chequeImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: chequeImageError,
          isError: true,
        );
      } else if (rcImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: rcImageError,
          isError: true,
        );
      } else if (propertyImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: propertyImageError,
          isError: true,
        );
      } else if (passbookImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: passbookImageError,
          isError: true,
        );
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
      } else if (aadhaarError != null) {
        _showErrorAndFocus(_aadhaarFocusNode, aadhaarError);
      } else if (panError != null) {
        _showErrorAndFocus(_panFocusNode, panError);
      } else if (rcHolderNameError != null) {
        _showErrorAndFocus(_rcHolderNameFocusNode, rcHolderNameError);
      } else if (propertyHolderNameError != null) {
        _showErrorAndFocus(
            _propertyHolderNameFocusNode, propertyHolderNameError);
      } else if (propertyDetailsError != null) {
        _showErrorAndFocus(_propertyDetailsFocusNode, propertyDetailsError);
      } else if (chequeNumError != null) {
        _showErrorAndFocus(_chequeNumFocusNode, chequeNumError);
      } else if (bankNameError != null) {
        _showErrorAndFocus(_bankNameFocusNode, bankNameError);
      } else if (accNumError != null) {
        _showErrorAndFocus(_bankAccNumFocusNode, accNumError);
      } else if (bankIFSCError != null) {
        _showErrorAndFocus(_bankIFSCCodeFocusNode, bankIFSCError);
      } else if (bankBranchError != null) {
        _showErrorAndFocus(_bankBranchFocusNode, bankBranchError);
      } else if (aadhaarImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: aadhaarImageError,
          isError: true,
        );
      } else if (panImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: panImageError,
          isError: true,
        );
      } else if (chequeImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: chequeImageError,
          isError: true,
        );
      } else if (rcImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: rcImageError,
          isError: true,
        );
      } else if (propertyImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: propertyImageError,
          isError: true,
        );
      } else if (passbookImageError != null) {
        ToastUtil().showSnackBar(
          context: context,
          message: passbookImageError,
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
}
