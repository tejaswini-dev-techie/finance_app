import 'package:flutter/material.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/group_pigmy_tab/bloc/group_pigmy_bloc.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/info_cards.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/pigmy_withdrawal_status.dart';
import 'package:hp_finance/Screens/Dashboard/tabs/pigmy_tab/widgets/upcoming_section.dart';
import 'package:sizer/sizer.dart';

class GroupPigmyScreen extends StatelessWidget {
  final Widget? learnAboutPigmySavingsWidget;
  final String? titleText;
  final String? subTitleText;
  final String? btnText;
  final String? internetAlert;
  final Function onContactAction;
  final GroupPigmyBloc groupPigmyBloc;

  const GroupPigmyScreen({
    super.key,
    required this.learnAboutPigmySavingsWidget,
    required this.titleText,
    required this.subTitleText,
    required this.btnText,
    required this.internetAlert,
    required this.onContactAction,
    required this.groupPigmyBloc,
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
          (groupPigmyBloc.pigmyData?.pigmyMenusList != null &&
                  groupPigmyBloc.pigmyData!.pigmyMenusList!.isNotEmpty)
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupPigmyBloc.pigmyData?.pigmyMenusList!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.sp,
                    mainAxisSpacing: 16.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InfoCards(
                      pigmyMenuDet:
                          groupPigmyBloc.pigmyData?.pigmyMenusList![index],
                    );
                  },
                )
              : const SizedBox.shrink(),
          /* Info Cards */

          /* Learn About Pigmy Savings */
          learnAboutPigmySavingsWidget ?? const SizedBox.shrink(),
          /* Learn About Pigmy Savings */

          /* Pigmy Withdrawal Status Widget */
          (groupPigmyBloc.pigmyData?.showPigmyStatusNudge != null &&
                  groupPigmyBloc.pigmyData?.showPigmyStatusNudge == true)
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
          (groupPigmyBloc.pigmyData?.upcomingList != null &&
                  groupPigmyBloc.pigmyData!.upcomingList!.isNotEmpty)
              ? UpcomingSection(
                  upcomingText: groupPigmyBloc.pigmyData?.upcomingText ?? "",
                  upcomingList: groupPigmyBloc.pigmyData?.upcomingList ?? [],
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
