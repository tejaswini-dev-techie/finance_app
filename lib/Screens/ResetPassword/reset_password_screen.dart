import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String internetAlert = "";
  String resetPasswordText = "";
  String resetText = "";

  String phNumText = "";
  String phNumPlaceholderText = "";
  String pswdText = "";
  String pswdPlaceholderText = "";
  String confirmPassordText = "";

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    getAppContentDet();
    _phNumController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      isDisabled.value = false; // Enable the button
    } else {
      isDisabled.value = true; // Disable the button
    }
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    resetPasswordText =
        appContent['reset_password']['reset_password_text'] ?? "";
    resetText = appContent['reset_password']['reset_text'] ?? "";
    phNumText = appContent['reset_password']['ph_text'] ?? "";
    phNumPlaceholderText =
        appContent['reset_password']['ph_placeholder_text'] ?? "";
    pswdText = appContent['reset_password']['pswd_text'] ?? "";
    pswdPlaceholderText =
        appContent['reset_password']['pswd_placeholder_text'] ?? "";
    confirmPassordText =
        appContent['reset_password']['confirm_pswd_text'] ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    _phNumController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _phNumFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    _phNumController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _confirmPasswordController.removeListener(_validateFields);

    _scrollController.dispose();
  }

  void backAction() {
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
                      resetPasswordText,
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
              child: /* RESET CTA */
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
                        buttonText: resetText,
                        onButtonTap: () => onResetAction(),
                        context: context,
                        internetAlert: internetAlert,
                        borderradius: 8.sp,
                        toastError: () => onResetAction(),
                      );
                    }),
              ), /* RESET CTA */
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          return ValidationUtil.validateMobileNumber(value);
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
                        focusnodes: _passwordFocusNode,
                        suffixWidget: const Icon(
                          Icons.lock,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: pswdPlaceholderText,
                        textEditingController: _passwordController,
                        obscureTextVal: true,
                        inputFormattersList: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
                          FilteringTextInputFormatter.deny(RegExp(
                              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                        ],
                        validationFunc: (value) {
                          return ValidationUtil.validatePassword(value);
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
                        inputFormattersList: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s\s")),
                          FilteringTextInputFormatter.deny(RegExp(
                              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                        ],
                        textEditingController: _confirmPasswordController,
                        obscureTextVal: true,
                        validationFunc: (value) {
                          return ValidationUtil.confirmPasswordValidation(
                            value,
                            _passwordController.text,
                          );
                        },
                      ),
                      /* Confirm Password Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onResetAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          // Validation checks
          String? mobileError =
              ValidationUtil.validateMobileNumber(_phNumController.text);
          String? passwordError =
              ValidationUtil.validatePassword(_passwordController.text);
          String? confirmPasswordError =
              ValidationUtil.confirmPasswordValidation(
                  _confirmPasswordController.text, _passwordController.text);

          final form = _formKey.currentState;

          if (form?.validate() ?? false) {
            isDisabled.value = false;

            var result = await NetworkService()
                .resetPasswordService(password: _passwordController.text);
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
                Navigator.pushReplacementNamed(
                  context,
                  RoutingConstants.routeLoginScreen,
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
          } else {
            // Check for individual errors and focus accordingly
            if (mobileError != null) {
              _showErrorAndFocus(_phNumFocusNode, mobileError);
            } else if (passwordError != null) {
              _showErrorAndFocus(_passwordFocusNode, passwordError);
            } else if (confirmPasswordError != null) {
              _showErrorAndFocus(
                  _confirmPasswordFocusNode, confirmPasswordError);
            }
          }
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: internetAlert,
            isError: true,
          );
        }
      },
    );
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
