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

class GroupCreationScreen extends StatefulWidget {
  const GroupCreationScreen({super.key});

  @override
  State<GroupCreationScreen> createState() => _GroupCreationScreenState();
}

class _GroupCreationScreenState extends State<GroupCreationScreen> {
  String? internetAlert = "Please check your internet connection!!!";
  String? groupCreationText = "Group Creation";

  String? groupNameText = "Group Name";
  String? groupPlaceholderText = "Group Name";
  String? groupLeaderNameText = "Group Leader";
  String? groupLeaderNamePlaceholderText = "Name";
  String? groupLeaderPhText = "Mobile Number";
  String? groupLeaderPhPlaceholderText = "Mobile Number";
  String? loanAmtText = "Loan Amount";
  String? loanAmtPlaceholderText = "100000";
  String? loanTenureText = "Loan Tenure";
  String? loanTenurePlaceholderText = "10 Years";
  String? frequencyText = "Loan Frequency";
  String? frequencyPlaceholderText = "30 Days";
  String? saveText = "Save";

  List<String> frequencyOptions = [
    "Select your PIGMY Frequency",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  ValueNotifier<String?> selectedValue = ValueNotifier<String>("Monthly");

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupLeaderNameController =
      TextEditingController();
  final TextEditingController _groupLeaderPhNumController =
      TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _loanTenureController = TextEditingController();
  // final TextEditingController _frequencyController = TextEditingController();

  /* Focus Node */
  final FocusNode _groupNameFocusNode = FocusNode();
  final FocusNode _groupLeaderNameFocusNode = FocusNode();
  final FocusNode _groupLeaderPhNumFocusNode = FocusNode();
  final FocusNode _loanAmtFocusNode = FocusNode();
  final FocusNode _loanTenureFocusNode = FocusNode();
  final FocusNode _frequencyFocusNode = FocusNode();
  /* Focus Node */

  @override
  void initState() {
    super.initState();
    _groupNameController.addListener(_validateFields);
    _groupLeaderNameController.addListener(_validateFields);
    _groupLeaderPhNumController.addListener(_validateFields);
    _loanAmountController.addListener(_validateFields);
    _loanTenureController.addListener(_validateFields);
    // _frequencyController.addListener(_validateFields);
  }

  @override
  void dispose() {
    super.dispose();
    refreshInputFields.dispose();

    _groupNameController.dispose();
    _groupLeaderNameController.dispose();
    _groupLeaderPhNumController.dispose();
    _loanAmountController.dispose();
    _loanTenureController.dispose();
    // _frequencyController.dispose();

    _groupNameFocusNode.dispose();
    _groupLeaderNameFocusNode.dispose();
    _groupLeaderPhNumFocusNode.dispose();
    _loanAmtFocusNode.dispose();
    _loanTenureFocusNode.dispose();
    _frequencyFocusNode.dispose();

    _groupNameController.removeListener(_validateFields);
    _groupLeaderNameController.removeListener(_validateFields);
    _groupLeaderPhNumController.removeListener(_validateFields);
    _loanAmountController.removeListener(_validateFields);
    _loanTenureController.removeListener(_validateFields);
    // _frequencyController.removeListener(_validateFields);
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";

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
                    const Spacer(),
                    Text(
                      groupCreationText ?? "",
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
            bottomNavigationBar:
                /* SAVE CTA */

                SingleChildScrollView(
              child: Container(
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
                        buttonText: saveText ?? "",
                        onButtonTap: () => onSaveAction(),
                        context: context,
                        internetAlert: internetAlert,
                        borderradius: 8.sp,
                        toastError: () => onSaveAction(),
                      );
                    }),
              ),
              /* SAVE CTA */
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 30.sp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /* Group Name Input Field */
                      Text(
                        groupNameText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorConstants.lightBlackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextInputField(
                        focusnodes: _groupNameFocusNode,
                        suffixWidget: const Icon(
                          Icons.person_pin_circle_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: groupPlaceholderText ?? "",
                        textEditingController: _groupNameController,
                        validationFunc: (value) {
                          return ValidationUtil.validateFieldsValue(value);
                        },
                      ),
                      /* Group Name Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),

                      /* Group Leader Name Input Field */
                      Text(
                        groupLeaderNameText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorConstants.lightBlackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextInputField(
                        focusnodes: _groupLeaderNameFocusNode,
                        suffixWidget: const Icon(
                          Icons.person_pin_circle_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: groupLeaderNamePlaceholderText ?? "",
                        textEditingController: _groupLeaderNameController,
                        validationFunc: (value) {
                          return ValidationUtil.validateFieldsValue(value);
                        },
                      ),
                      /* Group Leader Name Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),

                      /* Group Leader Ph Num Input Field */
                      Text(
                        groupLeaderPhText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorConstants.lightBlackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextInputField(
                        focusnodes: _groupLeaderPhNumFocusNode,
                        suffixWidget: const Icon(
                          Icons.person_pin_circle_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: groupLeaderPhPlaceholderText ?? "",
                        textEditingController: _groupLeaderPhNumController,
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
                      /* Group Leader Ph Num Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),

                      /* Loan Amount Input Field */
                      Text(
                        loanAmtText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorConstants.lightBlackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextInputField(
                        focusnodes: _loanAmtFocusNode,
                        suffixWidget: const Icon(
                          Icons.person_pin_circle_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: loanAmtPlaceholderText ?? "",
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
                          return ValidationUtil.validateDepositAmount(value);
                        },
                      ),
                      /* Loan Amount Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),

                      /* Loan Tenure Input Field */
                      Text(
                        loanTenureText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorConstants.lightBlackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextInputField(
                        focusnodes: _loanTenureFocusNode,
                        suffixWidget: const Icon(
                          Icons.person_pin_circle_rounded,
                          color: ColorConstants.darkBlueColor,
                        ),
                        placeholderText: loanTenurePlaceholderText ?? "",
                        textEditingController: _loanTenureController,
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
                          return ValidationUtil.validateTenure(value);
                        },
                      ),
                      /* Loan Tenure Input Field */

                      SizedBox(
                        height: 16.sp,
                      ),

                      /* Frequency Input Field */
                      // Text(
                      //   frequencyText ?? "",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 10.sp,
                      //     color: ColorConstants.lightBlackColor,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // TextInputField(
                      //   focusnodes: _frequencyFocusNode,
                      //   suffixWidget: const Icon(
                      //     Icons.person_pin_circle_rounded,
                      //     color: ColorConstants.darkBlueColor,
                      //   ),
                      //   placeholderText: frequencyPlaceholderText ?? "",
                      //   textEditingController: _frequencyController,
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
                      //     return ValidationUtil.validateFrequency(value);
                      //   },
                      // ),

                      /* Frequency Input Field */
                      Text(
                        frequencyText ?? "",
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
                          String? errorText = ValidationUtil.validateFrequency(
                              selectedValue.value);
                          bool isError = ValidationUtil.validateFrequency(
                                  selectedValue.value) !=
                              null;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (isError)
                                        ? ColorConstants.redColor
                                        : ColorConstants
                                            .lightShadeBlueColor, // Replace with your border color
                                    width:
                                        1.sp, // Adjust the width of the border
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.sp)), // Rounded corners
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0.sp,
                                  vertical: 4.sp,
                                ),
                                child: DropdownButton<String>(
                                  focusNode: _frequencyFocusNode,
                                  value: selectedValue.value,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sp)),
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
                                    frequencyPlaceholderText ?? "",
                                    style: TextStyle(
                                      color: ColorConstants.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  items: frequencyOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorConstants.lightBlackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    selectedValue.value = newValue;
                                    if (_formKey.currentState?.validate() ??
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

  Future<void> onSaveAction() async {
    // Validation checks
    String? grpNameErr =
        ValidationUtil.validateFieldsValue(_groupNameController.text);
    String? grpLeaderNameErr =
        ValidationUtil.validateFieldsValue(_groupLeaderNameController.text);
    String? grpLeaderPhNumErr =
        ValidationUtil.validateMobileNumber(_groupLeaderPhNumController.text);
    String? loanAmtErr =
        ValidationUtil.validateLoanAmount(_loanAmountController.text);
    String? loanTenureErr =
        ValidationUtil.validateTenure(_loanTenureController.text);
    String? frequencyError =
        ValidationUtil.validateFrequency(selectedValue.value);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      if (selectedValue.value != "Select your PIGMY Frequency") {
        isDisabled.value = false;

        var result = await NetworkService().updateGroupCreationDetails(
          groupName: _groupNameController.text,
          groupLeaderName: _groupLeaderNameController.text,
          mobNum: _groupLeaderPhNumController.text,
          loanAmt: _loanAmountController.text,
          loanTenure: _loanTenureController.text,
          frequency: selectedValue.value,
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
              "tab_index": 0,
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
      if (grpNameErr != null) {
        _showErrorAndFocus(_groupNameFocusNode, grpNameErr);
      } else if (grpLeaderNameErr != null) {
        _showErrorAndFocus(_groupLeaderNameFocusNode, grpLeaderNameErr);
      } else if (grpLeaderPhNumErr != null) {
        _showErrorAndFocus(_groupLeaderPhNumFocusNode, grpLeaderPhNumErr);
      } else if (loanAmtErr != null) {
        _showErrorAndFocus(_loanAmtFocusNode, loanAmtErr);
      } else if (loanTenureErr != null) {
        _showErrorAndFocus(_loanTenureFocusNode, loanTenureErr);
      } else if (selectedValue.value == "Select your PIGMY Frequency") {
        ToastUtil().showSnackBar(
          context: context,
          message: frequencyError,
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
}
