part of 'group_pigmy_reports_bloc.dart';

@immutable
sealed class GroupPigmyReportsEvent {}

class GetGroupPigmyReports extends GroupPigmyReportsEvent {
  final List<ReportList>? oldReportList;
  final int? page;
  final bool? showLoading;
  final String? type;

  GetGroupPigmyReports({
    this.oldReportList,
    this.page,
    this.showLoading,
    required this.type,
  });
}
