import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/bloc/loans_bloc.dart';
import 'package:sizer/sizer.dart';

class LoansUpcomingSection extends StatefulWidget {
  final Function onRepayAllAction;
  final LoansBloc loansBloc;

  const LoansUpcomingSection({
    super.key,
    required this.onRepayAllAction,
    required this.loansBloc,
  });

  @override
  State<LoansUpcomingSection> createState() => _LoansUpcomingSectionState();
}

class _LoansUpcomingSectionState extends State<LoansUpcomingSection> {
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
                  widget.loansBloc.loanData?.upcomingText ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.blackColor,
                  ),
                ),
              ),
              (widget.loansBloc.loanData?.repayAllText != null &&
                      widget.loansBloc.loanData!.repayAllText!.isNotEmpty)
                  ? Flexible(
                      child: InkWell(
                        onTap: () => widget.onRepayAllAction(),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: widget.loansBloc.loanData?.repayAllText ??
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
          itemCount: widget.loansBloc.loanData!.upcomingList!.length,
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
                        widget.loansBloc.loanData!.upcomingList![index].title ??
                            "",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                      Text(
                        widget.loansBloc.loanData!.upcomingList![index]
                                .subtitle ??
                            "",
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
                        widget.loansBloc.loanData!.upcomingList![index].amt ??
                            "",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.darkBlueColor,
                        ),
                      ),
                      (widget.loansBloc.loanData!.upcomingList![index]
                                      .payNowTex !=
                                  null &&
                              widget.loansBloc.loanData!.upcomingList![index]
                                  .payNowTex!.isNotEmpty)
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
                                widget.loansBloc.loanData!.upcomingList![index]
                                        .payNowTex ??
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
    );
  }
}
