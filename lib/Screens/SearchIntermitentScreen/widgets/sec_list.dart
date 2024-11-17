import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_intermittent_data_model.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/widgets/group_loans_info_cards.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/widgets/menu_info_cards.dart';
import 'package:sizer/sizer.dart';

class SectionList extends StatefulWidget {
  final String? title;
  final List<ListDet>? listDetails;
  final Function onPayAction;
  final List<ListDetMenu>? listMenuDetails;
  const SectionList({
    super.key,
    required this.title,
    required this.listDetails,
    required this.onPayAction,
    required this.listMenuDetails,
  });

  @override
  State<SectionList> createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  @override
  Widget build(BuildContext context) {
    return (widget.listDetails != null && widget.listDetails!.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.blackColor,
                  ),
                ),
              ),
              /* Info Cards */
              (widget.listMenuDetails != null &&
                      widget.listMenuDetails!.isNotEmpty)
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.listMenuDetails!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.sp,
                        mainAxisSpacing: 16.sp,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return MenuInfoCards(
                          menuDet: widget.listMenuDetails![index],
                        );
                      },
                    )
                  : const SizedBox.shrink(),
              /* Info Cards */

              SizedBox(
                height: 8.sp,
              ),
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.listDetails!.length,
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
                              widget.listDetails![index].title ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.darkBlueColor,
                              ),
                            ),
                            Text(
                              widget.listDetails![index].subtitle ?? "",
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
                              widget.listDetails![index].amt ?? "",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.darkBlueColor,
                              ),
                            ),
                            (widget.listDetails![index].payNowText != null &&
                                    widget.listDetails![index].payNowText!
                                        .isNotEmpty)
                                ? InkWell(
                                    onTap: () => widget.onPayAction(),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.sp,
                                        vertical: 4.sp,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.sp),
                                        color: ColorConstants.darkBlueColor,
                                        border: Border.all(
                                          color: ColorConstants.darkBlueColor,
                                        ),
                                      ),
                                      child: Text(
                                        widget.listDetails![index].payNowText ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.whiteColor,
                                        ),
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
