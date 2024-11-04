import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Constants/image_constants.dart';
import 'package:hp_finance/Utils/widgets_util/button_widget_util.dart';
import 'package:sizer/sizer.dart';

class NoLoansYet extends StatelessWidget {
  final String? enquireNowText;
  final String? noLoansTitleText;
  final String? noLoansSubTitleText;
  final String? internetAlert;
  final Function onEnquireNowAction;

  const NoLoansYet({
    super.key,
    required this.enquireNowText,
    required this.noLoansTitleText,
    required this.noLoansSubTitleText,
    required this.onEnquireNowAction,
    required this.internetAlert,
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
                  ImageConstants.noLoansImage,
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
              noLoansTitleText ?? "",
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
              noLoansSubTitleText ?? "",
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
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: buttonWidgetHelperUtil(
              isDisabled: false,
              buttonText: enquireNowText ?? "",
              onButtonTap: () => onEnquireNowAction(),
              context: context,
              internetAlert: internetAlert,
              borderradius: 8.sp,
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
        ],
      ),
    );
  }
}
