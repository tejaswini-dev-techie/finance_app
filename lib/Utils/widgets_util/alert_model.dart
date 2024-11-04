import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:sizer/sizer.dart';

popupAlertDialog({
  required BuildContext context,
  required String? primaryButtonText,
  required String? secondaryButtonText,
  required Function onPrimaryButtonTap,
  required Function onSecondaryButtonTap,
  required String? imagePath,
  double? imageWidth,
  double? imageHeight,
  required String? titleText,
  required String? subTitleText,
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
                  (imagePath != null && imagePath.isNotEmpty)
                      ? Image.asset(
                          fit: BoxFit.fill,
                          imagePath,
                          width: imageWidth ?? 160.sp,
                          height: imageHeight ?? 120.sp,
                        )
                      : const SizedBox.shrink(),
                  (imagePath != null && imagePath.isNotEmpty)
                      ? SizedBox(
                          height: 12.sp,
                        )
                      : const SizedBox.shrink(),
                  Text(
                    titleText ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: ColorConstants.blackColor,
                    ),
                  ),
                  (subTitleText != null && subTitleText.isNotEmpty)
                      ? SizedBox(
                          height: 3.sp,
                        )
                      : const SizedBox.shrink(),
                  (subTitleText != null && subTitleText.isNotEmpty)
                      ? Text(
                          subTitleText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: ColorConstants.lightBlackColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: 6.sp,
                  ),
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
