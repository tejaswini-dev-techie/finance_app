import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/WithdrawPigmySavings/bloc/withdraw_pigmy_savings_bloc.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:sizer/sizer.dart';

class WithdrawPigmySavings extends StatefulWidget {
  const WithdrawPigmySavings({super.key});

  @override
  State<WithdrawPigmySavings> createState() => _WithdrawPigmySavingsState();
}

class _WithdrawPigmySavingsState extends State<WithdrawPigmySavings> {
  final WithdrawPigmySavingsBloc withdrawPigmySavingsBloc =
      WithdrawPigmySavingsBloc();

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
  final TextEditingController _withdrawAmountController =
      TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
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
  final FocusNode _withdrawAmountFocusNode = FocusNode();
  final FocusNode _reasonFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    withdrawPigmySavingsBloc.add(WithdrawPigmySavingsDetailsEvent());
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _altPhNumController.addListener(_validateFields);
    _streetAddressController.addListener(_validateFields);
    _cityController.addListener(_validateFields);
    _stateController.addListener(_validateFields);
    _zipController.addListener(_validateFields);
    _countryController.addListener(_validateFields);
    _withdrawAmountController.addListener(_validateFields);
    _reasonController.addListener(_validateFields);
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
    _withdrawAmountController.dispose();
    _reasonController.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();
    _withdrawAmountFocusNode.dispose();
    _reasonFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);
    _withdrawAmountController.removeListener(_validateFields);
    _reasonController.removeListener(_validateFields);

    _scrollController.dispose();
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
        child: BlocBuilder<WithdrawPigmySavingsBloc, WithdrawPigmySavingsState>(
          bloc: withdrawPigmySavingsBloc,
          builder: (context, state) {
            if (state is WithdrawPigmySavingsLoading) {
              return Scaffold(
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
                            withdrawPigmySavingsBloc.withdrawPigmySavingsText,
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
                body: const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.darkBlueColor,
                  ),
                ),
              );
            } else if (state is WithdrawPigmySavingsLoaded) {
              _nameController.text =
                  withdrawPigmySavingsBloc.userData?.name ?? "";
              _phNumController.text =
                  withdrawPigmySavingsBloc.userData?.mobNum ?? "";
              _altPhNumController.text =
                  withdrawPigmySavingsBloc.userData?.altMobNum ?? "";
              _emailController.text =
                  withdrawPigmySavingsBloc.userData?.emailAddress ?? "";
              _streetAddressController.text =
                  withdrawPigmySavingsBloc.userData?.streetAddress ?? "";
              _cityController.text =
                  withdrawPigmySavingsBloc.userData?.city ?? "";
              _stateController.text =
                  withdrawPigmySavingsBloc.userData?.state ?? "";
              _zipController.text =
                  withdrawPigmySavingsBloc.userData?.pincode ?? "";
              _countryController.text =
                  withdrawPigmySavingsBloc.userData?.country ?? "";
              return GestureDetector(
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
                              withdrawPigmySavingsBloc.withdrawPigmySavingsText,
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
                                buttonText:
                                    withdrawPigmySavingsBloc.withdrawNowText,
                                onButtonTap: () => onWithdrawNowAction(),
                                context: context,
                                internetAlert:
                                    withdrawPigmySavingsBloc.internetAlert,
                                borderradius: 8.sp,
                                toastError: () => onWithdrawNowAction(),
                              );
                            },
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          Center(
                            child: Text(
                              withdrawPigmySavingsBloc.footerText,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ColorConstants.lightBlackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ), /* Withdraw Now CTA */
                  ),
                  body: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                withdrawPigmySavingsBloc
                                    .withdrawPigmySavingsTitle,
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
                                withdrawPigmySavingsBloc
                                    .withdrawPigmySavingsSubtitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 3.sp,
                              ),
                              Text(
                                withdrawPigmySavingsBloc.userData?.balance ??
                                    "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w700,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /* Name Input Field*/
                                    Text(
                                      withdrawPigmySavingsBloc.nameText,
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
                                      placeholderText: withdrawPigmySavingsBloc
                                          .namePlaceHolderText,
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
                                      withdrawPigmySavingsBloc.phNumText,
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
                                      placeholderText: withdrawPigmySavingsBloc
                                          .phNumPlaceholderText,
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
                                        return ValidationUtil
                                            .validateMobileNumber(value);
                                      },
                                    ),
                                    /* Mobile Number Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Alternate Mobile Number Input Field */
                                    Text(
                                      withdrawPigmySavingsBloc.altPhNumText,
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
                                      placeholderText: withdrawPigmySavingsBloc
                                          .phNumPlaceholderText,
                                      textEditingController:
                                          _altPhNumController,
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
                                        return ValidationUtil
                                            .validateAltMobileNumber(
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
                                      withdrawPigmySavingsBloc.emailText,
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
                                      placeholderText: withdrawPigmySavingsBloc
                                          .emailPlaceholderText,
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
                                        return ValidationUtil
                                            .validateEmailAddress(value);
                                      },
                                    ),
                                    /* Email Address Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* Street Address Input Field*/
                                    // Text(
                                    //   withdrawPigmySavingsBloc
                                    //       .streetAddressText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   focusnodes: _streetAddressFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.location_on,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText: withdrawPigmySavingsBloc
                                    //       .streetAddressText,
                                    //   textEditingController:
                                    //       _streetAddressController,
                                    //   inputFormattersList: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(r"\s\s"),
                                    //     ),
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(
                                    //           r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                    //     ),
                                    //   ],
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil.validateLocation(
                                    //         value, 1);
                                    //   },
                                    // ),
                                    // /* Street Address Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* City Input Field*/
                                    // Text(
                                    //   withdrawPigmySavingsBloc.cityText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   focusnodes: _cityFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.location_on,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText:
                                    //       withdrawPigmySavingsBloc.cityText,
                                    //   textEditingController: _cityController,
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil.validateLocation(
                                    //         value, 3);
                                    //   },
                                    // ),
                                    // /* City Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* State Input Field*/
                                    // Text(
                                    //   withdrawPigmySavingsBloc.stateText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   focusnodes: _stateFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.location_on,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText:
                                    //       withdrawPigmySavingsBloc.stateText,
                                    //   textEditingController: _stateController,
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil.validateLocation(
                                    //         value, 2);
                                    //   },
                                    // ),
                                    // /* State Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* Pincode Input Field */
                                    // Text(
                                    //   withdrawPigmySavingsBloc.zipText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   focusnodes: _zipFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.location_on,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText:
                                    //       withdrawPigmySavingsBloc.zipText,
                                    //   textEditingController: _zipController,
                                    //   inputFormattersList: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.digitsOnly,
                                    //     LengthLimitingTextInputFormatter(6),
                                    //     FilteringTextInputFormatter.allow(
                                    //       RegExp(r'^[0-9]*$'),
                                    //     ),
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(r"\s\s"),
                                    //     ),
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(
                                    //           r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                    //     ),
                                    //   ],
                                    //   keyboardtype: TextInputType.number,
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil.validatePinCode(
                                    //         value);
                                    //   },
                                    // ),
                                    // /* Pincode Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* Country Input Field*/
                                    // Text(
                                    //   withdrawPigmySavingsBloc.countryText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   focusnodes: _countryFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.location_on,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText:
                                    //       withdrawPigmySavingsBloc.countryText,
                                    //   textEditingController: _countryController,
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil.validateLocation(
                                    //         value, 4);
                                    //   },
                                    // ),
                                    // /* Country Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Withdraw Amount Input Field */
                                    Text(
                                      withdrawPigmySavingsBloc.withdrawAmtText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      focusnodes: _withdrawAmountFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.attach_money_outlined,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: withdrawPigmySavingsBloc
                                          .withdrawAmtPlaceholderText,
                                      textEditingController:
                                          _withdrawAmountController,
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
                                        return ValidationUtil
                                            .validateWithdrawAmount(
                                          value,
                                          balAmt: withdrawPigmySavingsBloc
                                                  .userData?.balanceAmt ??
                                              "0",
                                        );
                                      },
                                    ),
                                    /* Withdraw Amount Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Withdraw Reason Input Field */
                                    Text(
                                      withdrawPigmySavingsBloc.reasonText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      focusnodes: _reasonFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.textsms,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: withdrawPigmySavingsBloc
                                          .reasonPlaceholderText,
                                      textEditingController: _reasonController,
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
                                            .validateWithdrawReason(
                                          value,
                                        );
                                      },
                                    ),
                                    /* Withdraw Reason Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Note Text */
                                    Text(
                                      withdrawPigmySavingsBloc.noteText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.sp,
                                    ),
                                    Text(
                                      withdrawPigmySavingsBloc.noteDescText,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    /* Note Text */

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
              );
            } else if (state is WithdrawPigmySavingsNoInternet) {
              return Scaffold(
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
                          withdrawPigmySavingsBloc.withdrawPigmySavingsText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorConstants.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 25.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                body: noInternetWidget(
                  context: context,
                  retryAction: () => withdrawPigmySavingsBloc
                      .add(WithdrawPigmySavingsDetailsEvent()),
                  state: 1,
                ),
              );
            } else {
              return Scaffold(
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
                          withdrawPigmySavingsBloc.withdrawPigmySavingsText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorConstants.blackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 25.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                body: noInternetWidget(
                  context: context,
                  retryAction: () => withdrawPigmySavingsBloc
                      .add(WithdrawPigmySavingsDetailsEvent()),
                  state: 2,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> onWithdrawNowAction() async {
    // Validation checks
    String? nameError = ValidationUtil.validateName(_nameController.text);
    String? mobileError =
        ValidationUtil.validateMobileNumber(_phNumController.text);
    String? emailError =
        ValidationUtil.validateEmailAddress(_emailController.text);
    String? altMobileError = ValidationUtil.validateAltMobileNumber(
        _altPhNumController.text, _phNumController.text);
    // String? streetAddressError =
    //     ValidationUtil.validateLocation(_streetAddressController.text, 1);
    // String? cityError =
    //     ValidationUtil.validateLocation(_cityController.text, 3);
    // String? stateError =
    //     ValidationUtil.validateLocation(_stateController.text, 2);
    // String? zipError = ValidationUtil.validatePinCode(_zipController.text);
    // String? countryError =
    //     ValidationUtil.validateLocation(_countryController.text, 4);
    String? withdrawAmountError = ValidationUtil.validateWithdrawAmount(
      _withdrawAmountController.text,
      balAmt: withdrawPigmySavingsBloc.userData?.balanceAmt ?? "0",
    );
    String? withdrawReasonError =
        ValidationUtil.validateWithdrawReason(_reasonController.text);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      // All validations passed, navigate to the next screen
      var result = await NetworkService().withdrawPIGMYDetailsUpdate(
        userName: _nameController.text,
        mobNum: _phNumController.text,
        altMobNum: _altPhNumController.text,
        emailAddress: _emailController.text,
        // streetAddress: _streetAddressController.text,
        // city: _cityController.text,
        // state: _stateController.text,
        // zipCode: _zipController.text,
        // country: _countryController.text,
        withdrawalAmount: _withdrawAmountController.text,
        reason: _reasonController.text,
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
      }
      // else if (streetAddressError != null) {
      //   _showErrorAndFocus(_streetAddressFocusNode, streetAddressError);
      // } else if (cityError != null) {
      //   _showErrorAndFocus(_cityFocusNode, cityError);
      // } else if (stateError != null) {
      //   _showErrorAndFocus(_stateFocusNode, stateError);
      // } else if (zipError != null) {
      //   _showErrorAndFocus(_zipFocusNode, zipError);
      // } else if (countryError != null) {
      //   _showErrorAndFocus(_countryFocusNode, countryError);
      // }
      else if (withdrawAmountError != null) {
        _showErrorAndFocus(_withdrawAmountFocusNode, withdrawAmountError);
      } else if (withdrawReasonError != null) {
        _showErrorAndFocus(_reasonFocusNode, withdrawReasonError);
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
