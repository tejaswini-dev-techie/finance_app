import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:sizer/sizer.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.blackColor,
        ),
        borderRadius: BorderRadius.circular(
          4.sp,
        ),
      ),
      child: Icon(
        Icons.check,
      ),
    );
  }
}
