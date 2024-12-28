import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/loading_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/alert_model.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // Progress indicator
  final loadingController = StreamController<bool>.broadcast();
  Stream<bool> get loadingStream => loadingController.stream;
  void setIsLoading(bool loading) => loadingController.add(loading);

  /* JSON Text */
  String internetAlert = "";
  String logoutSubTitle = "";
  String btnText = "";
  String cancelText = "";

  String createAccText = "";
  String createAccTitleText = "";
  String createAccSubTitleText = "";
  String nameText = "";
  String namePlaceHolderText = "";
  String signUpText = "";
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
  /* JSON Text */

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _streetAddressFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _zipFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
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
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
    _streetAddressController.addListener(_validateFields);
    _cityController.addListener(_validateFields);
    _stateController.addListener(_validateFields);
    _zipController.addListener(_validateFields);
    _countryController.addListener(_validateFields);
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
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _countryController.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _confirmPasswordController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);

    _scrollController.dispose();
    loadingController.close();
  }

  backAction() {
    // popupAlertDialog(
    //   internetAlert: internetAlert,
    //   context: context,
    //   titleText: logoutSubTitle,
    //   subTitleText: "",
    //   imagePath: ImageConstants.exitImage,
    //   secondaryButtonText: cancelText,
    //   primaryButtonText: btnText,
    //   onSecondaryButtonTap: () {
    //     Navigator.pop(context);
    //   },
    //   onPrimaryButtonTap: () {
    //     exit(0);
    //     // (Platform.isIOS)
    //     //     ?
    //     //     // force exit in ios
    //     //     FlutterExitApp.exitApp(iosForceExit: true)
    //     //     :
    //     //     // call this to exit app
    //     //     FlutterExitApp.exitApp();
    //   },
    // );
    Navigator.pushReplacementNamed(
      context,
      RoutingConstants.routeLoginScreen,
    );
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    logoutSubTitle = appContent['logout']['exit_subtitle_text'] ?? "";
    btnText = appContent['logout']['exit_text'] ?? "";
    cancelText = appContent['logout']['cancel_text'] ?? "";
    createAccText = appContent['create_account']['create_acc_text'] ?? "";
    createAccTitleText = appContent['create_account']['create_acc_title'] ?? "";
    createAccSubTitleText =
        appContent['create_account']['create_acc_subtitle'] ?? "";
    nameText = appContent['create_account']['name_text'] ?? "";
    namePlaceHolderText =
        appContent['create_account']['name_placeholder_text'] ?? "";
    phNumText = appContent['create_account']['ph_text'] ?? "";
    phNumPlaceholderText =
        appContent['create_account']['ph_placeholder_text'] ?? "";
    pswdText = appContent['create_account']['pswd_text'] ?? "";
    pswdPlaceholderText =
        appContent['create_account']['pswd_placeholder_text'] ?? "";
    signUpText = appContent['create_account']['sign_up_text'] ?? "";
    confirmPassordText =
        appContent['create_account']['confirm_pswd_text'] ?? "";
    emailText = appContent['create_account']['email_text'] ?? "";
    emailPlaceholderText =
        appContent['create_account']['email_placeholder_text'] ?? "";
    streetAddressText =
        appContent['create_account']['street_address_text'] ?? "";
    cityText = appContent['create_account']['city_text'] ?? "";
    stateText = appContent['create_account']['state_text'] ?? "";
    zipText = appContent['create_account']['zip_text'] ?? "";
    countryText = appContent['create_account']['country_text'] ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        backAction();
        return Future<bool>.value(false);
      },
      child: SafeArea(
        child: StreamBuilder<bool>(
            stream: loadingStream.asBroadcastStream(),
            initialData: false,
            builder: (context, snapshot) {
              final isLoading = snapshot.data;
              return ModalProgressHUD(
                progressIndicator: LoadingUtil.ballRotate(context),
                dismissible: false,
                inAsyncCall: isLoading ?? false,
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
                              createAccText,
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
                    // resizeToAvoidBottomInset:
                    //     false, // Ensure the bottom navigation bar remains visible
                    // floatingActionButtonLocation:
                    //     FloatingActionButtonLocation.centerDocked,
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
                                buttonText: signUpText,
                                onButtonTap: () => onSignup(),
                                context: context,
                                internetAlert: internetAlert,
                                borderradius: 8.sp,
                                toastError: () => onSignup(),
                              );
                            }),
                      ), /* SIGN IN CTA */
                    ),
                    body: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          Image.asset(
                            ImageConstants.createAccImage,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 6.sp,
                                ),
                                Text(
                                  createAccTitleText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.sp,
                                ),
                                Text(
                                  createAccSubTitleText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorConstants.lightBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          return ValidationUtil.validateName(
                                              value);
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
                                          FilteringTextInputFormatter
                                              .digitsOnly,
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
                                          return ValidationUtil
                                              .validateMobileNumber(value);
                                        },
                                      ),
                                      /* Mobile Number Input Field */

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
                                        textcapitalization:
                                            TextCapitalization.none,
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
                                        keyboardtype:
                                            TextInputType.emailAddress,
                                        validationFunc: (value) {
                                          return ValidationUtil
                                              .validateEmailAddress(value);
                                        },
                                      ),
                                      /* Email Address Input Field */

                                      SizedBox(
                                        height: 16.sp,
                                      ),

                                      /* Password Input Field */
                                      Text(
                                        pswdText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorConstants.lightBlackColor,
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

                                      /* Confirm Password Input Field */
                                      Text(
                                        confirmPassordText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorConstants.lightBlackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextInputField(
                                        focusnodes: _confirmPasswordFocusNode,
                                        suffixWidget: const Icon(
                                          Icons.lock,
                                          color: ColorConstants.darkBlueColor,
                                        ),
                                        placeholderText: pswdPlaceholderText,
                                        textEditingController:
                                            _confirmPasswordController,
                                        obscureTextVal: true,
                                        inputFormattersList: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s")),
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r"\s\s")),
                                          FilteringTextInputFormatter.deny(RegExp(
                                              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                                        ],
                                        validationFunc: (value) {
                                          return ValidationUtil
                                              .confirmPasswordValidation(
                                            value,
                                            _passwordController.text,
                                          );
                                        },
                                      ),
                                      /* Confirm Password Input Field */

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
                                        textEditingController:
                                            _streetAddressController,
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
                                          return ValidationUtil
                                              .validateLocation(value, 1);
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
                                          return ValidationUtil
                                              .validateLocation(value, 3);
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
                                          return ValidationUtil
                                              .validateLocation(value, 2);
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
                                          FilteringTextInputFormatter
                                              .digitsOnly,
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
                                          return ValidationUtil.validatePinCode(
                                              value);
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
                                        textEditingController:
                                            _countryController,
                                        validationFunc: (value) {
                                          return ValidationUtil
                                              .validateLocation(value, 4);
                                        },
                                      ),
                                      /* Country Input Field */
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
              );
            }),
      ),
    );
  }

  Future<void> onSignup() async {
    // Validation checks
    String? nameError = ValidationUtil.validateName(_nameController.text);
    String? mobileError =
        ValidationUtil.validateMobileNumber(_phNumController.text);
    String? emailError =
        ValidationUtil.validateEmailAddress(_emailController.text);
    String? passwordError =
        ValidationUtil.validatePassword(_passwordController.text);
    String? confirmPasswordError = ValidationUtil.confirmPasswordValidation(
        _confirmPasswordController.text, _passwordController.text);
    String? streetAddressError =
        ValidationUtil.validateLocation(_streetAddressController.text, 1);
    String? cityError =
        ValidationUtil.validateLocation(_cityController.text, 3);
    String? stateError =
        ValidationUtil.validateLocation(_stateController.text, 2);
    String? zipError = ValidationUtil.validatePinCode(_zipController.text);
    String? countryError =
        ValidationUtil.validateLocation(_countryController.text, 4);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      setIsLoading(true);
      isDisabled.value = false;
      var result = await NetworkService().signUpService(
        name: _nameController.text,
        primaryPhone: _phNumController.text,
        email: _emailController.text,
        password: _passwordController.text,
        address: _streetAddressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zip: _zipController.text,
        country: _countryController.text,
      );
      if (result != null &&
          result['status'] != null &&
          result['status'] == true &&
          result['message'] != null &&
          result['message'].isNotEmpty) {
        if (!mounted) return;
        ToastUtil().showSnackBar(
          context: context,
          message: result['message'] ?? "",
        );
        Future.delayed(const Duration(seconds: 1)).then((value) =>
            // All validations passed, navigate to the next screen
            Navigator.pushReplacementNamed(
                context, RoutingConstants.routeLoginScreen));
        setIsLoading(false);
      } else if (result != null &&
          result['status'] != null &&
          result['status'] == false &&
          result['message'] != null &&
          result['message'].isNotEmpty) {
        setIsLoading(false);
        if (!mounted) return;
        ToastUtil().showSnackBar(
          context: context,
          message: result['message'] ?? "",
          isError: true,
        );
      }
    } else {
      // Check for individual errors and focus accordingly
      if (nameError != null) {
        _showErrorAndFocus(_nameFocusNode, nameError);
      } else if (mobileError != null) {
        _showErrorAndFocus(_phNumFocusNode, mobileError);
      } else if (emailError != null) {
        _showErrorAndFocus(_emailFocusNode, emailError);
      } else if (passwordError != null) {
        _showErrorAndFocus(_passwordFocusNode, passwordError);
      } else if (confirmPasswordError != null) {
        _showErrorAndFocus(_confirmPasswordFocusNode, confirmPasswordError);
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

        // Show the error message using a Snackbar
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(error),
        //     duration: const Duration(seconds: 2),
        //     backgroundColor: ColorConstants.redColor,
        //   ),
        // );

        ToastUtil().showSnackBar(
          context: context,
          message: error,
          isError: true,
        );
      },
    );
  }
}
