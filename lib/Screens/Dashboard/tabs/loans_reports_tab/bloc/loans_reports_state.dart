part of 'loans_reports_bloc.dart';

@immutable
sealed class LoansReportsState {}

final class LoansReportsLoading extends LoansReportsState {}

final class LoansReportsLoaded extends LoansReportsState {}

final class LoansReportsNoInternet extends LoansReportsState {}

final class LoansReportsError extends LoansReportsState {}
