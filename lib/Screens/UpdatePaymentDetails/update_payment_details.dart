import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/UpdatePaymentDetails/bloc/update_payment_details_bloc.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class UpdateCustomersPaymentDetailsScreen extends StatefulWidget {
  final String? title;
  final String? customerID;
  final String? type;
  const UpdateCustomersPaymentDetailsScreen({
    super.key,
    this.title,
    this.customerID,
    this.type,
  });

  @override
  State<UpdateCustomersPaymentDetailsScreen> createState() =>
      _UpdateCustomersPaymentDetailsScreenState();
}

class _UpdateCustomersPaymentDetailsScreenState
    extends State<UpdateCustomersPaymentDetailsScreen> {
  final UpdatePaymentDetailsBloc updatePaymentDetailsBloc =
      UpdatePaymentDetailsBloc();

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _loanCodeController = TextEditingController();
  final TextEditingController _agentCodeController = TextEditingController();
  final TextEditingController _amtPaidCodeController = TextEditingController();
  // final TextEditingController _amtDueCodeController = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();

  final TextEditingController _dateCollectionInput = TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _loanCodeFocusNode = FocusNode();
  final FocusNode _agentCodeFocusNode = FocusNode();
  final FocusNode _amtPaidFocusNode = FocusNode();
  final FocusNode _amtDueFocusNode = FocusNode();
  final FocusNode _dateInputFocusNode = FocusNode();
  final FocusNode _dateCollectionFocusNode = FocusNode();
  final FocusNode _paymentModeFocusNode = FocusNode();
  final FocusNode _paymentStatusFocusNode = FocusNode();
  final FocusNode _amtPaidBYStatusFocusNode = FocusNode();

  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);
  ValueNotifier<bool> refreshDateCollectionInputFields =
      ValueNotifier<bool>(false);

  ValueNotifier<bool> refreshPaymentModeInputFields =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> refreshPaymentStatusInputFields =
      ValueNotifier<bool>(false);
  ValueNotifier<bool> refreshAmtStatusInputFields = ValueNotifier<bool>(false);

  // String? selectedPaymentTypeIDValue;
  // List<Map<String, dynamic>> paymentTypeOptions = [
  //   {"id": "0", "title": 'Select Payment Type'},
  //   {"id": "1", "title": 'PIGMY'},
  //   {"id": "2", "title": 'LOAN'},
  //   {"id": "3", "title": 'GROUP LOAN'},
  //   {"id": "4", "title": 'GROUP PIGMY'}
  // ];

  String? selectedPaymentModeIDValue;
  List<Map<String, dynamic>> paymentModeOptions = [
    {"id": "0", "title": 'Select Payment Mode'},
    {"id": "1", "title": 'CASH'},
    {"id": "2", "title": 'GPAY'},
    {"id": "3", "title": 'PHONE PE'},
    {"id": "4", "title": 'PAYTM'}
  ];

  // String? selectedPaymentStatusIDValue;
  // List<Map<String, dynamic>> paymentStatusOptions = [
  //   {"id": "0", "title": 'Select Payment Status'},
  //   {"id": "1", "title": 'PAID'},
  //   {"id": "2", "title": 'DUE'},
  //   {"id": "3", "title": 'FAILED'}
  // ];

  String? selectedAmtPaidByModeIDValue;
  /* 1 - Weekly & Daily | 2 - Monthly */
  List<Map<String, dynamic>> amtModeOptions1 = [
    {"id": "0", "title": 'Select Amount to be Paid By'},
    {"id": "1", "title": 'EMI'},
    {"id": "2", "title": 'PENALTY'},
  ];
  List<Map<String, dynamic>> amtModeOptions2 = [
    {"id": "0", "title": 'Select Amount to be Paid By'},
    {"id": "1", "title": 'EMI'},
    {"id": "3", "title": 'INTEREST'},
  ];
  /* 1 - Weekly & Daily | 2 - Monthly */

  @override
  void initState() {
    super.initState();
    updatePaymentDetailsBloc.add(GetPaymentDetailsEvent(
      cusID: widget.customerID,
      type: widget.type,
    ));
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _loanCodeController.addListener(_validateFields);
    _agentCodeController.addListener(_validateFields);
    _amtPaidCodeController.addListener(_validateFields);
    // _amtDueCodeController.addListener(_validateFields);
    _dateInput.addListener(_validateFields);

    _dateCollectionInput.addListener(_validateFields);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _phNumController.dispose();
    _loanCodeController.dispose();
    _agentCodeController.dispose();
    _amtPaidCodeController.dispose();
    // _amtDueCodeController.dispose();
    _dateInput.dispose();

    _dateCollectionInput.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _loanCodeFocusNode.dispose();
    _agentCodeFocusNode.dispose();
    _amtPaidFocusNode.dispose();
    _amtDueFocusNode.dispose();
    _dateCollectionFocusNode.dispose();
    _paymentModeFocusNode.dispose();
    _paymentStatusFocusNode.dispose();
    _dateInputFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _loanCodeController.removeListener(_validateFields);
    _agentCodeController.removeListener(_validateFields);
    _amtPaidCodeController.removeListener(_validateFields);
    // _amtDueCodeController.removeListener(_validateFields);
    _dateInput.removeListener(_validateFields);

    _dateCollectionInput.removeListener(_validateFields);

    _scrollController.dispose();
    updatePaymentDetailsBloc.close();
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
                        widget.title ??
                            updatePaymentDetailsBloc.updatePaymentDetailsText,
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
                          buttonText: updatePaymentDetailsBloc.updateText,
                          onButtonTap: () => onSubmitAction(),
                          context: context,
                          internetAlert: updatePaymentDetailsBloc.internetAlert,
                          borderradius: 8.sp,
                          toastError: () => onSubmitAction(),
                        );
                      },
                    ),
                  ],
                ),
              ), /* Withdraw Now CTA */
            ),
            body: BlocBuilder<UpdatePaymentDetailsBloc,
                UpdatePaymentDetailsState>(
              bloc: updatePaymentDetailsBloc,
              builder: (context, state) {
                if (state is UpdatePaymentDetailsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkBlueColor,
                    ),
                  );
                } else if (state is UpdatePaymentDetailsLoaded) {
                  _nameController.text =
                      updatePaymentDetailsBloc.userData?.name ?? "";
                  _phNumController.text =
                      updatePaymentDetailsBloc.userData?.mobNum ?? "";
                  _loanCodeController.text =
                      updatePaymentDetailsBloc.userData?.codeId ?? "";
                  _agentCodeController.text =
                      updatePaymentDetailsBloc.userData?.agent ?? "";
                  _amtPaidCodeController.text =
                      updatePaymentDetailsBloc.userData?.amtToBePaid ?? "";
                  // _amtDueCodeController.text =
                  //     updatePaymentDetailsBloc.userData?.due ?? "";
                  _dateInput.text =
                      updatePaymentDetailsBloc.userData?.date ?? "";
                  _dateCollectionInput.text =
                      DateFormat('dd/MM/yyyy').format(DateTime.now());

                  /* 1 - Weekly & Daily | 2 - Monthly */
                  if (updatePaymentDetailsBloc.userData?.type != null &&
                      updatePaymentDetailsBloc.userData?.type == "1") {
                    if (updatePaymentDetailsBloc.userData?.amtToBePaidBy ==
                            null ||
                        updatePaymentDetailsBloc
                            .userData!.amtToBePaidBy!.isEmpty) {
                      // Set the corresponding ID for 'EMI'
                      selectedAmtPaidByModeIDValue = amtModeOptions1.firstWhere(
                              (option) => option['title'] == 'EMI')['id']
                          as String?;
                      refreshAmtStatusInputFields.value =
                          !refreshAmtStatusInputFields.value;
                    } else {
                      // Find the corresponding ID for the userData value
                      selectedAmtPaidByModeIDValue = amtModeOptions1.firstWhere(
                          (option) =>
                              option['title'] ==
                              updatePaymentDetailsBloc.userData?.amtToBePaidBy,
                          orElse: () => {"id": "0"})['id'] as String?;
                      refreshAmtStatusInputFields.value =
                          !refreshAmtStatusInputFields.value;
                    }
                  } else {
                    if (updatePaymentDetailsBloc.userData?.amtToBePaidBy ==
                            null ||
                        updatePaymentDetailsBloc
                            .userData!.amtToBePaidBy!.isEmpty) {
                      // Set the corresponding ID for 'EMI'
                      selectedAmtPaidByModeIDValue = amtModeOptions2.firstWhere(
                              (option) => option['title'] == 'EMI')['id']
                          as String?;
                      refreshAmtStatusInputFields.value =
                          !refreshAmtStatusInputFields.value;
                    } else {
                      // Find the corresponding ID for the userData value
                      selectedAmtPaidByModeIDValue = amtModeOptions2.firstWhere(
                          (option) =>
                              option['title'] ==
                              updatePaymentDetailsBloc.userData?.amtToBePaidBy,
                          orElse: () => {"id": "0"})['id'] as String?;
                      refreshAmtStatusInputFields.value =
                          !refreshAmtStatusInputFields.value;
                    }
                  }
                  /* 1 - Weekly & Daily | 2 - Monthly */

                  return SingleChildScrollView(
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
                                    /* Name Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.nameText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue: updatePaymentDetailsBloc
                                              .userData?.isReadonlyName ??
                                          false,
                                      focusnodes: _nameFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.person_pin_circle_rounded,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: updatePaymentDetailsBloc
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
                                      updatePaymentDetailsBloc.phNumText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue: updatePaymentDetailsBloc
                                              .userData?.isReadonlyMobNum ??
                                          false,
                                      focusnodes: _phNumFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.phone_locked,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: updatePaymentDetailsBloc
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

                                    /* Loan Code Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.loanCodeText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue: updatePaymentDetailsBloc
                                              .userData?.isReadonlyLoanCode ??
                                          false,
                                      focusnodes: _loanCodeFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.contacts_rounded,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: updatePaymentDetailsBloc
                                          .loanCodePlaceholderText,
                                      textEditingController:
                                          _loanCodeController,
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
                                        return ValidationUtil.validateCode(
                                            value);
                                      },
                                    ),
                                    /* Loan Code Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Agent Code Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.agentCodeText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue: updatePaymentDetailsBloc
                                              .userData?.isReadonlyAgentCode ??
                                          false,
                                      focusnodes: _agentCodeFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.contacts_rounded,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: updatePaymentDetailsBloc
                                          .agentCodePlaceholderText,
                                      textEditingController:
                                          _agentCodeController,
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
                                        return ValidationUtil.validateCode(
                                            value);
                                      },
                                    ),
                                    /* Agent Code Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Amount Paid Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.amtPaidText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue: updatePaymentDetailsBloc
                                              .userData?.isReadonlyAmtPaid ??
                                          false,
                                      focusnodes: _amtPaidFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.attach_money_outlined,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: updatePaymentDetailsBloc
                                          .amtPaidPlaceholderText,
                                      textEditingController:
                                          _amtPaidCodeController,
                                      // inputFormattersList: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      //   LengthLimitingTextInputFormatter(15),
                                      //   FilteringTextInputFormatter.allow(
                                      //     RegExp(r'^[1-9][0-9]*$'),
                                      //   ),
                                      //   FilteringTextInputFormatter.deny(
                                      //     RegExp(r"\s\s"),
                                      //   ),
                                      //   FilteringTextInputFormatter.deny(
                                      //     RegExp(
                                      //         r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                      //   ),
                                      // ],
                                      inputFormattersList: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                          RegExp(
                                              r'^\d*\.?\d*$'), // Allows digits and one optional decimal point
                                        ),
                                        LengthLimitingTextInputFormatter(
                                            15), // Limits input length to 15 characters
                                        FilteringTextInputFormatter.deny(
                                          RegExp(
                                              r"\s\s"), // Denies consecutive spaces
                                        ),
                                        FilteringTextInputFormatter.deny(
                                          RegExp(
                                            r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])', // Denies specific Unicode symbols (e.g., emojis)
                                          ),
                                        ),
                                      ],

                                      keyboardtype: TextInputType.number,
                                      validationFunc: (value) {
                                        return ValidationUtil
                                            .validateDepositAmount(value);
                                      },
                                    ),
                                    /* Amount Paid Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    // /* Amount Due Input Field */
                                    // Text(
                                    //   updatePaymentDetailsBloc.amtDueText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // TextInputField(
                                    //   readOnlyValue: updatePaymentDetailsBloc
                                    //           .userData?.isReadonlyAmtDue ??
                                    //       false,
                                    //   focusnodes: _amtDueFocusNode,
                                    //   suffixWidget: const Icon(
                                    //     Icons.attach_money_outlined,
                                    //     color: ColorConstants.darkBlueColor,
                                    //   ),
                                    //   placeholderText: updatePaymentDetailsBloc
                                    //       .amtDuePlaceholderText,
                                    //   textEditingController:
                                    //       _amtDueCodeController,
                                    //   // inputFormattersList: <TextInputFormatter>[
                                    //   //   FilteringTextInputFormatter.digitsOnly,
                                    //   //   LengthLimitingTextInputFormatter(15),
                                    //   //   FilteringTextInputFormatter.allow(
                                    //   //     RegExp(r'^[1-9][0-9]*$'),
                                    //   //   ),
                                    //   //   FilteringTextInputFormatter.deny(
                                    //   //     RegExp(r"\s\s"),
                                    //   //   ),
                                    //   //   FilteringTextInputFormatter.deny(
                                    //   //     RegExp(
                                    //   //         r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                    //   //   ),
                                    //   // ],
                                    //   inputFormattersList: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.allow(
                                    //       RegExp(
                                    //           r'^\d*\.?\d*$'), // Allows digits and one optional decimal point
                                    //     ),
                                    //     LengthLimitingTextInputFormatter(
                                    //         15), // Limits input length to 15 characters
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(
                                    //           r"\s\s"), // Denies consecutive spaces
                                    //     ),
                                    //     FilteringTextInputFormatter.deny(
                                    //       RegExp(
                                    //         r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])', // Denies specific Unicode symbols (e.g., emojis)
                                    //       ),
                                    //     ),
                                    //   ],

                                    //   keyboardtype: TextInputType.number,
                                    //   validationFunc: (value) {
                                    //     return ValidationUtil
                                    //         .validateDepositAmount(value);
                                    //   },
                                    // ),
                                    // /* Amount Due Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    /* Amount Paid Date Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.paymentDateText,
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
                                        hintText: updatePaymentDetailsBloc
                                            .paymentDatePlaceholderText,
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
                                        // DateTime? pickedDate =
                                        //     await showDatePicker(
                                        //   context: context,
                                        //   initialDate: DateTime.now(),
                                        //   firstDate: DateTime(2010),
                                        //   //DateTime.now() - not to allow to choose before today.
                                        //   lastDate: DateTime.now(),
                                        // );

                                        // if (pickedDate != null) {
                                        //   //pickedDate output format => 2021-03-10 00:00:00.000
                                        //   String formattedDate =
                                        //       DateFormat('dd/MM/yyyy')
                                        //           .format(pickedDate);
                                        //   //formatted date output using intl package =>  2021-03-16
                                        //   setState(
                                        //     () {
                                        //       _dateInput.text =
                                        //           formattedDate; //set output date to TextField value.
                                        //     },
                                        //   );
                                        // }
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

                                    // /* Payment Type Input Field */
                                    // Text(
                                    //   updatePaymentDetailsBloc.paymentTypeText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // DropdownButtonFormField<String>(
                                    //   value: selectedPaymentTypeIDValue,
                                    //   focusNode: _paymentTypeFocusNode,
                                    //   hint: Text(
                                    //     updatePaymentDetailsBloc
                                    //         .paymentTypePlaceholderText,
                                    //     style: TextStyle(
                                    //       color: ColorConstants.blackColor,
                                    //       fontWeight: FontWeight.w400,
                                    //       fontStyle: FontStyle.normal,
                                    //       fontSize: 10.sp,
                                    //     ),
                                    //   ),
                                    //   onChanged: (String? newValue) {
                                    //     setState(() {
                                    //       selectedPaymentTypeIDValue = newValue;
                                    //     });
                                    //   },
                                    //   onSaved: (String? newValue) {
                                    //     selectedPaymentTypeIDValue = newValue;
                                    //   },
                                    //   validator: (String? value) {
                                    //     if (value == null ||
                                    //         value.isEmpty ||
                                    //         value == "0") {
                                    //       return 'Please choose a valid Payment Type';
                                    //     }
                                    //     return null;
                                    //   },
                                    //   items: paymentTypeOptions
                                    //       .map<DropdownMenuItem<String>>(
                                    //           (option) {
                                    //     return DropdownMenuItem<String>(
                                    //       value: option[
                                    //           'id'], // Using the id as the value
                                    //       child: Text(
                                    //         option['title'],
                                    //         style: TextStyle(
                                    //           color: ColorConstants.blackColor,
                                    //           fontWeight: FontWeight.w600,
                                    //           fontStyle: FontStyle.normal,
                                    //           fontSize: 10.sp,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   }).toList(),
                                    //   decoration: InputDecoration(
                                    //     errorStyle: TextStyle(
                                    //       color: ColorConstants.redColor,
                                    //       fontWeight: FontWeight.w400,
                                    //       fontStyle: FontStyle.normal,
                                    //       fontSize: 10.sp,
                                    //     ),
                                    //     filled: true,
                                    //     fillColor: ColorConstants.whiteColor,
                                    //     focusedBorder: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //         color: ColorConstants
                                    //             .lightShadeBlueColor,
                                    //       ),
                                    //     ),
                                    //     disabledBorder: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //         color: ColorConstants
                                    //             .lightShadeBlueColor,
                                    //       ),
                                    //     ),
                                    //     enabledBorder: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //         color: ColorConstants
                                    //             .lightShadeBlueColor,
                                    //       ),
                                    //     ),
                                    //     border: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //       ),
                                    //     ),
                                    //     errorBorder: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //         color: ColorConstants.redColor,
                                    //       ),
                                    //     ),
                                    //     focusedErrorBorder: OutlineInputBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(8.sp)),
                                    //       borderSide: BorderSide(
                                    //         width: 1.sp,
                                    //         color: ColorConstants.redColor,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // /* Payment Type Input Field */

                                    /* Payment Collection Date */
                                    Text(
                                      "Payment Collection Date",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable:
                                            refreshDateCollectionInputFields,
                                        builder: (context, val, _) {
                                          return TextFormField(
                                            controller: _dateCollectionInput,
                                            decoration: InputDecoration(
                                              suffixIcon: const Icon(
                                                Icons.calendar_month,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              errorStyle: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.sp)),
                                                borderSide: BorderSide(
                                                  width: 1.sp,
                                                  color: ColorConstants
                                                      .lightShadeBlueColor,
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                                  color:
                                                      ColorConstants.redColor,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.sp)),
                                                borderSide: BorderSide(
                                                  width: 1.sp,
                                                  color:
                                                      ColorConstants.redColor,
                                                ),
                                              ),
                                              hintText: "Select a date",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                            readOnly:
                                                false, // Prevent manual text input
                                            focusNode: _dateCollectionFocusNode,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10.sp,
                                            ),
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2010),
                                                lastDate: DateTime.now(),
                                              );

                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(pickedDate);

                                                _dateCollectionInput.text =
                                                    formattedDate;
                                                refreshDateCollectionInputFields
                                                        .value =
                                                    !refreshDateCollectionInputFields
                                                        .value;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select a payment collection date';
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                    /* Payment Collection Date */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Payment Mode Input Field */
                                    Text(
                                      updatePaymentDetailsBloc.paymentModeText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable:
                                            refreshPaymentModeInputFields,
                                        builder: (context, vals, _) {
                                          return DropdownButtonFormField<
                                              String>(
                                            value: selectedPaymentModeIDValue,
                                            focusNode: _paymentModeFocusNode,
                                            hint: Text(
                                              updatePaymentDetailsBloc
                                                  .paymentModePlaceholderText,
                                              style: TextStyle(
                                                color:
                                                    ColorConstants.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                            onChanged: (String? newValue) {
                                              selectedPaymentModeIDValue =
                                                  newValue;
                                              refreshPaymentModeInputFields
                                                      .value =
                                                  !refreshPaymentModeInputFields
                                                      .value;
                                            },
                                            onSaved: (String? newValue) {
                                              selectedPaymentModeIDValue =
                                                  newValue;
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
                                                .map<DropdownMenuItem<String>>(
                                                    (option) {
                                              return DropdownMenuItem<String>(
                                                value: option[
                                                    'id'], // Using the id as the value
                                                child: Text(
                                                  option['title'],
                                                  style: TextStyle(
                                                    color: ColorConstants
                                                        .blackColor,
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
                                              fillColor:
                                                  ColorConstants.whiteColor,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.sp)),
                                                borderSide: BorderSide(
                                                  width: 1.sp,
                                                  color: ColorConstants
                                                      .lightShadeBlueColor,
                                                ),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                                  color:
                                                      ColorConstants.redColor,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.sp)),
                                                borderSide: BorderSide(
                                                  width: 1.sp,
                                                  color:
                                                      ColorConstants.redColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    /* Payment Mode Input Field */

                                    // SizedBox(
                                    //   height: 16.sp,
                                    // ),

                                    // /* Payment Status Input Field */
                                    // Text(
                                    //   updatePaymentDetailsBloc
                                    //       .paymentStatusText,
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //     fontSize: 10.sp,
                                    //     color: ColorConstants.lightBlackColor,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                    // ValueListenableBuilder(
                                    //     valueListenable:
                                    //         refreshPaymentStatusInputFields,
                                    //     builder: (context, vals, _) {
                                    //       return DropdownButtonFormField<
                                    //           String>(
                                    //         value: selectedPaymentStatusIDValue,
                                    //         focusNode: _paymentStatusFocusNode,
                                    //         hint: Text(
                                    //           updatePaymentDetailsBloc
                                    //               .paymentStatusPlaceholderText,
                                    //           style: TextStyle(
                                    //             color:
                                    //                 ColorConstants.blackColor,
                                    //             fontWeight: FontWeight.w400,
                                    //             fontStyle: FontStyle.normal,
                                    //             fontSize: 10.sp,
                                    //           ),
                                    //         ),
                                    //         onChanged: (String? newValue) {
                                    //           selectedPaymentStatusIDValue =
                                    //               newValue;
                                    //           refreshPaymentStatusInputFields
                                    //                   .value =
                                    //               !refreshPaymentStatusInputFields
                                    //                   .value;
                                    //         },
                                    //         onSaved: (String? newValue) {
                                    //           selectedPaymentStatusIDValue =
                                    //               newValue;
                                    //         },
                                    //         validator: (String? value) {
                                    //           if (value == null ||
                                    //               value.isEmpty ||
                                    //               value == "0") {
                                    //             return 'Please choose a valid Payment Status';
                                    //           }
                                    //           return null;
                                    //         },
                                    //         items: paymentStatusOptions
                                    //             .map<DropdownMenuItem<String>>(
                                    //                 (option) {
                                    //           return DropdownMenuItem<String>(
                                    //             value: option[
                                    //                 'id'], // Using the id as the value
                                    //             child: Text(
                                    //               option['title'],
                                    //               style: TextStyle(
                                    //                 color: ColorConstants
                                    //                     .blackColor,
                                    //                 fontWeight: FontWeight.w600,
                                    //                 fontStyle: FontStyle.normal,
                                    //                 fontSize: 10.sp,
                                    //               ),
                                    //             ),
                                    //           );
                                    //         }).toList(),
                                    //         decoration: InputDecoration(
                                    //           errorStyle: TextStyle(
                                    //             color: ColorConstants.redColor,
                                    //             fontWeight: FontWeight.w400,
                                    //             fontStyle: FontStyle.normal,
                                    //             fontSize: 10.sp,
                                    //           ),
                                    //           filled: true,
                                    //           fillColor:
                                    //               ColorConstants.whiteColor,
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //               color: ColorConstants
                                    //                   .lightShadeBlueColor,
                                    //             ),
                                    //           ),
                                    //           disabledBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //               color: ColorConstants
                                    //                   .lightShadeBlueColor,
                                    //             ),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //               color: ColorConstants
                                    //                   .lightShadeBlueColor,
                                    //             ),
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //             ),
                                    //           ),
                                    //           errorBorder: OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //               color:
                                    //                   ColorConstants.redColor,
                                    //             ),
                                    //           ),
                                    //           focusedErrorBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(8.sp)),
                                    //             borderSide: BorderSide(
                                    //               width: 1.sp,
                                    //               color:
                                    //                   ColorConstants.redColor,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     }),
                                    // /* Payment Status Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Amount To be Paid Input Field */
                                    (updatePaymentDetailsBloc.userData
                                                    ?.showAmtToPaidBy !=
                                                null &&
                                            updatePaymentDetailsBloc.userData
                                                    ?.showAmtToPaidBy ==
                                                true)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                updatePaymentDetailsBloc
                                                    .amtTobePaidText,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              (updatePaymentDetailsBloc
                                                              .userData?.type !=
                                                          null &&
                                                      updatePaymentDetailsBloc
                                                              .userData?.type ==
                                                          "1")
                                                  ? ValueListenableBuilder(
                                                      valueListenable:
                                                          refreshAmtStatusInputFields,
                                                      builder:
                                                          (context, vals, _) {
                                                        return DropdownButtonFormField<
                                                            String>(
                                                          value:
                                                              selectedAmtPaidByModeIDValue,
                                                          focusNode:
                                                              _amtPaidBYStatusFocusNode,
                                                          hint: Text(
                                                            updatePaymentDetailsBloc
                                                                .amtTobePaidPlaceholderText,
                                                            style: TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                          onChanged: (String?
                                                              newValue) {
                                                            selectedAmtPaidByModeIDValue =
                                                                newValue;
                                                            refreshAmtStatusInputFields
                                                                    .value =
                                                                !refreshAmtStatusInputFields
                                                                    .value;
                                                            updatePaymentDetailsBloc
                                                                .add(
                                                                    GetPaymentDetailsEvent(
                                                              cusID: widget
                                                                  .customerID,
                                                              type: widget.type,
                                                              amtType:
                                                                  selectedAmtPaidByModeIDValue,
                                                              showLoader: true,
                                                            ));
                                                          },
                                                          onSaved: (String?
                                                              newValue) {
                                                            selectedAmtPaidByModeIDValue =
                                                                newValue;
                                                          },
                                                          validator:
                                                              (String? value) {
                                                            if (value == null ||
                                                                value.isEmpty ||
                                                                value == "0") {
                                                              return 'Please choose a valid Amount to be Paid by Status';
                                                            }
                                                            return null;
                                                          },
                                                          items: amtModeOptions1.map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (option) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: option[
                                                                  'id'], // Using the id as the value
                                                              child: Text(
                                                                option['title'],
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorConstants
                                                                      .blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      10.sp,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .redColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 10.sp,
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .whiteColor,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            disabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color:
                                                                    ColorConstants
                                                                        .redColor,
                                                              ),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color:
                                                                    ColorConstants
                                                                        .redColor,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                  : ValueListenableBuilder(
                                                      valueListenable:
                                                          refreshAmtStatusInputFields,
                                                      builder:
                                                          (context, vals, _) {
                                                        return DropdownButtonFormField<
                                                            String>(
                                                          value:
                                                              selectedAmtPaidByModeIDValue,
                                                          focusNode:
                                                              _amtPaidBYStatusFocusNode,
                                                          hint: Text(
                                                            updatePaymentDetailsBloc
                                                                .amtTobePaidPlaceholderText,
                                                            style: TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                          onChanged: (String?
                                                              newValue) {
                                                            selectedAmtPaidByModeIDValue =
                                                                newValue;
                                                            refreshAmtStatusInputFields
                                                                    .value =
                                                                !refreshAmtStatusInputFields
                                                                    .value;
                                                            updatePaymentDetailsBloc
                                                                .add(
                                                                    GetPaymentDetailsEvent(
                                                              cusID: widget
                                                                  .customerID,
                                                              type: widget.type,
                                                              amtType:
                                                                  selectedAmtPaidByModeIDValue,
                                                              showLoader: true,
                                                            ));
                                                          },
                                                          onSaved: (String?
                                                              newValue) {
                                                            selectedAmtPaidByModeIDValue =
                                                                newValue;
                                                          },
                                                          validator:
                                                              (String? value) {
                                                            if (value == null ||
                                                                value.isEmpty ||
                                                                value == "0") {
                                                              return 'Please choose a valid Amount to be Paid by Status';
                                                            }
                                                            return null;
                                                          },
                                                          items: amtModeOptions2.map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                              (option) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: option[
                                                                  'id'], // Using the id as the value
                                                              child: Text(
                                                                option['title'],
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorConstants
                                                                      .blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      10.sp,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          decoration:
                                                              InputDecoration(
                                                            errorStyle:
                                                                TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .redColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 10.sp,
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .whiteColor,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            disabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color: ColorConstants
                                                                    .lightShadeBlueColor,
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                              ),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color:
                                                                    ColorConstants
                                                                        .redColor,
                                                              ),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8.sp)),
                                                              borderSide:
                                                                  BorderSide(
                                                                width: 1.sp,
                                                                color:
                                                                    ColorConstants
                                                                        .redColor,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                    /* Amount To be Paid Input Field */

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
                  );
                } else if (state is UpdatePaymentDetailsNoInternet) {
                  return noInternetWidget(
                    context: context,
                    retryAction: () =>
                        updatePaymentDetailsBloc.add(GetPaymentDetailsEvent(
                      cusID: widget.customerID,
                      type: widget.type,
                    )),
                    state: 1,
                  );
                } else {
                  return noInternetWidget(
                    context: context,
                    retryAction: () =>
                        updatePaymentDetailsBloc.add(GetPaymentDetailsEvent(
                      cusID: widget.customerID,
                      type: widget.type,
                    )),
                    state: 2,
                  );
                }
              },
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
    String? loanCodeError =
        ValidationUtil.validateCode(_loanCodeController.text);
    String? agentCodeError =
        ValidationUtil.validateCode(_agentCodeController.text);
    String? amtPaidError =
        ValidationUtil.validateCode(_amtPaidCodeController.text);
    // String? amtDueError =
    //     ValidationUtil.validateCode(_amtDueCodeController.text);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      var result = await NetworkService().updatePaymentDetails(
        id: widget.customerID,
        type: widget.type,
        userName: _nameController.text,
        mobNum: _phNumController.text,
        code: _loanCodeController.text,
        agent: _agentCodeController.text,
        amtPaid: _amtPaidCodeController.text,
        // amtDue: _amtDueCodeController.text,
        date: _dateInput.text,
        paymentCollectionDate: _dateCollectionInput.text,
        paymentMode: selectedPaymentModeIDValue,
        // paymentStatus: selectedPaymentStatusIDValue,
        amountType: selectedAmtPaidByModeIDValue,
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
      } 
      // else if (amtDueError != null) {
      //   _showErrorAndFocus(_amtDueFocusNode, amtDueError);
      // } 
      else if (_dateInput.text.isEmpty) {
        _showErrorAndFocus(_dateInputFocusNode, "Please select Payment Date");
      } else if (_dateCollectionInput.text.isEmpty) {
        _showErrorAndFocus(
            _dateCollectionFocusNode, "Please select Payment Collection Date");
      } else if (selectedPaymentModeIDValue == null ||
          selectedPaymentModeIDValue!.isEmpty ||
          selectedPaymentModeIDValue == "0") {
        _showErrorAndFocus(
            _paymentModeFocusNode, "Please select vaild Payment Mode");
      }
      // else if (selectedPaymentStatusIDValue == null ||
      //     selectedPaymentStatusIDValue!.isEmpty ||
      //     selectedPaymentStatusIDValue == "0") {
      //   _showErrorAndFocus(
      //       _paymentStatusFocusNode, "Please select vaild Payment Status");
      // }
      else if ((updatePaymentDetailsBloc.userData?.showAmtToPaidBy != null &&
              updatePaymentDetailsBloc.userData?.showAmtToPaidBy == true) &&
          (selectedAmtPaidByModeIDValue == null ||
              selectedAmtPaidByModeIDValue!.isEmpty ||
              selectedAmtPaidByModeIDValue == "0")) {
        _showErrorAndFocus(
            _amtPaidBYStatusFocusNode, "Please select vaild Payment Status");
      }
      // else if (amtTypeError != null) {
      //   _showErrorAndFocus(_amtToBePaidFocusNode, amtTypeError);
      // }
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
