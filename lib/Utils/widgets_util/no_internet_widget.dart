import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Utils/app_language_util.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget noInternetWidget({
  required BuildContext context,
  required retryAction,
  int state = 1,
  /* 1 - No Internet State | 2 - Something went wrong */
}) {
  String? internetAlert = "Please check your internet connection";
  String? noInternetMsg = "Uh-oh! No Internet";
  String? noInteenetDesc =
      "We’re having trouble reaching the server. Please ensure you’re connected and try again.";
  String? retryBtn = "Retry";
  String? somethingWentWrongText = "Something went wrong!!";
  String? errorSubtitle =
      "An unexpected issue occurred. We’re working on fixing it. Please try again in a moment.";

  var appContent =
      Provider.of<AppLanguageUtil>(context, listen: true).appContent?['common'];
  if (appContent != null) {
    internetAlert = appContent['action_items']['internet_alert'] ?? "";
    noInternetMsg =
        appContent['action_items']['no_internet_connection_title'] ?? "";
    noInteenetDesc = appContent['action_items']['no_internet_desc'] ?? "";
    retryBtn = appContent['action_items']['retry_btn'] ?? "";
    somethingWentWrongText =
        appContent['action_items']['something_went_wrong'] ?? "";
    errorSubtitle = appContent['action_items']['error_subtitle'] ?? "";
  }

  return Material(
    color: ColorConstants.whiteColor,
    child: SizedBox(
      width: SizerUtil.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.sp,
          ),
          Container(
            width: SizerUtil.width,
            height: 250.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  (state == 1)
                      ? ImageConstants.noInternetImage
                      : ImageConstants.errorImage,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 10.0.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
            ),
            child: Text(
              (state == 1)
                  ? noInternetMsg ?? "Uh-oh! No Internet"
                  : somethingWentWrongText ?? "Oops! An Error Occurred",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0.sp,
                color: ColorConstants.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
            ),
            child: Text(
              (state == 1)
                  ? noInteenetDesc ??
                      "We’re having trouble reaching the server. Please ensure you’re connected and try again."
                  : errorSubtitle ??
                      "An unexpected issue occurred. We’re working on fixing it. Please try again in a moment.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: ColorConstants.lightBlackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ElevatedButton(
              onPressed: () {
                InternetUtil().checkInternetConnection().then(
                  (internet) async {
                    if (internet) {
                      retryAction();
                    } else {
                      ToastUtil().showSnackBar(
                        context: context,
                        message: internetAlert ??
                            "Please check your internet connection",
                        isError: true,
                      );
                    }
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.sp,
                  vertical: 4.sp,
                ),
                backgroundColor: ColorConstants.darkBlueColor,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      80.sp,
                    ),
                  ),
                ),
              ),
              child: Text(
                retryBtn ?? "",
                style: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 10.0.sp),
        ],
      ),
    ),
  );
}
