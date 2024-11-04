import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class UpdateCustomersPaymentDetailsScreen extends StatefulWidget {
  final String? title;
  const UpdateCustomersPaymentDetailsScreen({super.key, this.title});

  @override
  State<UpdateCustomersPaymentDetailsScreen> createState() =>
      _UpdateCustomersPaymentDetailsScreenState();
}

class _UpdateCustomersPaymentDetailsScreenState
    extends State<UpdateCustomersPaymentDetailsScreen> {
  /* JSON Text */
  String? internetAlert = "";
  /* JSON Text */

  String updatePaymentDetailsText = "";
  String updateText = "";

  String nameText = "";
  String namePlaceHolderText = "";
  String phNumText = "";
  String phNumPlaceholderText = "";
  String loanCodeText = "";
  String loanCodePlaceholderText = "";
  String agentCodeText = "";
  String agentCodePlaceholderText = "";
  String amtPaidText = "";
  String amtPaidPlaceholderText = "";
  String paymentDateText = "";
  String paymentDatePlaceholderText = "";
  String amtDueText = "";
  String amtDuePlaceholderText = "";
  String paymentTypeText = "";
  String paymentTypePlaceholderText = "";
  String paymentModeText = "";
  String paymentModePlaceholderText = "";
  String paymentStatusText = "";
  String paymentStatusPlaceholderText = "";

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _loanCodeController = TextEditingController();
  final TextEditingController _agentCodeController = TextEditingController();
  final TextEditingController _amtPaidCodeController = TextEditingController();
  final TextEditingController _amtDueCodeController = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _loanCodeFocusNode = FocusNode();
  final FocusNode _agentCodeFocusNode = FocusNode();
  final FocusNode _amtPaidFocusNode = FocusNode();
  final FocusNode _amtDueFocusNode = FocusNode();
  final FocusNode _dateInputFocusNode = FocusNode();
  final FocusNode _paymentTypeFocusNode = FocusNode();
  final FocusNode _paymentModeFocusNode = FocusNode();
  final FocusNode _paymentStatusFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  String? selectedPaymentTypeIDValue;
  List<Map<String, dynamic>> paymentTypeOptions = [
    {"id": "0", "title": 'Select Payment Type'},
    {"id": "1", "title": 'PIGMY'},
    {"id": "2", "title": 'LOAN'},
    {"id": "3", "title": 'GROUP LOAN'}
  ];

  String? selectedPaymentModeIDValue;
  List<Map<String, dynamic>> paymentModeOptions = [
    {"id": "0", "title": 'Select Payment Mode'},
    {"id": "1", "title": 'CASH'},
    {"id": "2", "title": 'GPAY'},
    {"id": "3", "title": 'PHONE PE'},
    {"id": "4", "title": 'PAYTM'}
  ];

  String? selectedPaymentStatusIDValue;
  List<Map<String, dynamic>> paymentStatusOptions = [
    {"id": "0", "title": 'Select Payment Status'},
    {"id": "1", "title": 'PAID'},
    {"id": "2", "title": 'DUE'},
    {"id": "3", "title": 'FAILED'}
  ];

  @override
  void initState() {
    super.initState();
    getAppContentDet();
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _loanCodeController.addListener(_validateFields);
    _agentCodeController.addListener(_validateFields);
    _amtPaidCodeController.addListener(_validateFields);
    _amtDueCodeController.addListener(_validateFields);
    _dateInput.addListener(_validateFields);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _phNumController.dispose();
    _loanCodeController.dispose();
    _agentCodeController.dispose();
    _amtPaidCodeController.dispose();
    _amtDueCodeController.dispose();
    _dateInput.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _loanCodeFocusNode.dispose();
    _agentCodeFocusNode.dispose();
    _amtPaidFocusNode.dispose();
    _amtDueFocusNode.dispose();
    _paymentTypeFocusNode.dispose();
    _paymentModeFocusNode.dispose();
    _paymentStatusFocusNode.dispose();
    _dateInputFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _loanCodeController.removeListener(_validateFields);
    _agentCodeController.removeListener(_validateFields);
    _amtPaidCodeController.removeListener(_validateFields);
    _amtDueCodeController.removeListener(_validateFields);
    _dateInput.removeListener(_validateFields);

    _scrollController.dispose();
  }

  getAppContentDet() async {
    var appContent = await AppLanguageUtil().getAppContentDetails();
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    updateText =
        appContent['update_customers_payment_details']['update_text'] ?? "";
    nameText =
        appContent['update_customers_payment_details']['name_text'] ?? "";
    namePlaceHolderText = appContent['update_customers_payment_details']
            ['name_placeholder_text'] ??
        "";
    phNumText = appContent['update_customers_payment_details']['ph_text'] ?? "";
    phNumPlaceholderText = appContent['update_customers_payment_details']
            ['ph_placeholder_text'] ??
        "";
    updatePaymentDetailsText = appContent['update_customers_payment_details']
            ['update_payment_details_text'] ??
        "";
    loanCodeText =
        appContent['update_customers_payment_details']['loan_code_text'] ?? "";
    loanCodePlaceholderText = appContent['update_customers_payment_details']
            ['loan_code_placeholder_text'] ??
        "";
    agentCodeText =
        appContent['update_customers_payment_details']['agent_code_text'] ?? "";
    agentCodePlaceholderText = appContent['update_customers_payment_details']
            ['agent_code_placeholder_text'] ??
        "";
    amtPaidText =
        appContent['update_customers_payment_details']['amt_paid_text'] ?? "";
    amtPaidPlaceholderText = appContent['update_customers_payment_details']
            ['amt_paid_placeholder_text'] ??
        "";
    paymentDateText = appContent['update_customers_payment_details']
            ['payment_date_text'] ??
        "";
    paymentDatePlaceholderText = appContent['update_customers_payment_details']
            ['payment_date_placeholder_text'] ??
        "";
    amtDueText =
        appContent['update_customers_payment_details']['amt_due_text'] ?? "";
    amtDuePlaceholderText = appContent['update_customers_payment_details']
            ['amt_due_placeholder_text'] ??
        "";
    paymentTypeText = appContent['update_customers_payment_details']
            ['payment_type_text'] ??
        "";
    paymentTypePlaceholderText = appContent['update_customers_payment_details']
            ['payment_type_placeholder_text'] ??
        "";
    paymentModeText = appContent['update_customers_payment_details']
            ['payment_mode_text'] ??
        "";
    paymentModePlaceholderText = appContent['update_customers_payment_details']
            ['payment_mode_placeholder_text'] ??
        "";
    paymentStatusText = appContent['update_customers_payment_details']
            ['payment_status_text'] ??
        "";
    paymentStatusPlaceholderText =
        appContent['update_customers_payment_details']
                ['payment_status_placeholder_text'] ??
            "";

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
                        widget.title ?? updatePaymentDetailsText,
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
                          isDisabled: isDisabled.value,
                          buttonText: updateText,
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
              ), /* Withdraw Now CTA */
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

                              /* Loan Code Input Field */
                              Text(
                                loanCodeText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _loanCodeFocusNode,
                                suffixWidget: const Icon(
                                  Icons.contacts_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: loanCodePlaceholderText,
                                textEditingController: _loanCodeController,
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
                                  return ValidationUtil.validateCode(value);
                                },
                              ),
                              /* Loan Code Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Agent Code Input Field */
                              Text(
                                agentCodeText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _agentCodeFocusNode,
                                suffixWidget: const Icon(
                                  Icons.contacts_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: agentCodePlaceholderText,
                                textEditingController: _agentCodeController,
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
                                  return ValidationUtil.validateCode(value);
                                },
                              ),
                              /* Agent Code Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Amount Paid Input Field */
                              Text(
                                amtPaidText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _amtPaidFocusNode,
                                suffixWidget: const Icon(
                                  Icons.attach_money_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: amtPaidPlaceholderText,
                                textEditingController: _amtPaidCodeController,
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
                              /* Amount Paid Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Amount Due Input Field */
                              Text(
                                amtDueText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _amtDueFocusNode,
                                suffixWidget: const Icon(
                                  Icons.attach_money_outlined,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: amtDuePlaceholderText,
                                textEditingController: _amtDueCodeController,
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
                              /* Amount Due Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Amount Paid Date Input Field */
                              Text(
                                paymentDateText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextFormField(
                                controller: _dateInput,
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
                                  hintText: paymentDatePlaceholderText,
                                  hintStyle: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                readOnly: true,
                                focusNode: _dateInputFocusNode,
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                ),
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                  );

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(
                                      () {
                                        _dateInput.text =
                                            formattedDate; //set output date to TextField value.
                                      },
                                    );
                                  } else {}
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a payment date';
                                  }
                                  // You can add more complex validation if needed, such as checking date ranges.
                                  return null;
                                },
                              ),
                              /* Amount Paid Date Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Payment Type Input Field */
                              Text(
                                paymentTypeText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                value: selectedPaymentTypeIDValue,
                                focusNode: _paymentTypeFocusNode,
                                hint: Text(
                                  paymentTypePlaceholderText,
                                  style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPaymentTypeIDValue = newValue;
                                  });
                                },
                                onSaved: (String? newValue) {
                                  selectedPaymentTypeIDValue = newValue;
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "0") {
                                    return 'Please choose a valid Payment Type';
                                  }
                                  return null;
                                },
                                items: paymentTypeOptions
                                    .map<DropdownMenuItem<String>>((option) {
                                  return DropdownMenuItem<String>(
                                    value: option[
                                        'id'], // Using the id as the value
                                    child: Text(
                                      option['title'],
                                      style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
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
                                ),
                              ),
                              /* Payment Type Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Payment Mode Input Field */
                              Text(
                                paymentModeText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                value: selectedPaymentModeIDValue,
                                focusNode: _paymentModeFocusNode,
                                hint: Text(
                                  paymentModePlaceholderText,
                                  style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPaymentModeIDValue = newValue;
                                  });
                                },
                                onSaved: (String? newValue) {
                                  selectedPaymentModeIDValue = newValue;
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "0") {
                                    return 'Please choose a valid Payment Mode';
                                  }
                                  return null;
                                },
                                items: paymentModeOptions
                                    .map<DropdownMenuItem<String>>((option) {
                                  return DropdownMenuItem<String>(
                                    value: option[
                                        'id'], // Using the id as the value
                                    child: Text(
                                      option['title'],
                                      style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
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
                                ),
                              ),
                              /* Payment Mode Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Payment Status Input Field */
                              Text(
                                paymentStatusText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                value: selectedPaymentStatusIDValue,
                                focusNode: _paymentStatusFocusNode,
                                hint: Text(
                                  paymentStatusPlaceholderText,
                                  style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPaymentStatusIDValue = newValue;
                                  });
                                },
                                onSaved: (String? newValue) {
                                  selectedPaymentStatusIDValue = newValue;
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == "0") {
                                    return 'Please choose a valid Payment Status';
                                  }
                                  return null;
                                },
                                items: paymentStatusOptions
                                    .map<DropdownMenuItem<String>>((option) {
                                  return DropdownMenuItem<String>(
                                    value: option[
                                        'id'], // Using the id as the value
                                    child: Text(
                                      option['title'],
                                      style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
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
                                ),
                              ),
                              /* Payment Status Input Field */

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

  void onSubmitAction() {
    // Validation checks
    String? nameError = ValidationUtil.validateName(_nameController.text);
    String? mobileError =
        ValidationUtil.validateMobileNumber(_phNumController.text);
    String? loanCodeError =
        ValidationUtil.validateCode(_loanCodeController.text);
    String? agentCodeError =
        ValidationUtil.validateCode(_agentCodeController.text);
    String? amtPaidError =
        ValidationUtil.validateCode(_amtPaidCodeController.text);
    String? amtDueError =
        ValidationUtil.validateCode(_amtDueCodeController.text);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      // All validations passed, navigate to the next screen
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
      // Check for individual errors and focus accordingly
      if (nameError != null) {
        _showErrorAndFocus(_nameFocusNode, nameError);
      } else if (mobileError != null) {
        _showErrorAndFocus(_phNumFocusNode, mobileError);
      } else if (loanCodeError != null) {
        _showErrorAndFocus(_loanCodeFocusNode, loanCodeError);
      } else if (agentCodeError != null) {
        _showErrorAndFocus(_agentCodeFocusNode, agentCodeError);
      } else if (amtPaidError != null) {
        _showErrorAndFocus(_amtPaidFocusNode, amtPaidError);
      } else if (amtDueError != null) {
        _showErrorAndFocus(_amtDueFocusNode, amtDueError);
      } else if (_dateInput.text.isEmpty) {
        _showErrorAndFocus(_dateInputFocusNode, "Please select Payment Date");
      } else if (selectedPaymentTypeIDValue == null ||
          selectedPaymentTypeIDValue!.isEmpty ||
          selectedPaymentTypeIDValue == "0") {
        _showErrorAndFocus(
            _paymentTypeFocusNode, "Please select vaild Payment Type");
      } else if (selectedPaymentModeIDValue == null ||
          selectedPaymentModeIDValue!.isEmpty ||
          selectedPaymentModeIDValue == "0") {
        _showErrorAndFocus(
            _paymentModeFocusNode, "Please select vaild Payment Mode");
      } else if (selectedPaymentStatusIDValue == null ||
          selectedPaymentStatusIDValue!.isEmpty ||
          selectedPaymentStatusIDValue == "0") {
        _showErrorAndFocus(
            _paymentStatusFocusNode, "Please select vaild Payment Status");
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