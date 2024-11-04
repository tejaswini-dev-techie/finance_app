import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Utils/print_util.dart';
import 'package:sizer/sizer.dart';

class ToastUtil {
  static final ToastUtil _toastUtilInstance = ToastUtil._internal();

  factory ToastUtil() {
    return _toastUtilInstance;
  }

  ToastUtil._internal();

  String? flushBarVal;

  showSnackBar({
    required BuildContext? context,
    required String? message,
    bool? isError = false,
     TextStyle? textStyle
  }) {
    PrintUtil().printMsg("flushBarVal: $flushBarVal");
    if (message != null && message.isNotEmpty && flushBarVal == null) {
      flushBarVal = message;
      Flushbar(
        barBlur: 0.0,
        flushbarPosition: FlushbarPosition.TOP,
        messageText: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 4.sp,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.sp,
            vertical: 8.sp,
          ),
          decoration: BoxDecoration(
            color: (isError != null && !isError)
                ? ColorConstants.greenColor
                : ColorConstants.redColor,
            borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.greyShadow,
                blurRadius: 8.sp, // soften the shadow
                spreadRadius: 2.sp, //extend the shadow
                offset: const Offset(
                  -1.5,
                  1.5,
                ),
              ),
            ],
          ),
          child: Text.rich(
            softWrap: true,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: ColorConstants.whiteColor,
            ),
            TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.sp),
                    child: Icon(
                      (isError != null && !isError)
                          ? Icons.check_circle
                          : Icons.error,
                      color: ColorConstants.whiteColor,
                      size: 16.sp,
                    ),
                  ),
                ),
                TextSpan(
                  text: message.toString(),
                  style:textStyle ?? TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: ColorConstants.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      )
          .show(context!)
          .timeout(const Duration(seconds: 3),
              onTimeout: () => flushBarVal = null)
          .then((value) => flushBarVal = null)
          .whenComplete(() => flushBarVal = null)
          .onError((error, stackTrace) => flushBarVal = null)
          .catchError((onError) => flushBarVal = null);
    }
  }
}
