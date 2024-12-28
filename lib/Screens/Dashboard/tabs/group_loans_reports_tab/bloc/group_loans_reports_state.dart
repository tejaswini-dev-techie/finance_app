part of 'group_loans_reports_bloc.dart';

@immutable
sealed class GroupLoansReportsState {}

final class GroupLoansReportsLoading extends GroupLoansReportsState {}

final class GroupLoansReportsLoaded extends GroupLoansReportsState {}

final class GroupLoansReportsNoInternet extends GroupLoansReportsState {}

final class GroupLoansReportsError extends GroupLoansReportsState {}
