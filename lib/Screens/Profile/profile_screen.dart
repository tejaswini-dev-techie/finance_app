import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Network/network_service.dart';
import 'package:hp_finance/Screens/LoginScreen/text_input_field.dart';
import 'package:hp_finance/Screens/Profile/bloc/profile_bloc.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:hp_finance/Utils/validation_util.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:hp_finance/Utils/widgets_util/no_internet_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  final String? type; // type 1 - My Profile | 2 - Others Profile
  final String? customerID;
  const ProfileScreen({
    super.key,
    this.type = "1", // type 1 - My Profile | 2 - Others Profile
    this.customerID,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();

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
  /* Focus Node */

  ValueNotifier<bool> refreshInputFields = ValueNotifier<bool>(false);
  ValueNotifier<bool> isDisabled = ValueNotifier<bool>(true);

  List<File> compressedPhotosList = [];

  @override
  void initState() {
    super.initState();
    profileBloc.add(GetUserProfileDetails(
      type: widget.type, // type 1 - My Profile | 2 - Others Profile
      customerID: widget.customerID,
    ));
    _nameController.addListener(_validateFields);
    _phNumController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _altPhNumController.addListener(_validateFields);
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
    _altPhNumController.dispose();
    _emailController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _countryController.dispose();

    _nameFocusNode.dispose();
    _phNumFocusNode.dispose();
    _emailFocusNode.dispose();
    _altPhNumFocusNode.dispose();
    _streetAddressFocusNode.dispose();
    _cityFocusNode.dispose();
    _stateFocusNode.dispose();
    _zipFocusNode.dispose();
    _countryFocusNode.dispose();

    _nameController.removeListener(_validateFields);
    _phNumController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _altPhNumController.removeListener(_validateFields);
    _streetAddressController.removeListener(_validateFields);
    _cityController.removeListener(_validateFields);
    _stateController.removeListener(_validateFields);
    _zipController.removeListener(_validateFields);
    _countryController.removeListener(_validateFields);

    _scrollController.dispose();

    profileBloc.close();
  }

  backAction() {
    Navigator.pop(context);
  }

  void onResetAction() {
    InternetUtil().checkInternetConnection().then(
      (internet) async {
        if (internet) {
          Navigator.pushNamed(
              context, RoutingConstants.routeResetPasswordScreen);
        } else {
          ToastUtil().showSnackBar(
            context: context,
            message: profileBloc.internetAlert,
            isError: true,
          );
        }
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
        child: GestureDetector(
          onTap: () {
            /* Hide Keyboard */
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: profileBloc,
            builder: (context, state) {
              if (state is ProfileLoading) {
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
                            profileBloc.profileText,
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
                  body: const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkBlueColor,
                    ),
                  ),
                );
              } else if (state is ProfileLoaded) {
                _nameController.text = profileBloc.userData?.name ?? "";
                _phNumController.text = profileBloc.userData?.mobNum ?? "";
                _altPhNumController.text =
                    profileBloc.userData?.altMobNum ?? "";
                _emailController.text =
                    profileBloc.userData?.emailAddress ?? "";
                _streetAddressController.text =
                    profileBloc.userData?.streetAddress ?? "";
                _cityController.text = profileBloc.userData?.city ?? "";
                _stateController.text = profileBloc.userData?.state ?? "";
                _zipController.text = profileBloc.userData?.pincode ?? "";
                _countryController.text = profileBloc.userData?.country ?? "";

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
                            profileBloc.profileText,
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

                      (profileBloc.userData?.type == "1")
                          ? SingleChildScrollView(
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
                                        buttonText: profileBloc.saveText,
                                        onButtonTap: () => onSaveAction(),
                                        context: context,
                                        internetAlert:
                                            profileBloc.internetAlert,
                                        borderradius: 8.sp,
                                        toastError: () => onSaveAction(),
                                      );
                                    }),
                              ),
                              /* SAVE CTA */
                            )
                          : const SizedBox.shrink(),
                  body: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.sp,
                        ),
                        ValueListenableBuilder(
                            valueListenable: profileBloc.updateProfileImage,
                            builder: (context, val, _) {
                              return InkWell(
                                onTap: () {
                                  if (profileBloc.userData?.type == "1") {
                                    InternetUtil()
                                        .checkInternetConnection()
                                        .then((internet) async {
                                      if (internet) {
                                        // Upload Profile Photo
                                        compressedPhotosList = [];
                                        compressedPhotosList = await pickPhotos(
                                          maxImagesCount: 1,
                                          context: context,
                                          compressedPhotosList:
                                              compressedPhotosList,
                                          invalidFormatErrorText: "Invalid",
                                        );

                                        String? profileImagePath =
                                            await NetworkService().imageUpload(
                                          compressedPhotosList[0].path,
                                        );
                                        profileBloc.userData?.profileImg =
                                            profileImagePath ?? "";

                                        profileBloc.updateProfileImage.value =
                                            !profileBloc
                                                .updateProfileImage.value;
                                      } else {
                                        ToastUtil().showSnackBar(
                                          context: context,
                                          message: profileBloc.internetAlert,
                                          isError: true,
                                        );
                                      }
                                    });
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 40.sp,
                                      backgroundColor:
                                          ColorConstants.greyShadow,
                                      child: (profileBloc
                                                      .userData?.profileImg !=
                                                  null &&
                                              profileBloc.userData!.profileImg!
                                                  .isNotEmpty)
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40.sp),
                                              child: Image.network(
                                                profileBloc
                                                        .userData?.profileImg ??
                                                    "",
                                                fit: BoxFit.fill,
                                                width: 60.sp,
                                                height: 60.sp,
                                                filterQuality: Platform.isIOS
                                                    ? FilterQuality.medium
                                                    : FilterQuality.low,
                                                loadingBuilder:
                                                    (BuildContext? context,
                                                        Widget? child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child!;
                                                  }
                                                  return Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[400]!,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 60.sp,
                                                      height: 60.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[400]!,
                                                    enabled: true,
                                                    child: Container(
                                                      width: 60.sp,
                                                      height: 60.sp,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : (compressedPhotosList.isNotEmpty)
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40.sp),
                                                  child: Image.file(
                                                    compressedPhotosList[0],
                                                    fit: BoxFit.fill,
                                                    width: 60.sp,
                                                    height: 60.sp,
                                                  ),
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  size: 60.sp,
                                                  color: ColorConstants
                                                      .darkBlueColor,
                                                ),
                                    ),
                                    (profileBloc.userData?.type == "1")
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.5.sp,
                                                vertical: 2.sp),
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstants.darkBlueColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                4.sp,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              color: ColorConstants.whiteColor,
                                              size: 10.sp,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 10.sp,
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
                                profileBloc.profileTitleText,
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
                                profileBloc.profileSubTitleText,
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

                        /* Reset Password */
                        (profileBloc.userData?.type == "1")
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sp, vertical: 10.sp),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => onResetAction(),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: profileBloc.resetPasswordText,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.blackColor,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.5.sp),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ColorConstants.darkBlueColor,
                                              size: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        /* Reset Password */

                        /* Lookup Customer Data */
                        (profileBloc.userData?.type == "2")
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.sp, vertical: 10.sp),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    InternetUtil()
                                        .checkInternetConnection()
                                        .then((internet) {
                                      if (internet) {
                                        if (!mounted) return;
                                        Map<String, dynamic> data = {};
                                        data = {
                                          "customerID": profileBloc
                                                  .userData?.customerID ??
                                              "",
                                          "type": "1",
                                        };

                                        Navigator.pushNamed(
                                          context,
                                          RoutingConstants
                                              .routeSearchIntermittentScreen,
                                          arguments: {"data": data},
                                        );
                                      } else {
                                        if (!mounted) return;
                                        ToastUtil().showSnackBar(
                                          context: context,
                                          message: profileBloc.internetAlert,
                                          isError: true,
                                        );
                                      }
                                    });
                                  },
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              profileBloc.viewCustomerInfoText,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.blackColor,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.5.sp),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ColorConstants.darkBlueColor,
                                              size: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        /* Lokkup Customer Data */
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
                                    /* Name Input Field */
                                    Text(
                                      profileBloc.nameText,
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
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      suffixWidget: const Icon(
                                        Icons.person_pin_circle_rounded,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText:
                                          profileBloc.namePlaceHolderText,
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
                                      profileBloc.phNumText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _phNumFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.phone_locked,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText:
                                          profileBloc.phNumPlaceholderText,
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
                                      profileBloc.altPhNumText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _altPhNumFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.phone_locked,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText:
                                          profileBloc.phNumPlaceholderText,
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
                                                value, _phNumController.text);
                                      },
                                    ),
                                    /* Alternate Mobile Number Input Field */

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Email Address Input Field */
                                    Text(
                                      profileBloc.emailText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _emailFocusNode,
                                      textcapitalization:
                                          TextCapitalization.none,
                                      suffixWidget: const Icon(
                                        Icons.email,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText:
                                          profileBloc.emailPlaceholderText,
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

                                    SizedBox(
                                      height: 16.sp,
                                    ),

                                    /* Street Address Input Field*/
                                    Text(
                                      profileBloc.streetAddressText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _streetAddressFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.location_on,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText:
                                          profileBloc.streetAddressText,
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
                                      profileBloc.cityText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _cityFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.location_on,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: profileBloc.cityText,
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
                                      profileBloc.stateText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _stateFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.location_on,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: profileBloc.stateText,
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
                                      profileBloc.zipText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _zipFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.location_on,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: profileBloc.zipText,
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
                                      profileBloc.countryText,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorConstants.lightBlackColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextInputField(
                                      readOnlyValue:
                                          (profileBloc.userData?.type == "1")
                                              ? false
                                              : true,
                                      focusnodes: _countryFocusNode,
                                      suffixWidget: const Icon(
                                        Icons.location_on,
                                        color: ColorConstants.darkBlueColor,
                                      ),
                                      placeholderText: profileBloc.countryText,
                                      textEditingController: _countryController,
                                      validationFunc: (value) {
                                        return ValidationUtil.validateLocation(
                                            value, 4);
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
                );
              } else if (state is ProfileNoInternet) {
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
                            profileBloc.profileText,
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
                    retryAction: () => profileBloc.add(GetUserProfileDetails(
                      type: widget
                          .type, // type 1 - My Profile | 2 - Others Profile
                      customerID: widget.customerID,
                    )),
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
                            profileBloc.profileText,
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
                    retryAction: () => profileBloc.add(GetUserProfileDetails(
                      type: widget
                          .type, // type 1 - My Profile | 2 - Others Profile
                      customerID: widget.customerID,
                    )),
                    state: 2,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> onSaveAction() async {
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

    final form = _formKey.currentState;

    if (form?.validate() ?? false) {
      isDisabled.value = false;

      var result = await NetworkService().updateProfileDetails(
        userName: _nameController.text,
        profileImage: profileBloc.userData?.profileImg,
        mobNum: _phNumController.text,
        altMobNum: _altPhNumController.text,
        emailAddress: _emailController.text,
        streetAddress: _streetAddressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
        country: _countryController.text,
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
          if (!mounted) return;
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
