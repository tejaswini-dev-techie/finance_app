part of 'pigmy_history_bloc.dart';

@immutable
sealed class PigmyHistoryEvent {}

class GetPigmyTransactionDetailsEvent extends PigmyHistoryEvent {
  final List<PigmyHistList>? oldPigmyHistoryList;
  final int? page;
  final bool? showLoading;

  GetPigmyTransactionDetailsEvent(
      {this.oldPigmyHistoryList, this.page, this.showLoading});
}
