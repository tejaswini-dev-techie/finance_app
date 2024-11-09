part of 'transaction_details_bloc.dart';

@immutable
sealed class TransactionDetailsState {}

final class TransactionDetailsLoading extends TransactionDetailsState {}

final class TransactionDetailsLoaded extends TransactionDetailsState {}

final class TransactionDetailsInternet extends TransactionDetailsState {}

final class TransactionDetailsError extends TransactionDetailsState {}
