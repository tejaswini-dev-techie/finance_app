part of 'transaction_details_bloc.dart';

@immutable
sealed class TransactionDetailsEvent {}

class GetTransactionDetailsEvent extends TransactionDetailsEvent {
  final List<TransactionHistList>? oldTransactionHistoryList;
  final int? page;
  final bool? showLoading;
  final String? type;

  GetTransactionDetailsEvent({
    this.oldTransactionHistoryList,
    this.page,
    this.showLoading,
    required this.type,
  });
}
