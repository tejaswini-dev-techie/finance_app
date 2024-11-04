import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:sizer/sizer.dart';

class DuesSection extends StatefulWidget {
  final List<DuesSecList>? dataList;
  final String? titleText;
  const DuesSection(
      {super.key, required this.dataList, required this.titleText});

  @override
  State<DuesSection> createState() => _DuesSectionState();
}

class _DuesSectionState extends State<DuesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
          ),
          child: Text(
            widget.titleText ?? 'Dues',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: ColorConstants.blackColor,
            ),
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.dataList!.length,
          itemBuilder: (context, index) {
            return Container(
              width: SizerUtil.width,
              padding: EdgeInsets.symmetric(
                horizontal: 8.sp,
                vertical: 4.sp,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.sp),
                color: ColorConstants.whiteColor,
                border: Border.all(
                  color: ColorConstants.lightGreyColor,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dataList![index].title ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                      Text(
                        widget.dataList![index].subtitle ?? '',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.lightBlackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 4.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.dataList![index].amt ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.sp,
                          vertical: 4.sp,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.sp),
                          color: ColorConstants.darkBlueColor,
                          border: Border.all(
                            color: ColorConstants.darkBlueColor,
                          ),
                        ),
                        child: Text(
                          widget.dataList![index].payNowTex ?? '',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 8.sp,
            );
          },
        ),
      ],
    );
  }
}
