import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class PigmyNotStarted extends StatelessWidget {
  final String? startNowText;
  final String? noPigmyTitleText;
  final String? noPigmySubTitleText;
  final String? footertext;
  final String? internetAlert;
  final Function onStartNowAction;
  final Function onClickHereAction;

  const PigmyNotStarted({
    super.key,
    required this.startNowText,
    required this.noPigmyTitleText,
    required this.noPigmySubTitleText,
    required this.footertext,
    required this.onStartNowAction,
    required this.internetAlert,
    required this.onClickHereAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizerUtil.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 4.sp,
          ),
          Container(
            width: SizerUtil.width,
            height: 250.sp,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstants.noPigmyImage,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
            ),
            child: Text(
              noPigmyTitleText ?? "",
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
            ),
            child: Text(
              noPigmySubTitleText ?? "",
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
          (startNowText != null && startNowText!.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: buttonWidgetHelperUtil(
                    isDisabled: false,
                    buttonText: startNowText ?? "",
                    onButtonTap: () => onStartNowAction(),
                    context: context,
                    internetAlert: internetAlert,
                    borderradius: 8.sp,
                  ),
                )
              : const SizedBox.shrink(),
          (startNowText != null && startNowText!.isNotEmpty)
              ? SizedBox(
                  height: 2.sp,
                )
              : const SizedBox.shrink(),
          (footertext != null && footertext!.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: InkWell(
                    onTap: () => onClickHereAction(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            footertext ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              color: ColorConstants.lightBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: ColorConstants.darkBlueColor,
                          size: 11.sp,
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
