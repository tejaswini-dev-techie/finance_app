import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:sizer/sizer.dart';

popupAlertDialog1({
  required BuildContext context,
  required String? primaryButtonText,
  required String? secondaryButtonText,
  required Function onPrimaryButtonTap,
  required Function onSecondaryButtonTap,
  required String? titleText,
  required String? internetAlert,
  bool? barrierdismissible = true,
  Widget? subWidget,
  int from = 0,
  final Function? onWillPopScope,
  int? maxlines = 1,
}) {
  showDialog(
    barrierDismissible: barrierdismissible ?? true,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () {
          if (from == 1) {
            /* In App Update WillPopScope */
            if (onWillPopScope != null) {
              onWillPopScope();
            }
            /* In App Update WillPopScope */
          }
          if (barrierdismissible != null && barrierdismissible == true) {
            Navigator.pop(context);
          }
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
                children: [
                  Text(
                    titleText ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: ColorConstants.darkBlueColor,
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  subWidget ?? const SizedBox.shrink(),
                  (primaryButtonText != null && primaryButtonText.isNotEmpty)
                      ? InkWell(
                          onTap: () {
                            onPrimaryButtonTap();
                          },
                          child: Container(
                            width: SizerUtil.width,
                            decoration: BoxDecoration(
                              color: ColorConstants.darkBlueColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.sp)),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Text(
                                  primaryButtonText,
                                  maxLines: maxlines ?? 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                    color: ColorConstants.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: 5.sp,
                  ),
                  (secondaryButtonText != null &&
                          secondaryButtonText.isNotEmpty)
                      ? InkWell(
                          onTap: () {
                            onSecondaryButtonTap();
                          },
                          child: SizedBox(
                            width: SizerUtil.width,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Text(
                                  secondaryButtonText,
                                  maxLines: maxlines ?? 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                    color: ColorConstants.darkBlueColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
