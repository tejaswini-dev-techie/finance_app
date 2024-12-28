import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Constants/sharedpreference_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/loading_util.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/alert_model.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Progress indicator
  final loadingController = StreamController<bool>.broadcast();
  Stream<bool> get loadingStream => loadingController.stream;
  void setIsLoading(bool loading) => loadingController.add(loading);

  /* JSON Text */
  String internetAlert = "";
  String logoutSubTitle = "";
  String btnText = "";
  String cancelText = "";
  String loginText = "";

  String loginTitle = "";
  String loginSubTitle = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String pswdText = "";
  String pswdPlaceholderText = "";
  String signinText = "";
  String signupTitleText = "";
  /* JSON Text */

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  /* TextEditing Controller */

  @override
  void initState() {
    super.initState();
    getAppContentDet();
  }

  @override
  void dispose() {
    super.dispose();
    _phNumController.dispose();
    _passwordController.dispose();
    loadingController.close();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    logoutSubTitle = appContent['logout']['exit_subtitle_text'] ?? "";
    btnText = appContent['logout']['exit_text'] ?? "";
    cancelText = appContent['logout']['cancel_text'] ?? "";
    loginText = appContent['login']['login_text'] ?? "";
    loginTitle = appContent['login']['login_title'] ?? "";
    loginSubTitle = appContent['login']['login_subtitle'] ?? "";
    phNumText = appContent['login']['ph_text'] ?? "";
    phNumPlaceholderText = appContent['login']['ph_placeholder_text'] ?? "";
    pswdText = appContent['login']['pswd_text'] ?? "";
    pswdPlaceholderText = appContent['login']['pswd_placeholder_text'] ?? "";
    signinText = appContent['login']['sign_in_text'] ?? "";
    signupTitleText = appContent['login']['signup_title_text'] ?? "";
    setState(() {});
  }

  backAction() {
    popupAlertDialog(
      internetAlert: internetAlert,
      context: context,
      titleText: logoutSubTitle,
      subTitleText: "",
      imagePath: ImageConstants.exitImage,
      secondaryButtonText: cancelText,
      primaryButtonText: btnText,
      onSecondaryButtonTap: () {
        Navigator.pop(context);
      },
      onPrimaryButtonTap: () {
        exit(0);
        // (Platform.isIOS)
        //     ?
        //     // force exit in ios
        //     FlutterExitApp.exitApp(iosForceExit: true)
        //     :
        //     // call this to exit app
        //     FlutterExitApp.exitApp();
      },
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
                          Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 16.sp,
                            color: ColorConstants.darkBlueColor,
                          ),
                          const Spacer(),
                          Text(
                            loginText,
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
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          ImageConstants.loginImage,
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
                                loginTitle,
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
                                loginSubTitle,
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
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
                                  suffixWidget: const Icon(
                                    Icons.lock,
                                    color: ColorConstants.darkBlueColor,
                                  ),
                                  placeholderText: pswdPlaceholderText,
                                  textEditingController: _passwordController,
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
                                    return ValidationUtil.validatePassword(
                                        value);
                                  },
                                ),
                                /* Password Input Field */

                                /* SIGN IN CTA */
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 16.sp),
                                  child: Column(
                                    children: [
                                      buttonWidgetHelperUtil(
                                        isDisabled: false,
                                        buttonText: signinText,
                                        onButtonTap: () => onSignin(),
                                        context: context,
                                        internetAlert: internetAlert,
                                        borderradius: 8.sp,
                                      ),
                                      SizedBox(
                                        height: 6.sp,
                                      ),
                                      /* SIGN UP Nudge */
                                      InkWell(
                                        onTap: () {
                                          InternetUtil()
                                              .checkInternetConnection()
                                              .then((internet) {
                                            if (internet) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                RoutingConstants
                                                    .routeCreateAccountScreen,
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
                                        child: Text(
                                          signupTitleText,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      /* SIGN UP Nudge */

                                      SizedBox(
                                        height: 8.sp,
                                      ),

                                      /* Forgot Password */
                                      InkWell(
                                        onTap: () {
                                          InternetUtil()
                                              .checkInternetConnection()
                                              .then((internet) {
                                            if (internet) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                RoutingConstants
                                                    .routeResetPasswordScreen,
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
                                        child: Text(
                                          "Forgot Password",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      /* Forgot Password */
                                    ],
                                  ),
                                ),
                                /* SIGN IN CTA */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  onSignin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setIsLoading(true);
      /* Hide Keyboard */
      FocusManager.instance.primaryFocus?.unfocus();
      var result = await NetworkService().signInService(
        primaryPhone: _phNumController.text,
        password: _passwordController.text,
      );
      if (result != null &&
          result['status'] != null &&
          result['status'] == true &&
          result['message'] != null &&
          result['message'].isNotEmpty) {
        SharedPreferencesUtil.addSharedPref(
          SharedPreferenceConstants.prefMobileNumber,
          _phNumController.text,
        );
        if (result['access_token'] != null &&
            result['access_token'].isNotEmpty) {
          SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefSecretKey,
            result['access_token'] ?? "",
          );
        }
        if (result['user_id'] != null && result['user_id'].isNotEmpty) {
          SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefUserID,
            result['user_id'] ?? "",
          );
        }
        if (result['user_type'] != null && result['user_type'].isNotEmpty) {
          SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefUserType,
            result['user_type'] ?? "",
          );
        }
        if (!mounted) return;
        ToastUtil().showSnackBar(
          context: context,
          message: result['message'] ?? "",
        );
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => Navigator.pushReplacementNamed(
            context,
            RoutingConstants.routeDashboardScreen,
          ),
        );
        SharedPreferencesUtil.addSharedPref(
            SharedPreferenceConstants.prefisAlreadyLogin, "1");

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
      } else {
        setIsLoading(false);
        if (!mounted) return;
        ToastUtil().showSnackBar(
          context: context,
          message:
              result['message'] ?? "Something went wrong. Please try again!",
          isError: true,
        );
      }
    } else {
      PrintUtil().printMsg("Validation Failed");
      // ToastUtil().showSnackBar(context: context, message: message)
    }
  }
}
