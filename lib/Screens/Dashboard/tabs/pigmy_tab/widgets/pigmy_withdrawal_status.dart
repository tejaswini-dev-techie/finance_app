import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class PigmyWithdrawalStatusWidget extends StatelessWidget {
  final String? titleText;
  final String? subTitleText;
  final String? btnText;
  final String? internetAlert;
  final Function onContactAction;

  const PigmyWithdrawalStatusWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.btnText,
    required this.internetAlert,
    required this.onContactAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizerUtil.width,
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      padding: EdgeInsets.symmetric(
        vertical: 11.sp,
        horizontal: 8.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        color: ColorConstants.whiteColor,
        border: Border.all(
          color: ColorConstants.lightGreyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titleText ?? "",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.blackColor,
            ),
          ),
          SizedBox(
            height: 2.sp,
          ),
          Text(
            subTitleText ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: ColorConstants.lightBlackColor,
            ),
          ),
          (btnText != null && btnText!.isNotEmpty)
              ? SizedBox(
                  height: 4.sp,
                )
              : const SizedBox.shrink(),
          (btnText != null && btnText!.isNotEmpty)
              ? buttonWidgetHelperUtil(
                  isDisabled: false,
                  buttonText: btnText ?? "",
                  onButtonTap: () => onContactAction(),
                  context: context,
                  internetAlert: internetAlert,
                  borderradius: 8.sp,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
