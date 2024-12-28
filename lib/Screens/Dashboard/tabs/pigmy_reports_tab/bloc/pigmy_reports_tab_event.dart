part of 'pigmy_reports_tab_bloc.dart';

@immutable
sealed class PigmyReportsTabEvent {}

class GetPigmyReports extends PigmyReportsTabEvent {
  final List<ReportList>? oldReportList;
  final int? page;
  final bool? showLoading;
  final String? type;

  GetPigmyReports({
    this.oldReportList,
    this.page,
    this.showLoading,
    required this.type,
  });
}
