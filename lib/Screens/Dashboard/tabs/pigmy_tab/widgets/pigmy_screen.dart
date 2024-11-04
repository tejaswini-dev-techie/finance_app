import 'package:flutter/material.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/bloc/pigmy_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/info_cards.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_withdrawal_status.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/upcoming_section.dart';
import 'package:sizer/sizer.dart';

class PigmyScreen extends StatelessWidget {
  final Widget? learnAboutPigmySavingsWidget;
  final String? titleText;
  final String? subTitleText;
  final String? btnText;
  final String? internetAlert;
  final Function onContactAction;
  final PigmyBloc pigmyBloc;

  const PigmyScreen({
    super.key,
    required this.learnAboutPigmySavingsWidget,
    required this.titleText,
    required this.subTitleText,
    required this.btnText,
    required this.internetAlert,
    required this.onContactAction,
    required this.pigmyBloc,
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
          (pigmyBloc.pigmyData?.pigmyMenusList != null &&
                  pigmyBloc.pigmyData!.pigmyMenusList!.isNotEmpty)
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pigmyBloc.pigmyData?.pigmyMenusList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.sp,
                    mainAxisSpacing: 16.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InfoCards(
                      pigmyMenuDet: pigmyBloc.pigmyData?.pigmyMenusList![index],
                    );
                  },
                )
              : const SizedBox.shrink(),
          /* Info Cards */

          /* Learn About Pigmy Savings */
          learnAboutPigmySavingsWidget ?? const SizedBox.shrink(),
          /* Learn About Pigmy Savings */

          /* Pigmy Withdrawal Status Widget */
          (pigmyBloc.pigmyData?.showPigmyStatusNudge != null &&
                  pigmyBloc.pigmyData?.showPigmyStatusNudge == true)
              ? PigmyWithdrawalStatusWidget(
                  titleText: titleText ?? "",
                  subTitleText: subTitleText ?? "",
                  btnText: btnText ?? "",
                  internetAlert: internetAlert ?? "",
                  onContactAction: onContactAction,
                )
              : const SizedBox.shrink(),
          /* Pigmy Withdrawal Status Widget */

          /* Upcoming Section */
          (pigmyBloc.pigmyData?.upcomingList != null &&
                  pigmyBloc.pigmyData!.upcomingList!.isNotEmpty)
              ? UpcomingSection(
                  upcomingText: pigmyBloc.pigmyData?.upcomingText ?? "",
                  upcomingList: pigmyBloc.pigmyData?.upcomingList ?? [],
                )
              : const SizedBox.shrink(),
          /* Upcming Section */

          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }
}
