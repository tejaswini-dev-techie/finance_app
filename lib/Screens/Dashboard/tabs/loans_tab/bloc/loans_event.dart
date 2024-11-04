part of 'loans_bloc.dart';

@immutable
sealed class LoansEvent {}

class GetLoanDetails extends LoansEvent {}
