part of 'group_loans_reports_bloc.dart';

@immutable
sealed class GroupLoansReportsEvent {}

class GetGroupLoansReports extends GroupLoansReportsEvent {
  final List<ReportList>? oldReportList;
  final int? page;
  final bool? showLoading;
  final String? type;

  GetGroupLoansReports({
    this.oldReportList,
    this.page,
    this.showLoading,
    required this.type,
  });
}
