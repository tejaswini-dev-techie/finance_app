part of 'loans_reports_bloc.dart';

@immutable
sealed class LoansReportsEvent {}

class GetLoanReports extends LoansReportsEvent {
  final List<ReportList>? oldReportList;
  final int? page;
  final bool? showLoading;
  final String? type;

  GetLoanReports({
    this.oldReportList,
    this.page,
    this.showLoading,
    required this.type,
  });
}
