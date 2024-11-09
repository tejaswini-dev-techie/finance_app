part of 'pigmy_history_bloc.dart';

@immutable
sealed class PigmyHistoryState {}

final class PigmyHistoryLoading extends PigmyHistoryState {}

final class PigmyHistoryLoaded extends PigmyHistoryState {}

final class PigmyHistoryNoInternet extends PigmyHistoryState {}

final class PigmyHistoryError extends PigmyHistoryState {}
