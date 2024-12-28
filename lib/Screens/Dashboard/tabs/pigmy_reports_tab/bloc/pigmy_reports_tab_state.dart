part of 'pigmy_reports_tab_bloc.dart';

@immutable
sealed class PigmyReportsTabState {}

final class PigmyReportsTabLoading extends PigmyReportsTabState {}

final class PigmyReportsTabLoaded extends PigmyReportsTabState {}

final class PigmyReportsTabNoInternet extends PigmyReportsTabState {}

final class PigmyReportsTabError extends PigmyReportsTabState {}
