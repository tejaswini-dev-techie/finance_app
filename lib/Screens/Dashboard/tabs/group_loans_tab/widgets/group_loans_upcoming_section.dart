import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/bloc/group_loans_bloc.dart';
import 'package:sizer/sizer.dart';

class GroupLoansUpcomingSection extends StatefulWidget {
  final Function onRepayAllAction;
  final GroupLoansBloc groupLoansBloc;

  const GroupLoansUpcomingSection({
    super.key,
    required this.onRepayAllAction,
    required this.groupLoansBloc,
  });

  @override
  State<GroupLoansUpcomingSection> createState() =>
      _GroupLoansUpcomingSectionState();
}

class _GroupLoansUpcomingSectionState extends State<GroupLoansUpcomingSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.groupLoansBloc.grouploanData?.upcomingText ??
                      'Upcoming',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.blackColor,
                  ),
                ),
              ),
              (widget.groupLoansBloc.grouploanData?.repayAllText != null &&
                      widget.groupLoansBloc.grouploanData!.repayAllText!
                          .isNotEmpty)
                  ? Flexible(
                      child: InkWell(
                        onTap: () => widget.onRepayAllAction(),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: widget.groupLoansBloc.grouploanData
                                        ?.repayAllText ??
                                    'Repay All',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.blackColor,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 2.5.sp),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorConstants.darkBlueColor,
                                    size: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.groupLoansBloc.grouploanData!.upcomingList!.length,
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
                        widget.groupLoansBloc.grouploanData!
                                .upcomingList![index].title ??
                            '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                      Text(
                        widget.groupLoansBloc.grouploanData!
                                .upcomingList![index].subtitle ??
                            '',
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
                        widget.groupLoansBloc.grouploanData!
                                .upcomingList![index].amt ??
                            '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                   ( widget.groupLoansBloc.grouploanData!
                                  .upcomingList![index].payNowTex != null &&  widget.groupLoansBloc.grouploanData!
                                  .upcomingList![index].payNowTex!.isNotEmpty)  ? Container(
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
                          widget.groupLoansBloc.grouploanData!
                                  .upcomingList![index].payNowTex ??
                              '',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.whiteColor,
                          ),
                        ),
                      ): const SizedBox.shrink(),
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
