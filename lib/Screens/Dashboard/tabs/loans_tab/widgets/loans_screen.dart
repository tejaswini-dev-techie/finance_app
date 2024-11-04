import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/color_constants.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/bloc/loans_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/widgets/loans_info_cards.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/loans_tab/widgets/loans_upcoming_section.dart';
import 'package:sizer/sizer.dart';

class LoansScreen extends StatelessWidget {
  final Function onRepayAllAction;
  final Function onTransactionHistoryAction;
  final LoansBloc loansBloc;

  const LoansScreen({
    super.key,
    required this.onRepayAllAction,
    required this.onTransactionHistoryAction,
    required this.loansBloc,
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
          (loansBloc.loanData?.loansMenusList != null &&
                  loansBloc.loanData!.loansMenusList!.isNotEmpty)
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: loansBloc.loanData!.loansMenusList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.sp,
                    mainAxisSpacing: 16.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return LoansInfoCards(
                      loansMenuDet: loansBloc.loanData!.loansMenusList![index],
                    );
                  },
                )
              : const SizedBox.shrink(),
          /* Info Cards */

          SizedBox(
            height: 16.sp,
          ),
          (loansBloc.loanData?.transactionHistoryText != null &&
                  loansBloc.loanData!.transactionHistoryText!.isNotEmpty)
              ? InkWell(
                  onTap: () => onTransactionHistoryAction(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          loansBloc.loanData?.transactionHistoryText ?? "",
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
          (loansBloc.loanData?.transactionHistoryText != null &&
                  loansBloc.loanData!.transactionHistoryText!.isNotEmpty)
              ? SizedBox(
                  height: 16.sp,
                )
              : const SizedBox.shrink(),

          /* Loans Upcoming Section */
          (loansBloc.loanData?.upcomingList != null &&
                  loansBloc.loanData!.upcomingList!.isNotEmpty)
              ? LoansUpcomingSection(
                  loansBloc: loansBloc,
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
