import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/bloc/group_loans_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/widgets/group_loans_info_cards.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_loans_tab/widgets/group_loans_upcoming_section.dart';
import 'package:sizer/sizer.dart';

class GroupLoansScreen extends StatelessWidget {
  final Function onRepayAllAction;
  final Function onTransactionHistoryAction;
  final String? transactionHistoryText;
  final String? groupMembersText;
  final Function onGroupMembersAction;
  final GroupLoansBloc groupLoansBloc;

  const GroupLoansScreen({
    super.key,
    required this.onRepayAllAction,
    required this.onTransactionHistoryAction,
    required this.transactionHistoryText,
    required this.groupMembersText,
    required this.onGroupMembersAction,
    required this.groupLoansBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 10.sp,
      ),
      child: Column(
        children: [
          /* Info Cards */
          (groupLoansBloc.grouploanData?.loansMenusList != null &&
                  groupLoansBloc.grouploanData!.loansMenusList!.isNotEmpty)
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      groupLoansBloc.grouploanData!.loansMenusList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.sp,
                    mainAxisSpacing: 16.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GroupLoansInfoCards(
                      loansMenuDet:
                          groupLoansBloc.grouploanData!.loansMenusList![index],
                    );
                  },
                )
              : const SizedBox.shrink(),
          /* Info Cards */

          SizedBox(
            height: 16.sp,
          ),
          (transactionHistoryText != null && transactionHistoryText!.isNotEmpty)
              ? InkWell(
                  onTap: () => onTransactionHistoryAction(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          transactionHistoryText ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConstants.darkBlueColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.darkBlueColor,
                        size: 12.sp,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          (transactionHistoryText != null && transactionHistoryText!.isNotEmpty)
              ? SizedBox(
                  height: 8.sp,
                )
              : const SizedBox.shrink(),
          (groupMembersText != null && groupMembersText!.isNotEmpty)
              ? InkWell(
                  onTap: () => onGroupMembersAction(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          groupMembersText ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorConstants.darkBlueColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorConstants.darkBlueColor,
                        size: 12.sp,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          (groupMembersText != null && groupMembersText!.isNotEmpty)
              ? SizedBox(
                  height: 16.sp,
                )
              : const SizedBox.shrink(),

          /* Loans Upcoming Section */
          (groupLoansBloc.grouploanData?.upcomingList != null &&
                  groupLoansBloc.grouploanData!.upcomingList!.isNotEmpty)
              ? GroupLoansUpcomingSection(
                  groupLoansBloc: groupLoansBloc,
                  onRepayAllAction: () => onRepayAllAction(),
                )
              : const SizedBox.shrink(),
          /* Loans Upcming Section */

          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }
}
