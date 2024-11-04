part of 'group_loans_bloc.dart';

@immutable
sealed class GroupLoansState {}

final class GroupLoansLoading extends GroupLoansState {}

final class GroupLoansLoaded extends GroupLoansState {}

final class GroupLoansNoInternet extends GroupLoansState {}

final class GroupLoansError extends GroupLoansState {}
