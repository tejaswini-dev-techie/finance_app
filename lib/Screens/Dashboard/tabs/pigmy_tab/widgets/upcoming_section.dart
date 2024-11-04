import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/DataModel/Dashboard/pigmy_data_model.dart';
import 'package:sizer/sizer.dart';

class UpcomingSection extends StatefulWidget {
  final String? upcomingText;
  final List<UpcomingList>? upcomingList;
  const UpcomingSection(
      {super.key, required this.upcomingText, required this.upcomingList});

  @override
  State<UpcomingSection> createState() => _UpcomingSectionState();
}

class _UpcomingSectionState extends State<UpcomingSection> {
  @override
  Widget build(BuildContext context) {
    return (widget.upcomingList != null && widget.upcomingList!.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Text(
                  widget.upcomingText ?? 'Upcoming',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.blackColor,
                  ),
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.upcomingList!.length,
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
                              widget.upcomingList![index].title ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.darkBlueColor,
                              ),
                            ),
                            Text(
                              widget.upcomingList![index].subtitle ?? "",
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
                              widget.upcomingList![index].amt ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.darkBlueColor,
                              ),
                            ),
                            (widget.upcomingList![index].payNowText != null &&
                                    widget.upcomingList![index].payNowText!
                                        .isNotEmpty)
                                ? Container(
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
                                      widget.upcomingList![index].payNowText ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstants.whiteColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
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
          )
        : const SizedBox.shrink();
  }
}
