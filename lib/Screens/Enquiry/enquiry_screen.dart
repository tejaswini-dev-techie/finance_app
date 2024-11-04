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

class EnquiryScreen extends StatefulWidget {
  final String? title;
  const EnquiryScreen({
    super.key,
    this.title,
  });

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  String internetAlert = "";
  String enquiryText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String altPhNumText = "";
  String callBackText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String emailText = "";
  String emailPlaceholderText = "";
  String streetAddressText = "";
  String cityText = "";
  String stateText = "";
  String zipText = "";
  String countryText = "";
  String loanAmount = "";
  String loanAmountPlaceholderText = "";

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
  final TextEditingController _loanAmountController = TextEditingController();
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
  final FocusNode _loanAmountFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

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
    _loanAmountController.addListener(_validateFields);
  }

  void _validateFields() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
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
    _loanAmountController.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();
    _loanAmountFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);
    _loanAmountController.removeListener(_validateFields);

    _scrollController.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    enquiryText = appContent['enquiry']['enquiry_text'] ?? "";
    nameText = appContent['enquiry']['name_text'] ?? "";
    namePlaceHolderText = appContent['enquiry']['name_placeholder_text'] ?? "";
    phNumText = appContent['enquiry']['ph_text'] ?? "";
    phNumPlaceholderText = appContent['enquiry']['ph_placeholder_text'] ?? "";
    altPhNumText = appContent['enquiry']['alt_ph_text'] ?? "";
    callBackText = appContent['enquiry']['call_back_text'] ?? "";
    emailText = appContent['enquiry']['email_text'] ?? "";
    emailPlaceholderText =
        appContent['enquiry']['email_placeholder_text'] ?? "";
    streetAddressText = appContent['enquiry']['street_address_text'] ?? "";
    cityText = appContent['enquiry']['city_text'] ?? "";
    stateText = appContent['enquiry']['state_text'] ?? "";
    zipText = appContent['enquiry']['zip_text'] ?? "";
    countryText = appContent['enquiry']['country_text'] ?? "";
    loanAmount = appContent['enquiry']['loan_amt_text'] ?? "";
    loanAmountPlaceholderText =
        appContent['enquiry']['loan_amt_placeholder_text'] ?? "";
    setState(() {});
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
                    const Spacer(),
                    Text(
                      (widget.title != null && widget.title!.isNotEmpty)
                          ? widget.title ?? ""
                          : enquiryText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorConstants.blackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 25.sp,
                    )
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
                        buttonText: callBackText,
                        onButtonTap: () => onReqCallBackAction(),
                        context: context,
                        internetAlert: internetAlert,
                        borderradius: 8.sp,
                        toastError: () => onReqCallBackAction(),
                      );
                    }),
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
                                      value, _phNumController.text);
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
                              /* Mobile Number Input Field */

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

                              /* Laon Amount Input Field */
                              Text(
                                loanAmount,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _loanAmountFocusNode,
                                suffixWidget: const Icon(
                                  Icons.attach_money_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: loanAmountPlaceholderText,
                                textEditingController: _loanAmountController,
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
                                  return ValidationUtil.validateLoanAmount(
                                    value,
                                  );
                                },
                              ),
                              /* Loan Amount Input Field */

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

  Future<void> onReqCallBackAction() async {
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
    String? loanError =
        ValidationUtil.validateLoanAmount(_loanAmountController.text);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      // All validations passed, navigate to the next screen
      var result = await NetworkService().updateEnquiryDetails(
        userName: _nameController.text,
        mobNum: _phNumController.text,
        altMobNum: _altPhNumController.text,
        emailAddress: _emailController.text,
        streetAddress: _streetAddressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
        country: _countryController.text,
        loanAmount: _loanAmountController.text,
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
          "tab_index": 2,
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
      } else if (loanError != null) {
        _showErrorAndFocus(_loanAmountFocusNode, loanError);
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
