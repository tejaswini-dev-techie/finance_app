import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Utils/internet_util.dart';
import 'package:hp_finance/Utils/toast_util.dart';
import 'package:sizer/sizer.dart';

Widget buttonWidgetHelperUtil({
  required bool isDisabled,
  required String buttonText,
  required Function onButtonTap,
  required BuildContext context,
  required String? internetAlert,
  Function? toastError,
  double? verticalPadding,
  double? borderradius,
  double? fontsize,
  Widget? textWidget,
  Color? buttonDisabledColor,
  Color? fontDisabledColor,
  Color? btnColor,
  double? buttonWidth,
  FontWeight? fontweght,
  double? horizontalPadding,
  Color? fontColor,
  Color? btnBorderColor,
}) {
  return InkWell(
    onTap: () {
      InternetUtil().checkInternetConnection().then(
        (internet) {
          if (internet) {
            if (!isDisabled) {
              onButtonTap();
            } else {
              if (toastError != null) {
                toastError();
              }
            }
          } else {
            ToastUtil().showSnackBar(
                context: context,
                message:
                    internetAlert ?? "Please check your internet connection",
                isError: true);
          }
        },
      );
    },
    child: Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        color: isDisabled
            ? buttonDisabledColor ?? ColorConstants.lightShadeBlueColor
            : btnColor ?? ColorConstants.darkBlueColor,
        borderRadius:
            BorderRadius.all(Radius.circular(borderradius ?? 12.0.sp)),
        border:
            (btnBorderColor != null) ? Border.all(color: btnBorderColor) : null,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 11.sp,
              horizontal: horizontalPadding ?? 10.sp),
          child: (textWidget != null)
              ? textWidget
              : Text(
                  buttonText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: fontweght ?? FontWeight.w700,
                    fontSize: fontsize ?? 12.sp,
                    letterSpacing: 0.5.sp,
                    color: isDisabled
                        ? fontDisabledColor ?? ColorConstants.whiteColor
                        : fontColor ?? ColorConstants.whiteColor,
                  ),
                ),
        ),
      ),
    ),
  );
}
