import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/agents_tab/agents_tab.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/VerfifyCustomers/widgets/add_doc_image_placeholder.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class VerifyCustomersDetailsScreen extends StatefulWidget {
  final String? title;
  final String? id;
  final String?
      type; // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details

  const VerifyCustomersDetailsScreen({
    super.key,
    this.title,
    this.id,
    this.type, // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
  });

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
  String fatherNameText = "Father's Name";
  String fatherNamePlaceHolderText = "Father's Name";
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
  String photoText = "";

  String addText = "CLICK HERE TO ADD";

  List<String> docOptions = [
    "Select Document Type",
    "Property",
    "Vehicle",
    "Personal"
  ];
  ValueNotifier<String?> selectedDocValue =
      ValueNotifier<String>("Select Document Type");

  /* TextEditing Controller */
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _phNumController = TextEditingController();
  final TextEditingController _altPhNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _permanentAddressController =
      TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
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
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _agentNameController = TextEditingController();
  final TextEditingController _referenceNumController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _locationLinkController = TextEditingController();
  final TextEditingController _workLocationLinkController =
      TextEditingController();
  /* TextEditing Controller */

  /* Focus Node */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _fatherNameFocusNode = FocusNode();
  final FocusNode _phNumFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _altPhNumFocusNode = FocusNode();
  final FocusNode _permanentAddressFocusNode = FocusNode();
  final FocusNode _streetAddressFocusNode = FocusNode();
  final FocusNode _landmarkFocusNode = FocusNode();
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
  final FocusNode _referenceFocusNode = FocusNode();
  final FocusNode _agentNameFocusNode = FocusNode();
  final FocusNode _referenceNumFocusNode = FocusNode();
  final FocusNode _reasonFocusNode = FocusNode();
  final FocusNode _docTypeFocusNode = FocusNode();

  final FocusNode _guarantorNameFocusNode = FocusNode();
  final FocusNode _guarantorPhNumFocusNode = FocusNode();
  final FocusNode _guarantorAltPhNumFocusNode = FocusNode();
  final FocusNode _guarantorEmailFocusNode = FocusNode();
  final FocusNode _guarantorAddressFocusNode = FocusNode();
  final FocusNode _guarantorChequeNumFocusNode = FocusNode();
  final FocusNode _guarantorAadhaarNumFocusNode = FocusNode();
  final FocusNode _guarantorPanNumFocusNode = FocusNode();
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  /* Photo Image */
  ValueNotifier<bool> refreshphotoImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosphotoList = [];
  String? photoImagePath = "";
  /* Photo Image */

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
  // ValueNotifier<bool> refreshChequeImage = ValueNotifier<bool>(true);
  // List<File> compressedPhotosChequeList = [];
  // String? chequeImagePath = "";
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

  /* Signature */
  ValueNotifier<bool> refreshSignImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosSignList = [];
  String? signatureImagePath = "";
  /* Signature */

  /* House Image */
  ValueNotifier<bool> refreshHouseImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosHouseList = [];
  String? houseImagePath = "";
  /* House Image */

  /* Building */
  ValueNotifier<bool> refreshBuilding1Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding1List = [];
  String? building1ImagePath = "";
  /* Building */

  /* Building Alternate 1 View */
  ValueNotifier<bool> refreshBuilding2Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding2List = [];
  String? buildingImage2Path = "";
  /* Building Alternate 1 View */

  /* Building Alternate 2 View */
  ValueNotifier<bool> refreshBuilding3Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding3List = [];
  String? building3ImagePath = "";
  /* Building Alternate 2 View */

  /* Building Alternate 3 View */
  ValueNotifier<bool> refreshBuilding4Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding4List = [];
  String? building4ImagePath = "";
  /* Building Alternate 3 View */

  /* Building Alternate 4 View */
  ValueNotifier<bool> refreshBuilding5Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding5List = [];
  String? building5ImagePath = "";
  /* Building Alternate 4 View */

  /* Building Alternate 5 View */
  ValueNotifier<bool> refreshBuilding6Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding6List = [];
  String? building6ImagePath = "";
  /* Building Alternate 5 View */

  /* Building Alternate 6 View */
  ValueNotifier<bool> refreshBuilding7Image = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuilding7List = [];
  String? building7ImagePath = "";
  /* Building Alternate 6 View */

  /* Street */
  ValueNotifier<bool> refreshBuildingStreetImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuildingStreetList = [];
  String? buildingStreetImagePath = "";
  /* Street */

  /* Area View */
  ValueNotifier<bool> refreshBuildingAreaImage = ValueNotifier<bool>(true);
  List<File> compressedPhotosBuildingAreaList = [];
  String? buildingAreaImagePath = "";
  /* Area View */

  /* Same as Permanent Address */
  ValueNotifier<bool> refreshAddress = ValueNotifier<bool>(true);
  bool? sameAsPermanentAddress = false;
  /* Same as Permanent Address */

  /* Verified/Rejected */
  ValueNotifier<bool> refreshCheckbox = ValueNotifier<bool>(true);
  bool? isVerified = false;
  bool? isRejected = false;
  /* Verified/Rejected */

  final TextEditingController _guarantorNameController =
      TextEditingController();
  final TextEditingController _guarantorPhNumController =
      TextEditingController();
  final TextEditingController _guarantorAltPhNumController =
      TextEditingController();
  final TextEditingController _guarantorEmailController =
      TextEditingController();
  final TextEditingController _guarantorAddressController =
      TextEditingController();
  final TextEditingController _guarantorChequeNumController =
      TextEditingController();
  final TextEditingController _guarantorAadhaarNumController =
      TextEditingController();
  final TextEditingController _guarantorPanNumController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getAppContentDet();
    _nameController.addListener(_validateFields);
    _fatherNameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _altPhNumController.addListener(_validateFields);
    _permanentAddressController.addListener(_validateFields);
    _streetAddressController.addListener(_validateFields);
    _landMarkController.addListener(_validateFields);
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
    _referenceController.addListener(_validateFields);
    _referenceNumController.addListener(_validateFields);
    _reasonController.addListener(_validateFields);
    _agentNameController.addListener(_validateFields);
    _guarantorNameController.addListener(_validateFields);
    _guarantorPhNumController.addListener(_validateFields);
    _guarantorAltPhNumController.addListener(_validateFields);
    _guarantorEmailController.addListener(_validateFields);
    _guarantorAddressController.addListener(_validateFields);
    _guarantorChequeNumController.addListener(_validateFields);
    _guarantorAadhaarNumController.addListener(_validateFields);
    _guarantorPanNumController.addListener(_validateFields);
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _fatherNameController.dispose();
    _phNumController.dispose();
    _altPhNumController.dispose();
    _emailController.dispose();
    _permanentAddressController.dispose();
    _streetAddressController.dispose();
    _landMarkController.dispose();
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
    _referenceController.dispose();
    _referenceNumController.dispose();
    _reasonController.dispose();
    _agentNameController.dispose();
    _locationLinkController.dispose();
    _workLocationLinkController.dispose();
    _guarantorNameController.dispose();
    _guarantorPhNumController.dispose();
    _guarantorAltPhNumController.dispose();
    _guarantorEmailController.dispose();
    _guarantorAddressController.dispose();
    _guarantorChequeNumController.dispose();
    _guarantorAadhaarNumController.dispose();
    _guarantorPanNumController.dispose();

    _nameFocusNode.dispose();
    _fatherNameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _permanentAddressFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _landmarkFocusNode.dispose();
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
    _referenceFocusNode.dispose();
    _referenceFocusNode.dispose();
    _reasonFocusNode.dispose();
    _agentNameFocusNode.dispose();
    _docTypeFocusNode.dispose();
    _guarantorNameFocusNode.dispose();
    _guarantorPhNumFocusNode.dispose();
    _guarantorAltPhNumFocusNode.dispose();
    _guarantorEmailFocusNode.dispose();
    _guarantorAddressFocusNode.dispose();
    _guarantorChequeNumFocusNode.dispose();
    _guarantorAadhaarNumFocusNode.dispose();
    _guarantorPanNumFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _fatherNameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _permanentAddressController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _landMarkController.removeListener(_validateFields);
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
    _referenceController.removeListener(_validateFields);
    _referenceNumController.removeListener(_validateFields);
    _reasonController.removeListener(_validateFields);
    _agentNameController.removeListener(_validateFields);
    _guarantorNameController.removeListener(_validateFields);
    _guarantorPhNumController.removeListener(_validateFields);
    _guarantorAltPhNumController.removeListener(_validateFields);
    _guarantorEmailController.removeListener(_validateFields);
    _guarantorAddressController.removeListener(_validateFields);
    _guarantorChequeNumController.removeListener(_validateFields);
    _guarantorAadhaarNumController.removeListener(_validateFields);
    _guarantorPanNumController.removeListener(_validateFields);

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
    photoText = appContent['verify_customers']['photo_text'] ?? "";

    var response = await NetworkService().verifyCustomerProfilePrefetchDetails(
      id: widget.id,
    );

    if (response != null && response['data'] != null) {
      accFeeText = response['data']['acc_fee_text'] ?? "";
      _nameController.text = response['data']['name'] ?? "";
      _fatherNameController.text = response['data']['father_name'] ?? "";
      _phNumController.text = response['data']['mob_num'] ?? "";
      _altPhNumController.text = response['data']['alt_mob_num'] ?? "";
      _emailController.text = response['data']['email_address'] ?? "";
      _permanentAddressController.text =
          response['data']['permanent_address'] ?? "";
      _streetAddressController.text = response['data']['address'] ?? "";
      _landMarkController.text = response['data']['landMark'] ?? "";
      _cityController.text = response['data']['city'] ?? "";
      _stateController.text = response['data']['state'] ?? "";
      _zipController.text = response['data']['pincode'] ?? "";
      _countryController.text = response['data']['country'] ?? "";
      _aadhaarController.text = response['data']['aadhaar_num'] ?? "";
      _panController.text = response['data']['pan_num'] ?? "";
      _rcHolderNameController.text = response['data']['rc_holder_name'] ?? "";
      _propertyHolderNameController.text =
          response['data']['property_holder_name'] ?? "";
      _propertyDetailsController.text =
          response['data']['property_details'] ?? "";
      _chequeNumController.text = response['data']['cheque_num'] ?? "";
      _bankNameController.text = response['data']['bank_name'] ?? "";
      _accNumController.text = response['data']['acc_num'] ?? "";
      _bankBranchController.text = response['data']['bank_branch'] ?? "";
      _bankIFSCcodeController.text = response['data']['ifsc_code'] ?? "";
      photoImagePath = response['data']['profile_img'] ?? "";
      aadhaarImagePath = response['data']['aadhaar_img'] ?? "";
      panImagePath = response['data']['pan_img'] ?? "";
      rcHOLDERImagePath = response['data']['rc_img'] ?? "";
      propertyDocImagePath = response['data']['property_img'] ?? "";
      houseImagePath = response['data']['house_img'] ?? "";
      passBookImagePath = response['data']['pass_book_img'] ?? "";
      signatureImagePath = response['data']['signature_img'] ?? "";
      _guarantorNameController.text = response['data']['guarantorName'] ?? "";
      _guarantorPhNumController.text =
          response['data']['guarantorMobNum'] ?? "";
      _guarantorAltPhNumController.text =
          response['data']['guarantorAltMobNum'] ?? "";
      _guarantorEmailController.text = response['data']['guarantorEmail'] ?? "";
      _guarantorAddressController.text =
          response['data']['guarantorAddress'] ?? "";
      _guarantorChequeNumController.text =
          response['data']['guarantorChequeNum'] ?? "";
      _guarantorAadhaarNumController.text =
          response['data']['guarantorAadhaarNum'] ?? "";
      _guarantorPanNumController.text =
          response['data']['guarantorPanNum'] ?? "";
      selectedDocValue.value = (response['data']['docType'] != null &&
              response['data']['docType'].isNotEmpty)
          ? response['data']['docType']
          : "Select Document Type";
      _workLocationLinkController.text = response['data']['workLocLink'] ?? "";
      _locationLinkController.text = response['data']['locLink'] ?? "";
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.sp,
                  ),
                  (accFeeText != null && accFeeText!.isNotEmpty)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.sp, horizontal: 16.sp),
                          child: Text(
                            accFeeText ?? "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorConstants.darkBlueColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
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

                              /* Father Input Field*/
                              Text(
                                fatherNameText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _fatherNameFocusNode,
                                suffixWidget: const Icon(
                                  Icons.person_pin_circle_rounded,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: fatherNamePlaceHolderText,
                                textEditingController: _fatherNameController,
                                validationFunc: (value) {
                                  return ValidationUtil.validateFatherName(
                                      value);
                                },
                              ),
                              /* Father Name Input Field */

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

                              /* Permanent Address Input Field*/
                              Text(
                                "Permanent Address",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _permanentAddressFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: "Address",
                                textEditingController:
                                    _permanentAddressController,
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
                                      value, 5,
                                      pageType: widget.type);
                                },
                              ),
                              /* Permanent Address Input Field */

                              SizedBox(
                                height: 8.sp,
                              ),

                              ValueListenableBuilder(
                                  valueListenable: refreshAddress,
                                  builder: (context, val, _) {
                                    return InkWell(
                                      onTap: () {
                                        sameAsPermanentAddress =
                                            !sameAsPermanentAddress!;
                                        if (sameAsPermanentAddress == true) {
                                          _streetAddressController.text =
                                              _permanentAddressController.text;
                                        } else {
                                          _streetAddressController.clear();
                                        }

                                        refreshAddress.value =
                                            !refreshAddress.value;
                                      },
                                      child: Row(
                                        spacing: 2.sp,
                                        children: [
                                          (sameAsPermanentAddress == true)
                                              ? Icon(
                                                  Icons.check_box,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                  size: 20.sp,
                                                )
                                              : Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  size: 20.sp,
                                                ),
                                          Text(
                                            "Same as Permanent Address",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: ColorConstants.blackColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 8.sp,
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
                                placeholderText: "Address",
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
                                      value, 1,
                                      pageType: widget.type);
                                },
                              ),
                              /* Street Address Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Landmark Input Field*/
                              Text(
                                "Landmark",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextInputField(
                                focusnodes: _landmarkFocusNode,
                                suffixWidget: const Icon(
                                  Icons.location_on,
                                  color: ColorConstants.darkBlueColor,
                                ),
                                placeholderText: "Landmark",
                                textEditingController: _landMarkController,
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
                                    value,
                                    7,
                                    pageType: widget.type,
                                  );
                                },
                              ),
                              /* Landmark Input Field */

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
                                      value, 3,
                                      pageType: widget.type);
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
                                      value, 2,
                                      pageType: widget.type);
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
                                      value, 4,
                                      pageType: widget.type);
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

                              ValueListenableBuilder(
                                  valueListenable: selectedDocValue,
                                  builder: (context, value, child) {
                                    return (selectedDocValue.value ==
                                            "Personal")
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Cheque Number Field */
                                              Text(
                                                chequeNumberText,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextInputField(
                                                focusnodes: _chequeNumFocusNode,
                                                suffixWidget: const Icon(
                                                  Icons.money,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                                placeholderText:
                                                    chequeNumberPlaceHolderText,
                                                textEditingController:
                                                    _chequeNumController,
                                                textcapitalization:
                                                    TextCapitalization
                                                        .characters,
                                                inputFormattersList: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                    RegExp(
                                                        r'^[0-9]*$'), // Allows only digits
                                                  ),
                                                  LengthLimitingTextInputFormatter(
                                                      10), // Limits input to 10 characters (adjust if needed)
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                    RegExp(
                                                        r"\s\s"), // Prevents multiple spaces (though likely unnecessary for digits only)
                                                  ),
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                    RegExp(
                                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'), // Blocks certain unicode characters (emojis, special symbols)
                                                  ),
                                                ],
                                                keyboardtype:
                                                    TextInputType.number,
                                                validationFunc: (value) {
                                                  return ValidationUtil
                                                      .validateChequeNumber(
                                                    value,
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  }),
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
                                    RegExp(r'^[0-9][0-9]*$'),
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
                                  return null;
                                  // ValidationUtil.validateIFSC(value);
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

                              /* Doc Options Input Field */
                              Text(
                                "Document Type",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ValueListenableBuilder(
                                valueListenable: selectedDocValue,
                                builder: (context, String? vals, _) {
                                  String? errorText =
                                      ValidationUtil.validateFrequency(
                                          selectedDocValue.value);
                                  bool isError =
                                      ValidationUtil.validateFrequency(
                                              selectedDocValue.value) !=
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
                                          focusNode: _docTypeFocusNode,
                                          value: selectedDocValue.value,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp)),
                                          underline: const SizedBox.shrink(),
                                          isExpanded: true,
                                          icon: const Icon(
                                            Icons.document_scanner_sharp,
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
                                            "Select Document Type",
                                            style: TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                          items: docOptions.map((String value) {
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
                                            selectedDocValue.value = newValue;
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              if (selectedDocValue.value !=
                                                  "Select Document type") {
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
                              /* Doc Options Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* RC Holder Name Field */
                              ValueListenableBuilder(
                                  valueListenable: selectedDocValue,
                                  builder: (context, value, child) {
                                    return (selectedDocValue.value == "Vehicle")
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                rcHolderNameText,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: ColorConstants
                                                      .lightBlackColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              TextInputField(
                                                focusnodes:
                                                    _rcHolderNameFocusNode,
                                                suffixWidget: const Icon(
                                                  Icons.assignment_ind_outlined,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                                placeholderText:
                                                    rcHolderNameText,
                                                textEditingController:
                                                    _rcHolderNameController,
                                                textcapitalization:
                                                    TextCapitalization.words,
                                                inputFormattersList: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                    RegExp(r"\s\s"),
                                                  ),
                                                  FilteringTextInputFormatter
                                                      .deny(
                                                    RegExp(
                                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                                  ),
                                                ],
                                                keyboardtype:
                                                    TextInputType.text,
                                                validationFunc: (value) {
                                                  return ValidationUtil
                                                      .validateRCHolderName(
                                                    value,
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  }),
                              /* RC Holder Name Field */

                              ValueListenableBuilder(
                                valueListenable: selectedDocValue,
                                builder: (context, value, child) {
                                  return (selectedDocValue.value == "Property")
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            /* Property Holder Name Field */
                                            Text(
                                              propertyHolderNameText,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: ColorConstants
                                                    .lightBlackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextInputField(
                                              focusnodes:
                                                  _propertyHolderNameFocusNode,
                                              suffixWidget: const Icon(
                                                Icons.badge_outlined,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              placeholderText:
                                                  propertyHolderNameText,
                                              textEditingController:
                                                  _propertyHolderNameController,
                                              textcapitalization:
                                                  TextCapitalization.sentences,
                                              inputFormattersList: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .deny(
                                                  RegExp(r"\s\s"),
                                                ),
                                                FilteringTextInputFormatter
                                                    .deny(
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
                                                color: ColorConstants
                                                    .lightBlackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            TextInputField(
                                              focusnodes:
                                                  _propertyDetailsFocusNode,
                                              suffixWidget: const Icon(
                                                Icons.chalet_rounded,
                                                color: ColorConstants
                                                    .darkBlueColor,
                                              ),
                                              placeholderText:
                                                  propertyDetailsText,
                                              textEditingController:
                                                  _propertyDetailsController,
                                              textcapitalization:
                                                  TextCapitalization.sentences,
                                              inputFormattersList: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .deny(
                                                  RegExp(r"\s\s"),
                                                ),
                                                FilteringTextInputFormatter
                                                    .deny(
                                                  RegExp(
                                                      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                                ),
                                              ],
                                              keyboardtype: TextInputType.text,
                                              validationFunc: (value) {
                                                return ValidationUtil
                                                    .validatePropertyDetails(
                                                  value,
                                                );
                                              },
                                            ),
                                            /* Property Details Field */
                                          ],
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),

                              /* Reference Input Field*/
                              (widget.type == "1")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),
                                        Text(
                                          "Reference -  Group Leader Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _referenceFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.person_pin_rounded,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              "Enter Reference Name",
                                          textEditingController:
                                              _referenceController,
                                          validationFunc: (value) {
                                            return ValidationUtil
                                                .validateReferenceName(value);
                                          },
                                        ),
                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Reference Mobile Number Input Field */
                                        Text(
                                          "Reference - Group Leader Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _referenceNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              "Enter Reference Mobile Number",
                                          textEditingController:
                                              _referenceNumController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateReferenceMobileNumber(
                                              value,
                                            );
                                          },
                                        ),
                                        /* Reference Mobile Number Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Agent Name */
                                        Text(
                                          "Lead - Agent Phone Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _agentNameFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              "Enter Agent Phone Number",
                                          textEditingController:
                                              _agentNameController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateAgentNumber(value);
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              /* Reference Input Field */

                              /* Reference Input Field*/
                              (widget.type == "2")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Agent Name */
                                        Text(
                                          "Lead - Agent Phone Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _agentNameFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              "Enter Agent Phone Number",
                                          textEditingController:
                                              _agentNameController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateAgentNumber(value);
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              /* Reference Input Field */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Photo Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshphotoImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      placeholderText: "Add Photo",
                                      addText: addText,
                                      imagePath: photoImagePath ?? "",
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosphotoList = [];
                                                compressedPhotosphotoList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosphotoList,
                                                );

                                                photoImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosphotoList[0]
                                                      .path,
                                                );

                                                refreshphotoImage.value =
                                                    !refreshphotoImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosphotoList = [];
                                                compressedPhotosphotoList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosphotoList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );

                                                photoImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosphotoList[0]
                                                      .path,
                                                );

                                                refreshphotoImage.value =
                                                    !refreshphotoImage.value;
                                              },
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
                                    );
                                  }),
                              /* Add Photo Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Aadhaar Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshAadhaarImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      placeholderText: "Add Location 1 Image",
                                      addText: addText,
                                      imagePath: aadhaarImagePath ?? "",
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosAadhaarList =
                                                    [];
                                                compressedPhotosAadhaarList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosAadhaarList,
                                                );

                                                aadhaarImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosAadhaarList[0]
                                                      .path,
                                                );

                                                refreshAadhaarImage.value =
                                                    !refreshAadhaarImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosAadhaarList =
                                                    [];
                                                compressedPhotosAadhaarList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosAadhaarList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );

                                                aadhaarImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosAadhaarList[0]
                                                      .path,
                                                );

                                                refreshAadhaarImage.value =
                                                    !refreshAadhaarImage.value;
                                              },
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
                                      placeholderText: "Add Location 2 Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosPanList = [];
                                                compressedPhotosPanList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosPanList,
                                                );

                                                panImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosPanList[0]
                                                      .path,
                                                );

                                                refreshPanImage.value =
                                                    !refreshPanImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosPanList = [];
                                                compressedPhotosPanList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosPanList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );

                                                panImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosPanList[0]
                                                      .path,
                                                );

                                                refreshPanImage.value =
                                                    !refreshPanImage.value;
                                              },
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
                                    );
                                  }),
                              /* Add PAN Doc Image */

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
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosPassBookList =
                                                    [];
                                                compressedPhotosPassBookList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosPassBookList,
                                                  // invalidFormatErrorText: "Invalid",
                                                );
                                                print(
                                                    "passBookImagePath: 1 ${compressedPhotosPassBookList[0].path}");
                                                passBookImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosPassBookList[
                                                          0]
                                                      .path,
                                                );
                                                print(
                                                    "passBookImagePath: 2$passBookImagePath");
                                                refreshPassBookImage.value =
                                                    !refreshPassBookImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosPassBookList =
                                                    [];
                                                compressedPhotosPassBookList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosPassBookList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );
                                                print(
                                                    "passBookImagePath: 1 ${compressedPhotosPassBookList[0].path}");
                                                passBookImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosPassBookList[
                                                          0]
                                                      .path,
                                                );
                                                print(
                                                    "passBookImagePath: 2$passBookImagePath");
                                                refreshPassBookImage.value =
                                                    !refreshPassBookImage.value;
                                              },
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
                                    );
                                  }),
                              /* Add Pass Book Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add Signature Image */
                              ValueListenableBuilder(
                                  valueListenable: refreshSignImage,
                                  builder: (context, bool val, _) {
                                    return AddDocImagePlaceholder(
                                      imagePath: signatureImagePath ?? "",
                                      placeholderText: "Add Signature Image",
                                      addText: addText,
                                      onImageTap: () async {
                                        await InternetUtil()
                                            .checkInternetConnection()
                                            .then((internet) async {
                                          if (internet) {
                                            showDocsAlertDialog(
                                              context: context,
                                              onCaptureAction: () async {
                                                compressedPhotosSignList = [];
                                                compressedPhotosSignList =
                                                    await capturePhoto(
                                                  type: 2,
                                                  screenName: "KYC",
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosSignList,
                                                  // invalidFormatErrorText: "Invalid",
                                                );
                                                print(
                                                    "signatureImagePath: 1 ${compressedPhotosSignList[0].path}");
                                                signatureImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosSignList[0]
                                                      .path,
                                                );
                                                print(
                                                    "signatureImagePath: 2$signatureImagePath");
                                                refreshSignImage.value =
                                                    !refreshSignImage.value;
                                              },
                                              onGalleryAction: () async {
                                                compressedPhotosSignList = [];
                                                compressedPhotosSignList =
                                                    await pickPhotos(
                                                  maxImagesCount: 1,
                                                  context: context,
                                                  compressedPhotosList:
                                                      compressedPhotosSignList,
                                                  invalidFormatErrorText:
                                                      "Invalid",
                                                );
                                                print(
                                                    "signatureImagePath: 1 ${compressedPhotosSignList[0].path}");
                                                signatureImagePath =
                                                    await NetworkService()
                                                        .imageUpload(
                                                  compressedPhotosSignList[0]
                                                      .path,
                                                );

                                                refreshSignImage.value =
                                                    !refreshSignImage.value;
                                              },
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
                                    );
                                  }),
                              /* Add Signature Image */

                              ((widget.type == "1") ||
                                      (widget.type == "2") ||
                                      (widget.type == "3"))
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Add Hosue Image */
                                        ValueListenableBuilder(
                                            valueListenable: refreshHouseImage,
                                            builder: (context, bool val, _) {
                                              return AddDocImagePlaceholder(
                                                imagePath: houseImagePath ?? "",
                                                placeholderText:
                                                    "Add House Image",
                                                addText: addText,
                                                onImageTap: () async {
                                                  await InternetUtil()
                                                      .checkInternetConnection()
                                                      .then((internet) async {
                                                    if (internet) {
                                                      showDocsAlertDialog(
                                                        context: context,
                                                        onCaptureAction:
                                                            () async {
                                                          compressedPhotosHouseList =
                                                              [];
                                                          compressedPhotosHouseList =
                                                              await capturePhoto(
                                                            type: 2,
                                                            screenName: "KYC",
                                                            maxImagesCount: 1,
                                                            context: context,
                                                            compressedPhotosList:
                                                                compressedPhotosHouseList,
                                                            // invalidFormatErrorText: "Invalid",
                                                          );
                                                          print(
                                                              "houseImagePath: 1 ${compressedPhotosHouseList[0].path}");
                                                          houseImagePath =
                                                              await NetworkService()
                                                                  .imageUpload(
                                                            compressedPhotosHouseList[
                                                                    0]
                                                                .path,
                                                          );
                                                          print(
                                                              "houseImagePath: 2$houseImagePath");
                                                          refreshHouseImage
                                                                  .value =
                                                              !refreshHouseImage
                                                                  .value;
                                                        },
                                                        onGalleryAction:
                                                            () async {
                                                          compressedPhotosHouseList =
                                                              [];
                                                          compressedPhotosHouseList =
                                                              await pickPhotos(
                                                            maxImagesCount: 1,
                                                            context: context,
                                                            compressedPhotosList:
                                                                compressedPhotosHouseList,
                                                            invalidFormatErrorText:
                                                                "Invalid",
                                                          );
                                                          print(
                                                              "houseImagePath: 1 ${compressedPhotosHouseList[0].path}");
                                                          houseImagePath =
                                                              await NetworkService()
                                                                  .imageUpload(
                                                            compressedPhotosHouseList[
                                                                    0]
                                                                .path,
                                                          );

                                                          refreshHouseImage
                                                                  .value =
                                                              !refreshHouseImage
                                                                  .value;
                                                        },
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
                                              );
                                            }),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                              /* Add Hosue Image */

                              // SizedBox(
                              //   height: 16.sp,
                              // ),

                              // /* Add Cheque Doc Image */
                              // ValueListenableBuilder(
                              //     valueListenable: refreshChequeImage,
                              //     builder: (context, bool val, _) {
                              //       return AddDocImagePlaceholder(
                              //         imagePath: chequeImagePath ?? "",
                              //         placeholderText: "Add Cheque Image",
                              //         addText: addText,
                              //         onImageTap: () async {
                              //           await InternetUtil()
                              //               .checkInternetConnection()
                              //               .then((internet) async {
                              //             if (internet) {
                              //               showDocsAlertDialog(
                              //                 context: context,
                              //                 onCaptureAction: () async {
                              //                   compressedPhotosChequeList = [];
                              //                   compressedPhotosChequeList =
                              //                       await capturePhoto(
                              //                     type: 2,
                              //                     screenName: "KYC",
                              //                     maxImagesCount: 1,
                              //                     context: context,
                              //                     compressedPhotosList:
                              //                         compressedPhotosChequeList,
                              //                   );

                              //                   chequeImagePath =
                              //                       await NetworkService()
                              //                           .imageUpload(
                              //                     compressedPhotosChequeList[0]
                              //                         .path,
                              //                   );

                              //                   refreshChequeImage.value =
                              //                       !refreshChequeImage.value;
                              //                 },
                              //                 onGalleryAction: () async {
                              //                   compressedPhotosChequeList = [];
                              //                   compressedPhotosChequeList =
                              //                       await pickPhotos(
                              //                     maxImagesCount: 1,
                              //                     context: context,
                              //                     compressedPhotosList:
                              //                         compressedPhotosChequeList,
                              //                     invalidFormatErrorText:
                              //                         "Invalid",
                              //                   );

                              //                   chequeImagePath =
                              //                       await NetworkService()
                              //                           .imageUpload(
                              //                     compressedPhotosChequeList[0]
                              //                         .path,
                              //                   );

                              //                   refreshChequeImage.value =
                              //                       !refreshChequeImage.value;
                              //                 },
                              //               );
                              //             } else {
                              //               ToastUtil().showSnackBar(
                              //                 context: context,
                              //                 message: internetAlert,
                              //                 isError: true,
                              //               );
                              //             }
                              //           });
                              //         },
                              //       );
                              //     }),
                              // /* Add Cheque Doc Image */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Add RC Doc Image */
                              ValueListenableBuilder(
                                  valueListenable: selectedDocValue,
                                  builder: (context, value, child) {
                                    return (selectedDocValue.value == "Vehicle")
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshRCHOLDERImage,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          rcHOLDERImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add RC Image",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosRCHOLDERList =
                                                                    [];
                                                                compressedPhotosRCHOLDERList =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosRCHOLDERList,
                                                                );

                                                                rcHOLDERImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosRCHOLDERList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshRCHOLDERImage
                                                                        .value =
                                                                    !refreshRCHOLDERImage
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosRCHOLDERList =
                                                                    [];
                                                                compressedPhotosRCHOLDERList =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosRCHOLDERList,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );

                                                                rcHOLDERImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosRCHOLDERList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshRCHOLDERImage
                                                                        .value =
                                                                    !refreshRCHOLDERImage
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  }),
                              /* Add RC Doc Image */

                              ValueListenableBuilder(
                                  valueListenable: selectedDocValue,
                                  builder: (context, value, child) {
                                    return (selectedDocValue.value ==
                                            "Property")
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Property Doc Image */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshPropertyDocImage,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          propertyDocImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Property Doc Image",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            // Upload Profile Photo
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosPropertyDocList =
                                                                    [];
                                                                compressedPhotosPropertyDocList =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosPropertyDocList,
                                                                );

                                                                propertyDocImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosPropertyDocList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshPropertyDocImage
                                                                        .value =
                                                                    !refreshPropertyDocImage
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosPropertyDocList =
                                                                    [];
                                                                compressedPhotosPropertyDocList =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosPropertyDocList,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );

                                                                propertyDocImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosPropertyDocList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshPropertyDocImage
                                                                        .value =
                                                                    !refreshPropertyDocImage
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
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

                                              /* Add Building Image 1 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding1Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building1ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 1",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding1List =
                                                                    [];
                                                                compressedPhotosBuilding1List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding1List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building1ImagePath: 1 ${compressedPhotosBuilding1List[0].path}");
                                                                building1ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding1List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building1ImagePath: 2$building1ImagePath");
                                                                refreshBuilding1Image
                                                                        .value =
                                                                    !refreshBuilding1Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding1List =
                                                                    [];
                                                                compressedPhotosBuilding1List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding1List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building1ImagePath: 1 ${compressedPhotosBuilding1List[0].path}");
                                                                building1ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding1List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding1Image
                                                                        .value =
                                                                    !refreshBuilding1Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 1 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 2 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding2Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          buildingImage2Path ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 2",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding2List =
                                                                    [];
                                                                compressedPhotosBuilding2List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding2List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "buildingImage2Path: 1 ${compressedPhotosBuilding2List[0].path}");
                                                                buildingImage2Path =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding2List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "buildingImage2Path: 2$buildingImage2Path");
                                                                refreshBuilding2Image
                                                                        .value =
                                                                    !refreshBuilding2Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding2List =
                                                                    [];
                                                                compressedPhotosBuilding2List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding2List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "buildingImage2Path: 1 ${compressedPhotosBuilding2List[0].path}");
                                                                buildingImage2Path =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding2List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding2Image
                                                                        .value =
                                                                    !refreshBuilding2Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 2 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 3 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding3Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building3ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 3",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding3List =
                                                                    [];
                                                                compressedPhotosBuilding3List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding3List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building3ImagePath: 1 ${compressedPhotosBuilding3List[0].path}");
                                                                building3ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding3List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building3ImagePath: 2$building3ImagePath");
                                                                refreshBuilding3Image
                                                                        .value =
                                                                    !refreshBuilding3Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding3List =
                                                                    [];
                                                                compressedPhotosBuilding3List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding3List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building3ImagePath: 1 ${compressedPhotosBuilding3List[0].path}");
                                                                building3ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding3List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding3Image
                                                                        .value =
                                                                    !refreshBuilding3Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 3 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 4 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding4Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building4ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 4",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding4List =
                                                                    [];
                                                                compressedPhotosBuilding4List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding4List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building4ImagePath: 1 ${compressedPhotosBuilding4List[0].path}");
                                                                building4ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding4List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building4ImagePath: 2 $building4ImagePath");
                                                                refreshBuilding4Image
                                                                        .value =
                                                                    !refreshBuilding4Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding4List =
                                                                    [];
                                                                compressedPhotosBuilding4List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding4List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building4ImagePath: 1 ${compressedPhotosBuilding4List[0].path}");
                                                                building4ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding4List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding4Image
                                                                        .value =
                                                                    !refreshBuilding4Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 4 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 5 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding5Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building5ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 5",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding5List =
                                                                    [];
                                                                compressedPhotosBuilding5List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding5List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building5ImagePath: 1 ${compressedPhotosBuilding5List[0].path}");
                                                                building5ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding5List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building5ImagePath: 2 $building5ImagePath");
                                                                refreshBuilding5Image
                                                                        .value =
                                                                    !refreshBuilding5Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding5List =
                                                                    [];
                                                                compressedPhotosBuilding5List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding5List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building5ImagePath: 1 ${compressedPhotosBuilding5List[0].path}");
                                                                building5ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding5List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding5Image
                                                                        .value =
                                                                    !refreshBuilding5Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 5 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 6 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding6Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building6ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 6",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding6List =
                                                                    [];
                                                                compressedPhotosBuilding6List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding6List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building6ImagePath: 1 ${compressedPhotosBuilding6List[0].path}");
                                                                building6ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding6List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building6ImagePath: 2 $building6ImagePath");
                                                                refreshBuilding6Image
                                                                        .value =
                                                                    !refreshBuilding6Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding6List =
                                                                    [];
                                                                compressedPhotosBuilding6List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding6List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building6ImagePath: 1 ${compressedPhotosBuilding6List[0].path}");
                                                                building6ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding6List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding6Image
                                                                        .value =
                                                                    !refreshBuilding6Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 6 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Image 7 */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuilding7Image,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          building7ImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Image 7",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuilding7List =
                                                                    [];
                                                                compressedPhotosBuilding7List =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding7List,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "building7ImagePath: 1 ${compressedPhotosBuilding7List[0].path}");
                                                                building7ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding7List[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "building7ImagePath: 2 $building7ImagePath");
                                                                refreshBuilding7Image
                                                                        .value =
                                                                    !refreshBuilding7Image
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuilding7List =
                                                                    [];
                                                                compressedPhotosBuilding7List =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuilding7List,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "building7ImagePath: 1 ${compressedPhotosBuilding7List[0].path}");
                                                                building7ImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuilding7List[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuilding7Image
                                                                        .value =
                                                                    !refreshBuilding7Image
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Image 7 */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Street Image */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuildingStreetImage,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          buildingStreetImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Street Image",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuildingStreetList =
                                                                    [];
                                                                compressedPhotosBuildingStreetList =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuildingStreetList,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "buildingStreetImagePath: 1 ${compressedPhotosBuildingStreetList[0].path}");
                                                                buildingStreetImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuildingStreetList[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "buildingStreetImagePath: 2 $buildingStreetImagePath");
                                                                refreshBuildingStreetImage
                                                                        .value =
                                                                    !refreshBuildingStreetImage
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuildingStreetList =
                                                                    [];
                                                                compressedPhotosBuildingStreetList =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuildingStreetList,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "buildingStreetImagePath: 1 ${compressedPhotosBuildingStreetList[0].path}");
                                                                buildingStreetImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuildingStreetList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuildingStreetImage
                                                                        .value =
                                                                    !refreshBuildingStreetImage
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Street Image */

                                              SizedBox(
                                                height: 16.sp,
                                              ),

                                              /* Add Building Area Image */
                                              ValueListenableBuilder(
                                                  valueListenable:
                                                      refreshBuildingAreaImage,
                                                  builder:
                                                      (context, bool val, _) {
                                                    return AddDocImagePlaceholder(
                                                      imagePath:
                                                          buildingAreaImagePath ??
                                                              "",
                                                      placeholderText:
                                                          "Add Building Area Image",
                                                      addText: addText,
                                                      onImageTap: () async {
                                                        await InternetUtil()
                                                            .checkInternetConnection()
                                                            .then(
                                                                (internet) async {
                                                          if (internet) {
                                                            showDocsAlertDialog(
                                                              context: context,
                                                              onCaptureAction:
                                                                  () async {
                                                                compressedPhotosBuildingAreaList =
                                                                    [];
                                                                compressedPhotosBuildingAreaList =
                                                                    await capturePhoto(
                                                                  type: 2,
                                                                  screenName:
                                                                      "KYC",
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuildingAreaList,
                                                                  // invalidFormatErrorText: "Invalid",
                                                                );
                                                                print(
                                                                    "buildingAreaImagePath: 1 ${compressedPhotosBuildingAreaList[0].path}");
                                                                buildingAreaImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuildingAreaList[
                                                                          0]
                                                                      .path,
                                                                );
                                                                print(
                                                                    "buildingAreaImagePath: 2 $buildingAreaImagePath");
                                                                refreshBuildingAreaImage
                                                                        .value =
                                                                    !refreshBuildingAreaImage
                                                                        .value;
                                                              },
                                                              onGalleryAction:
                                                                  () async {
                                                                compressedPhotosBuildingAreaList =
                                                                    [];
                                                                compressedPhotosBuildingAreaList =
                                                                    await pickPhotos(
                                                                  maxImagesCount:
                                                                      1,
                                                                  context:
                                                                      context,
                                                                  compressedPhotosList:
                                                                      compressedPhotosBuildingAreaList,
                                                                  invalidFormatErrorText:
                                                                      "Invalid",
                                                                );
                                                                print(
                                                                    "buildingAreaImagePath: 1 ${compressedPhotosBuildingAreaList[0].path}");
                                                                buildingAreaImagePath =
                                                                    await NetworkService()
                                                                        .imageUpload(
                                                                  compressedPhotosBuildingAreaList[
                                                                          0]
                                                                      .path,
                                                                );

                                                                refreshBuildingAreaImage
                                                                        .value =
                                                                    !refreshBuildingAreaImage
                                                                        .value;
                                                              },
                                                            );
                                                          } else {
                                                            ToastUtil()
                                                                .showSnackBar(
                                                              context: context,
                                                              message:
                                                                  internetAlert,
                                                              isError: true,
                                                            );
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }),
                                              /* Add Building Area Image */
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  }),

                              (widget.type == "3")
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: refreshCheckbox,
                                          builder: (context, val, _) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        isVerified =
                                                            !isVerified!;
                                                        if (isVerified ==
                                                            true) {
                                                          isRejected = false;
                                                        }

                                                        refreshCheckbox.value =
                                                            !refreshCheckbox
                                                                .value;
                                                      },
                                                      child: Row(
                                                        spacing: 2.sp,
                                                        children: [
                                                          (isVerified == true)
                                                              ? Icon(
                                                                  Icons
                                                                      .check_box,
                                                                  color: ColorConstants
                                                                      .darkBlueColor,
                                                                  size: 20.sp,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .check_box_outline_blank,
                                                                  color: ColorConstants
                                                                      .lightBlackColor,
                                                                  size: 20.sp,
                                                                ),
                                                          Text(
                                                            "Verified",
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              color:
                                                                  ColorConstants
                                                                      .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          isRejected =
                                                              !isRejected!;
                                                          if (isRejected ==
                                                              true) {
                                                            isVerified = false;
                                                          }

                                                          refreshCheckbox
                                                                  .value =
                                                              !refreshCheckbox
                                                                  .value;
                                                        },
                                                        child: Row(
                                                          spacing: 2.sp,
                                                          children: [
                                                            (isRejected == true)
                                                                ? Icon(
                                                                    Icons
                                                                        .check_box,
                                                                    color: ColorConstants
                                                                        .darkBlueColor,
                                                                    size: 20.sp,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .check_box_outline_blank,
                                                                    color: ColorConstants
                                                                        .lightBlackColor,
                                                                    size: 20.sp,
                                                                  ),
                                                            Text(
                                                              "Rejected",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                color: ColorConstants
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 16.sp,
                                                    ),
                                                    Text(
                                                      "Verified By - Agent Name",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: ColorConstants
                                                            .lightBlackColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextInputField(
                                                      focusnodes:
                                                          _referenceFocusNode,
                                                      suffixWidget: const Icon(
                                                        Icons
                                                            .person_pin_rounded,
                                                        color: ColorConstants
                                                            .darkBlueColor,
                                                      ),
                                                      placeholderText:
                                                          "Enter Agent Name",
                                                      textEditingController:
                                                          _referenceController,
                                                      validationFunc: (value) {
                                                        return ValidationUtil
                                                            .validateByAgentName(
                                                                value);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 16.sp,
                                                    ),

                                                    /* Reference Mobile Number Input Field */
                                                    Text(
                                                      "Verified By: Contact Details",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: ColorConstants
                                                            .lightBlackColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextInputField(
                                                      focusnodes:
                                                          _referenceNumFocusNode,
                                                      suffixWidget: const Icon(
                                                        Icons.phone_locked,
                                                        color: ColorConstants
                                                            .darkBlueColor,
                                                      ),
                                                      placeholderText:
                                                          "Enter Agent Mobile Number",
                                                      textEditingController:
                                                          _referenceNumController,
                                                      inputFormattersList: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            10),
                                                        FilteringTextInputFormatter
                                                            .allow(
                                                          RegExp(
                                                              r'^[6-9][0-9]*$'),
                                                        ),
                                                        FilteringTextInputFormatter
                                                            .deny(
                                                          RegExp(r"\s\s"),
                                                        ),
                                                        FilteringTextInputFormatter
                                                            .deny(
                                                          RegExp(
                                                              r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                                        ),
                                                      ],
                                                      keyboardtype:
                                                          TextInputType.number,
                                                      validationFunc: (value) {
                                                        return ValidationUtil
                                                            .validateReferenceMobileNumber(
                                                          value,
                                                        );
                                                      },
                                                    ),
                                                    /* Reference Mobile Number Input Field */

                                                    /* Reason Input Field */
                                                    (isRejected == true)
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 16.sp,
                                                              ),
                                                              Text(
                                                                "Reason for Rejection",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: ColorConstants
                                                                      .lightBlackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              TextInputField(
                                                                focusnodes:
                                                                    _reasonFocusNode,
                                                                suffixWidget:
                                                                    const Icon(
                                                                  Icons.textsms,
                                                                  color: ColorConstants
                                                                      .darkBlueColor,
                                                                ),
                                                                placeholderText:
                                                                    "Reason",
                                                                textEditingController:
                                                                    _reasonController,
                                                                inputFormattersList: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .deny(
                                                                    RegExp(
                                                                        r"\s\s"),
                                                                  ),
                                                                  FilteringTextInputFormatter
                                                                      .deny(
                                                                    RegExp(
                                                                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                                                                  ),
                                                                ],
                                                                keyboardtype:
                                                                    TextInputType
                                                                        .text,
                                                                validationFunc:
                                                                    (value) {
                                                                  return ValidationUtil
                                                                      .validateWithdrawReason(
                                                                    value,
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox
                                                            .shrink(),

                                                    /* Reason Input Field */
                                                  ],
                                                ),
                                                /* Reference Input Field */
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  : const SizedBox.shrink(),

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Location Link */
                              Text(
                                "Location Link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextField(
                                controller: _locationLinkController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.paste,
                                      color: ColorConstants.darkBlueColor,
                                    ),
                                    onPressed: () => _pasteText(context),
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
                                  hintText: 'Paste text here',
                                  hintStyle: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                ),
                              ),
                              /* Location Link */

                              SizedBox(
                                height: 16.sp,
                              ),

                              /* Work Location Link */
                              Text(
                                "Work Location Link",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextField(
                                controller: _workLocationLinkController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.paste,
                                      color: ColorConstants.darkBlueColor,
                                    ),
                                    onPressed: () =>
                                        _pasteWorkLocLinkText(context),
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
                                  hintText: 'Paste text here',
                                  hintStyle: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10.sp,
                                ),
                              ),

                              /* Work Location Link */

                              SizedBox(height: 10.sp),
                              Text(
                                'Long-press in the TextField to see the context menu with paste option.',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ColorConstants.lightBlackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              /* Location Link */

                              /* Guarantor Details */
                              (widget.type == "0")
                                  ? const SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16.sp,
                                        ),
                                        /* Guarantor Name Input Field*/
                                        Text(
                                          "Gurantor's Name",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _guarantorNameFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.person_pin_circle_rounded,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: namePlaceHolderText,
                                          textEditingController:
                                              _guarantorNameController,
                                          validationFunc: (value) {
                                            return ValidationUtil
                                                .validateGuarantorName(
                                                    value, widget.type);
                                          },
                                        ),
                                        /* Name Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Mobile Number Input Field */
                                        Text(
                                          "Gurantor's Mobile Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _guarantorPhNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: phNumPlaceholderText,
                                          textEditingController:
                                              _guarantorPhNumController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateGuarantorMobileNumber(
                                                    value, widget.type);
                                          },
                                        ),
                                        /* Mobile Number Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Alternate Mobile Number Input Field */
                                        Text(
                                          "Gurantor's Alternate Mobile Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes:
                                              _guarantorAltPhNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.phone_locked,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: phNumPlaceholderText,
                                          textEditingController:
                                              _guarantorAltPhNumController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateGuarantorAltMobileNumber(
                                              value,
                                              _guarantorPhNumController.text,
                                            );
                                          },
                                        ),
                                        /* Alternate Mobile Number Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Email Address Input Field */
                                        Text(
                                          "Gurantor's Email Address",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _guarantorEmailFocusNode,
                                          textcapitalization:
                                              TextCapitalization.none,
                                          suffixWidget: const Icon(
                                            Icons.email,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: emailPlaceholderText,
                                          textEditingController:
                                              _guarantorEmailController,
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
                                                .validateGuarantorEmailAddress(
                                                    value, widget.type);
                                          },
                                        ),
                                        /* Email Address Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Permanent Address Input Field*/
                                        Text(
                                          "Guarantor's Address",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes:
                                              _guarantorAddressFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.location_on,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText: "Address",
                                          textEditingController:
                                              _guarantorAddressController,
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
                                                .validateLocation(value, 6,
                                                    pageType: widget.type);
                                          },
                                        ),
                                        /* Permanent Address Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Aadhaar Input Field */
                                        Text(
                                          "Guarantor's AADHAAR Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes:
                                              _guarantorAadhaarNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.assignment_ind_sharp,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              aadhaarNumPlaceholderText,
                                          textEditingController:
                                              _guarantorAadhaarNumController,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                12),
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
                                                .validateGuarantorAadhaar(
                                              value,
                                              widget.type,
                                            );
                                          },
                                        ),
                                        /* Aadhaar Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* PAN Input Field */
                                        Text(
                                          "Guarantor's PAN Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes: _guarantorPanNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.inventory_rounded,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              panNumPlaceholderText,
                                          textEditingController:
                                              _guarantorPanNumController,
                                          textcapitalization:
                                              TextCapitalization.characters,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                  r'^[A-Z]{0,5}[0-9]{0,4}[A-Z]?$'),
                                            ),
                                            LengthLimitingTextInputFormatter(
                                                10),
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
                                                .validateGuarantorPAN(
                                              value,
                                            );
                                          },
                                        ),
                                        /* PAN Input Field */

                                        SizedBox(
                                          height: 16.sp,
                                        ),

                                        /* Cheque Number Field */
                                        Text(
                                          "Guarantor's Cheque Number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color:
                                                ColorConstants.lightBlackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextInputField(
                                          focusnodes:
                                              _guarantorChequeNumFocusNode,
                                          suffixWidget: const Icon(
                                            Icons.money,
                                            color: ColorConstants.darkBlueColor,
                                          ),
                                          placeholderText:
                                              chequeNumberPlaceHolderText,
                                          textEditingController:
                                              _guarantorChequeNumController,
                                          textcapitalization:
                                              TextCapitalization.characters,
                                          inputFormattersList: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                  r'^[0-9]*$'), // Allows only digits
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
                                            return ValidationUtil
                                                .validateGuarantorChequeNumber(
                                              value,
                                              widget.type,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                              /* Guarantor Details */

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
    String? fatherNameError =
        ValidationUtil.validateFatherName(_fatherNameController.text);
    String? mobileError =
        ValidationUtil.validateMobileNumber(_phNumController.text);
    String? emailError =
        ValidationUtil.validateEmailAddress(_emailController.text);
    String? altMobileError = ValidationUtil.validateAltMobileNumber(
        _altPhNumController.text, _phNumController.text);
    String? permanentAddressError = ValidationUtil.validateLocation(
        _permanentAddressController.text, 5,
        pageType: widget.type);
    String? streetAddressError = ValidationUtil.validateLocation(
        _streetAddressController.text, 1,
        pageType: widget.type);
    String? landmarkError = ValidationUtil.validateLocation(
        _landMarkController.text, 7,
        pageType: widget.type);
    String? cityError = ValidationUtil.validateLocation(_cityController.text, 3,
        pageType: widget.type);
    String? stateError = ValidationUtil.validateLocation(
        _stateController.text, 2,
        pageType: widget.type);
    String? zipError = ValidationUtil.validatePinCode(_zipController.text);
    String? countryError = ValidationUtil.validateLocation(
        _countryController.text, 4,
        pageType: widget.type);
    String? aadhaarError =
        ValidationUtil.validateAadhaar(_aadhaarController.text);
    String? panError = ValidationUtil.validatePAN(_panController.text);

    // String? docTypeError =
    //     ValidationUtil.validateDocType(selectedDocValue.value);
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
    // String? bankIFSCError =
    //     ValidationUtil.validateIFSC(_bankIFSCcodeController.text);
    String? bankBranchError =
        ValidationUtil.validateBranchName(_bankBranchController.text);

    // String? photoImageError = ValidationUtil.validateImage(photoImagePath, 8);
    // String? aadhaarImageError =
    //     ValidationUtil.validateImage(aadhaarImagePath, 1);
    // String? panImageError = ValidationUtil.validateImage(panImagePath, 2);
    // String? chequeImageError = ValidationUtil.validateImage(chequeImagePath, 3);
    // String? rcImageError = ValidationUtil.validateImage(rcHOLDERImagePath, 4);
    // String? propertyImageError =
    //     ValidationUtil.validateImage(propertyDocImagePath, 5);
    // String? passbookImageError =
    //     ValidationUtil.validateImage(passBookImagePath, 6);
    // String? signatureImageError =
    //     ValidationUtil.validateImage(signatureImagePath, 7);
    // String? houseImageError = ValidationUtil.validateImage(houseImagePath, 9);

    String? referenceError =
        ValidationUtil.validateReferenceName(_referenceController.text);
    // String? agentNameError =
    //     ValidationUtil.validateAgentName(_agentNameController.text);

    String? agentNumError =
        ValidationUtil.validateAgentNumber(_agentNameController.text);

    String? verifiedAgentError =
        ValidationUtil.validateByAgentName(_referenceController.text);
    String? reasonError =
        ValidationUtil.validateWithdrawReason(_reasonController.text);

    String? guarantorNameError = ValidationUtil.validateGuarantorName(
        _guarantorNameController.text, widget.type);
    String? guarantorMobileError = ValidationUtil.validateGuarantorMobileNumber(
        _guarantorPhNumController.text, widget.type);
    String? guarantorAltMobileError =
        ValidationUtil.validateGuarantorAltMobileNumber(
            _guarantorAltPhNumController.text, _guarantorPhNumController.text);
    String? guarantorEmailError = ValidationUtil.validateGuarantorEmailAddress(
        _guarantorEmailController.text, widget.type);
    String? guarantorPermanentAddressError = ValidationUtil.validateLocation(
        _guarantorAddressController.text, 6,
        pageType: widget.type);
    String? guarantorAadhaarError = ValidationUtil.validateGuarantorAadhaar(
      _guarantorAadhaarNumController.text,
      widget.type,
    );
    String? guarantorPanError =
        ValidationUtil.validateGuarantorPAN(_guarantorPanNumController.text);
    String? guarantorChequeNumError =
        ValidationUtil.validateGuarantorChequeNumber(
            _guarantorChequeNumController.text, widget.type);

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      // if (
      //   photoImagePath != null &&
      //     photoImagePath!.isNotEmpty &&
      //     aadhaarImagePath != null &&
      //     aadhaarImagePath!.isNotEmpty &&
      //     panImagePath != null &&
      //     panImagePath!.isNotEmpty &&
      //     passBookImagePath != null &&
      //     passBookImagePath!.isNotEmpty &&
      //     signatureImagePath != null &&
      //     signatureImagePath!.isNotEmpty &&
      //     (((((widget.type != "1") || (widget.type != "2")) ||
      //             (selectedDocValue.value == "Personal") &&
      //                 _chequeNumController.text.isNotEmpty)) ||
      //         (((widget.type != "1") || (widget.type != "2")) ||
      //             ((selectedDocValue.value == "Vehicle") &&
      //                 rcHOLDERImagePath != null &&
      //                 rcHOLDERImagePath!.isNotEmpty)) ||
      //         (((widget.type != "1") || (widget.type != "2")) ||
      //             ((selectedDocValue.value == "Property") &&
      //                 propertyDocImagePath != null &&
      //                 propertyDocImagePath!.isNotEmpty)))) {

      var result;
      if (widget.type == "1") {
        result = await NetworkService().updateGroupIndividualCustomerDetails(
            userName: _nameController.text,
            fatherName: _fatherNameController.text,
            mobNum: _phNumController.text,
            altMobNum: _altPhNumController.text,
            emailAddress: _emailController.text,
            streetAddress: _streetAddressController.text,
            landMark: _landMarkController.text,
            city: _cityController.text,
            state: _stateController.text,
            zipCode: _zipController.text,
            country: _countryController.text,
            aadhaarImage: aadhaarImagePath ?? "",
            panImage: panImagePath ?? "",
            reference: _referenceController.text,
            type: widget.type,
            referenceNumber: _referenceNumController.text,
            panNumber: _panController.text,
            aadhaarNumber: _aadhaarController.text,
            rcHolderName: _rcHolderNameController.text,
            rcImage: rcHOLDERImagePath ?? "",
            propertyDocImage: propertyDocImagePath,
            propertyDetails: _propertyDetailsController.text,
            propertyHolderName: _propertyHolderNameController.text,
            chequeNumber: _chequeNumController.text,
            bankName: _bankNameController.text,
            bankBranchName: _bankBranchController.text,
            bankIFSCCode: _bankIFSCcodeController.text,
            accNumber: _accNumController.text,
            passbookImage: passBookImagePath,
            signatureImage: signatureImagePath,
            buildingImagePath1: building1ImagePath,
            buildingImagePath2: buildingImage2Path,
            buildingImagePath3: building3ImagePath,
            buildingImagePath4: building4ImagePath,
            buildingImagePath5: building5ImagePath,
            buildingImagePath6: building6ImagePath,
            buildingImagePath7: building7ImagePath,
            buildingStreetImagePath: buildingStreetImagePath,
            buildingAreaImagePath: buildingAreaImagePath,
            permanentAddress: _permanentAddressController.text,
            agentName: _agentNameController.text,
            photoImagePath: photoImagePath,
            locLink: _locationLinkController.text,
            workLocationLink: _workLocationLinkController.text,
            guarantorName: _guarantorNameController.text,
            guarantorMobNum: _guarantorPhNumController.text,
            guarantorAltMobNum: _guarantorAltPhNumController.text,
            guarantorEmailAddress: _guarantorEmailController.text,
            guarantorAddress: _guarantorAddressController.text,
            guarantorAadhaar: _guarantorAadhaarNumController.text,
            guarantorPan: _guarantorPanNumController.text,
            guarantorChequeNum: _guarantorChequeNumController.text,
            docType: selectedDocValue.value,
            houseImage: houseImagePath);
      } else if (widget.type == "2") {
        result = await NetworkService().updateGroupIndividualCustomerDetails(
          userName: _nameController.text,
          fatherName: _fatherNameController.text,
          mobNum: _phNumController.text,
          altMobNum: _altPhNumController.text,
          emailAddress: _emailController.text,
          streetAddress: _streetAddressController.text,
          landMark: _landMarkController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
          country: _countryController.text,
          aadhaarImage: aadhaarImagePath ?? "",
          panImage: panImagePath ?? "",
          panNumber: _panController.text,
          aadhaarNumber: _aadhaarController.text,
          rcHolderName: _rcHolderNameController.text,
          rcImage: rcHOLDERImagePath ?? "",
          propertyDocImage: propertyDocImagePath,
          propertyDetails: _propertyDetailsController.text,
          propertyHolderName: _propertyHolderNameController.text,
          chequeNumber: _chequeNumController.text,
          bankName: _bankNameController.text,
          bankBranchName: _bankBranchController.text,
          bankIFSCCode: _bankIFSCcodeController.text,
          accNumber: _accNumController.text,
          passbookImage: passBookImagePath,
          signatureImage: signatureImagePath,
          type: widget.type,
          buildingImagePath1: building1ImagePath,
          buildingImagePath2: buildingImage2Path,
          buildingImagePath3: building3ImagePath,
          buildingImagePath4: building4ImagePath,
          buildingImagePath5: building5ImagePath,
          buildingImagePath6: building6ImagePath,
          buildingImagePath7: building7ImagePath,
          buildingStreetImagePath: buildingStreetImagePath,
          buildingAreaImagePath: buildingAreaImagePath,
          permanentAddress: _permanentAddressController.text,
          agentName: _agentNameController.text,
          photoImagePath: photoImagePath,
          locLink: _locationLinkController.text,
          workLocationLink: _workLocationLinkController.text,
          guarantorName: _guarantorNameController.text,
          guarantorMobNum: _guarantorPhNumController.text,
          guarantorAltMobNum: _guarantorAltPhNumController.text,
          guarantorEmailAddress: _guarantorEmailController.text,
          guarantorAddress: _guarantorAddressController.text,
          guarantorAadhaar: _guarantorAadhaarNumController.text,
          guarantorPan: _guarantorPanNumController.text,
          guarantorChequeNum: _guarantorChequeNumController.text,
          docType: selectedDocValue.value,
          houseImage: houseImagePath,
        );
      } else if (widget.type == "3") {
        result = await NetworkService().updateKYCDetails(
          type:
              "3", // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
          userName: _nameController.text,
          fatherName: _fatherNameController.text,
          mobNum: _phNumController.text,
          altMobNum: _altPhNumController.text,
          emailAddress: _emailController.text,
          streetAddress: _streetAddressController.text,
          landMark: _landMarkController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
          country: _countryController.text,
          aadhaarImage: aadhaarImagePath ?? "",
          panImage: panImagePath ?? "",
          panNumber: _panController.text,
          aadhaarNumber: _aadhaarController.text,
          rcHolderName: _rcHolderNameController.text,
          rcImage: rcHOLDERImagePath ?? "",
          propertyDocImage: propertyDocImagePath,
          propertyDetails: _propertyDetailsController.text,
          propertyHolderName: _propertyHolderNameController.text,
          chequeNumber: _chequeNumController.text,
          bankName: _bankNameController.text,
          bankBranchName: _bankBranchController.text,
          bankIFSCCode: _bankIFSCcodeController.text,
          accNumber: _accNumController.text,
          passbookImage: passBookImagePath,
          signatureImage: signatureImagePath,
          reason: _reasonController.text,
          reference: _referenceController.text,
          isVerified: (isVerified == true) ? true : false,
          customerID: widget.id,
          referenceNum: _referenceNumController.text,
          buildingImagePath1: building1ImagePath,
          buildingImagePath2: buildingImage2Path,
          buildingImagePath3: building3ImagePath,
          buildingImagePath4: building4ImagePath,
          buildingImagePath5: building5ImagePath,
          buildingImagePath6: building6ImagePath,
          buildingImagePath7: building7ImagePath,
          buildingStreetImagePath: buildingStreetImagePath,
          buildingAreaImagePath: buildingAreaImagePath,
          permanentAddress: _permanentAddressController.text,
          agentName: _agentNameController.text,
          photoImagePath: photoImagePath,
          locLink: _locationLinkController.text,
          workLocationLink: _workLocationLinkController.text,
          guarantorName: _guarantorNameController.text,
          guarantorMobNum: _guarantorPhNumController.text,
          guarantorAltMobNum: _guarantorAltPhNumController.text,
          guarantorEmailAddress: _guarantorEmailController.text,
          guarantorAddress: _guarantorAddressController.text,
          guarantorAadhaar: _guarantorAadhaarNumController.text,
          guarantorPan: _guarantorPanNumController.text,
          guarantorChequeNum: _guarantorChequeNumController.text,
          docType: selectedDocValue.value,
          houseImage: houseImagePath,
        );
      } else {
        result = await NetworkService().updateKYCDetails(
          type: "0",
          userName: _nameController.text,
          fatherName: _fatherNameController.text,
          mobNum: _phNumController.text,
          altMobNum: _altPhNumController.text,
          emailAddress: _emailController.text,
          streetAddress: _streetAddressController.text,
          landMark: _landMarkController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipController.text,
          country: _countryController.text,
          aadhaarImage: aadhaarImagePath ?? "",
          panImage: panImagePath ?? "",
          panNumber: _panController.text,
          aadhaarNumber: _aadhaarController.text,
          rcHolderName: _rcHolderNameController.text,
          rcImage: rcHOLDERImagePath ?? "",
          propertyDocImage: propertyDocImagePath,
          houseImage: propertyDocImagePath,
          propertyDetails: _propertyDetailsController.text,
          propertyHolderName: _propertyHolderNameController.text,
          chequeNumber: _chequeNumController.text,
          bankName: _bankNameController.text,
          bankBranchName: _bankBranchController.text,
          bankIFSCCode: _bankIFSCcodeController.text,
          accNumber: _accNumController.text,
          passbookImage: passBookImagePath,
          signatureImage: signatureImagePath,
          buildingImagePath1: building1ImagePath,
          buildingImagePath2: buildingImage2Path,
          buildingImagePath3: building3ImagePath,
          buildingImagePath4: building4ImagePath,
          buildingImagePath5: building5ImagePath,
          buildingImagePath6: building6ImagePath,
          buildingImagePath7: building7ImagePath,
          buildingStreetImagePath: buildingStreetImagePath,
          buildingAreaImagePath: buildingAreaImagePath,
          permanentAddress: _permanentAddressController.text,
          agentName: _agentNameController.text,
          photoImagePath: photoImagePath,
          locLink: _locationLinkController.text,
          workLocationLink: _workLocationLinkController.text,
          docType: selectedDocValue.value,
        );
      }

      if (result != null && result['status'] == true) {
        if (!mounted) return;
        if (result['message'] != null && result['message'].isNotEmpty) {
          ToastUtil().showSnackBar(
            context: context,
            message: result['message'],
            isError: false,
          );
        }

        Future.delayed(const Duration(seconds: 1)).then((value) {
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
        });
      } else {
        if (!mounted) return;
        ToastUtil().showSnackBar(
          context: context,
          message: result['message'] ?? "Something went wrong",
          isError: true,
        );
      }
      // }
      // else if (photoImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: photoImageError,
      //     isError: true,
      //   );
      // } else if (aadhaarImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: aadhaarImageError,
      //     isError: true,
      //   );
      // } else if (panImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: panImageError,
      //     isError: true,
      //   );
      // } else if (passbookImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: passbookImageError,
      //     isError: true,
      //   );
      // } else if (signatureImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: signatureImageError,
      //     isError: true,
      //   );
      // } else if (houseImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: houseImageError,
      //     isError: true,
      //   );
      // } else if ((selectedDocValue.value == "Vehicle") &&
      //     (rcImageError != null)) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: rcImageError,
      //     isError: true,
      //   );
      // } else if ((selectedDocValue.value == "Property") &&
      //     (propertyImageError != null)) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: propertyImageError,
      //     isError: true,
      //   );
      // }
    } else {
      // Check for individual errors and focus accordingly
      if (nameError != null) {
        _showErrorAndFocus(_nameFocusNode, nameError);
      } else if (fatherNameError != null) {
        _showErrorAndFocus(_fatherNameFocusNode, fatherNameError);
      } else if (mobileError != null) {
        _showErrorAndFocus(_phNumFocusNode, mobileError);
      } else if (altMobileError != null) {
        _showErrorAndFocus(_altPhNumFocusNode, altMobileError);
      } else if (emailError != null) {
        _showErrorAndFocus(_emailFocusNode, emailError);
      } else if (permanentAddressError != null) {
        _showErrorAndFocus(_permanentAddressFocusNode, permanentAddressError);
      } else if (streetAddressError != null) {
        _showErrorAndFocus(_streetAddressFocusNode, streetAddressError);
      } else if (landmarkError != null) {
        _showErrorAndFocus(_landmarkFocusNode, landmarkError);
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
      } else if ((selectedDocValue.value == "Personal") &&
          (chequeNumError != null)) {
        _showErrorAndFocus(_chequeNumFocusNode, chequeNumError);
      } else if (bankNameError != null) {
        _showErrorAndFocus(_bankNameFocusNode, bankNameError);
      } else if (accNumError != null) {
        _showErrorAndFocus(_bankAccNumFocusNode, accNumError);
      } else if (((widget.type != "1") && (widget.type != "2")) &&
          (selectedDocValue.value == "Select Document Type")) {
        ToastUtil().showSnackBar(
          context: context,
          message: "Select Document Type",
          isError: true,
        );
      } else if ((selectedDocValue.value == "Vehicle") &&
          (rcHolderNameError != null)) {
        _showErrorAndFocus(_rcHolderNameFocusNode, rcHolderNameError);
      } else if ((selectedDocValue.value == "Property") &&
          (propertyHolderNameError != null)) {
        _showErrorAndFocus(
            _propertyHolderNameFocusNode, propertyHolderNameError);
      } else if ((selectedDocValue.value == "Property") &&
          (propertyDetailsError != null)) {
        _showErrorAndFocus(_propertyDetailsFocusNode, propertyDetailsError);
      } else if ((widget.type == "1") && referenceError != null) {
        _showErrorAndFocus(_referenceFocusNode, referenceError);
      } else if ((widget.type == "1") && agentNumError != null) {
        _showErrorAndFocus(_agentNameFocusNode, agentNumError);
      } else if ((widget.type == "2") && agentNumError != null) {
        _showErrorAndFocus(_agentNameFocusNode, agentNumError);
      } else if ((widget.type == "3") && verifiedAgentError != null) {
        _showErrorAndFocus(_referenceFocusNode, verifiedAgentError);
      } else if ((widget.type == "3") &&
          (isRejected == true) &&
          reasonError != null) {
        _showErrorAndFocus(_reasonFocusNode, reasonError);
      }
      // else if (bankIFSCError != null) {
      //   _showErrorAndFocus(_bankIFSCCodeFocusNode, bankIFSCError);
      // }
      else if (bankBranchError != null) {
        _showErrorAndFocus(_bankBranchFocusNode, bankBranchError);
      }
      // else if (photoImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: photoImageError,
      //     isError: true,
      //   );
      // } else if (aadhaarImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: aadhaarImageError,
      //     isError: true,
      //   );
      // } else if (panImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: panImageError,
      //     isError: true,
      //   );
      // } else if (passbookImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: passbookImageError,
      //     isError: true,
      //   );
      // } else if (signatureImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: signatureImageError,
      //     isError: true,
      //   );
      // } else if (houseImageError != null) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: houseImageError,
      //     isError: true,
      //   );
      // } else if ((selectedDocValue.value == "Vehicle") &&
      //     (rcImageError != null)) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: rcImageError,
      //     isError: true,
      //   );
      // } else if ((selectedDocValue.value == "Property") &&
      //     (propertyImageError != null)) {
      //   ToastUtil().showSnackBar(
      //     context: context,
      //     message: propertyImageError,
      //     isError: true,
      //   );
      // }

      else if ((widget.type != "0") ||
          (widget.type != "1") ||
          (widget.type != "2")) {
        if (guarantorNameError != null) {
          _showErrorAndFocus(_guarantorNameFocusNode, guarantorNameError);
        } else if (guarantorMobileError != null) {
          _showErrorAndFocus(_guarantorPhNumFocusNode, guarantorMobileError);
        } else if (guarantorAltMobileError != null) {
          _showErrorAndFocus(
              _guarantorAltPhNumFocusNode, guarantorAltMobileError);
        } else if (guarantorEmailError != null) {
          _showErrorAndFocus(_guarantorEmailFocusNode, guarantorEmailError);
        } else if (guarantorPermanentAddressError != null) {
          _showErrorAndFocus(
              _guarantorAddressFocusNode, guarantorPermanentAddressError);
        } else if (guarantorAadhaarError != null) {
          _showErrorAndFocus(
              _guarantorAadhaarNumFocusNode, guarantorAadhaarError);
        } else if (guarantorPanError != null) {
          _showErrorAndFocus(_guarantorPanNumFocusNode, guarantorPanError);
        } else if (guarantorChequeNumError != null) {
          _showErrorAndFocus(
              _guarantorChequeNumFocusNode, guarantorChequeNumError);
        }
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

  /* Capture Picture */
  Future<List<File>> capturePhoto(
      {required maxImagesCount,
      required BuildContext? context,
      required List<File> compressedPhotosList,
      required int type, // 1: means  default, 2 : means only picture
      required String screenName}) async {
    try {
      RegExp regExpImg = RegExp(
        r'.png|.jp|.heic',
        caseSensitive: false,
        multiLine: false,
      );
      Map<Permission, PermissionStatus> permissionStatus;
      bool isGrantedPermission = false;
      permissionStatus = await permissionServices(
        permissionRequestList: [
          Permission.camera,
          if (type != 2) Permission.microphone,
        ],
      );
      isGrantedPermission = ((type != 2)
          ? (permissionStatus[Permission.camera]!.isGranted &&
              permissionStatus[Permission.microphone]!.isGranted)
          : (permissionStatus[Permission.camera]!.isGranted));

      if (isGrantedPermission) {
        PrintUtil().printMsg("enter granted");
        if (maxImagesCount == 1) {
          compressedPhotosList = [];
        }
        if (compressedPhotosList.length != maxImagesCount) {
          List photosList = [];
          Map<String, dynamic> data = {};
          data = {
            "type": type,
          };

          var res = await Navigator.pushNamed(
            context!,
            RoutingConstants.routeCapturePhotoCamera,
            arguments: {'data': data},
          );
          print("Result: $res");
          if (res != null) {
            photosList.add(res);
          }

          if (photosList.isNotEmpty) {
            for (int i = 0; i < photosList.length; i++) {
              if (!regExpImg.hasMatch(photosList[i].split('/').last)) {
                // ignore: use_build_context_synchronously
                ToastUtil().showSnackBar(
                    context: context,
                    message: "Invalid file format",
                    isError: true);
              } else {
                PrintUtil().printMsg("photoCompressedFile: ${photosList[i]}");
                XFile? photoCompressedFile =
                    await compressImage(File(photosList[i]));
                PrintUtil().printMsg(
                    "photoCompressedFile: ${photoCompressedFile?.path}");
                compressedPhotosList.insert(
                  0,
                  File(photoCompressedFile?.path ?? ""),
                );
              }
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

  /* Alert Dialog for Updating KYC Docs */
  void showDocsAlertDialog({
    required BuildContext context,
    required Function onCaptureAction,
    required Function onGalleryAction,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 40.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  16.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCaptureAction();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Capture a Photo',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: ColorConstants.blackColor,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onGalleryAction();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Pick from Gallery',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: ColorConstants.blackColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Dismiss',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  /* Alert Dialog for Updating KYC Docs */

  Future<void> _pasteText(BuildContext context) async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text != null) {
      _locationLinkController.text = clipboardData!.text!;
      ToastUtil().showSnackBar(
        context: context,
        message: 'Pasted from clipboard!',
        isError: false,
      );
    } else {
      ToastUtil().showSnackBar(
        context: context,
        message: 'Clipboard is empty',
        isError: false,
      );
    }
  }

  Future<void> _pasteWorkLocLinkText(BuildContext context) async {
    final clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData?.text != null) {
      _workLocationLinkController.text = clipboardData!.text!;
      ToastUtil().showSnackBar(
        context: context,
        message: 'Pasted from clipboard!',
        isError: false,
      );
    } else {
      ToastUtil().showSnackBar(
        context: context,
        message: 'Clipboard is empty',
        isError: false,
      );
    }
  }
}
