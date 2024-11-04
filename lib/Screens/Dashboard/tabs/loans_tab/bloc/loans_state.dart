part of 'loans_bloc.dart';

@immutable
sealed class LoansState {}

final class LoansLoading extends LoansState {}

final class LoansLoaded extends LoansState {}

final class LoansNoInternet extends LoansState {}

final class LoansError extends LoansState {}
