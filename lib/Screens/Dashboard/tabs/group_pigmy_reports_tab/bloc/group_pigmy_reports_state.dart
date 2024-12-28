part of 'group_pigmy_reports_bloc.dart';

@immutable
sealed class GroupPigmyReportsState {}

final class GroupPigmyReportsLoading extends GroupPigmyReportsState {}

final class GroupPigmyReportsLoaded extends GroupPigmyReportsState {}

final class GroupPigmyReportsNoInternet extends GroupPigmyReportsState {}

final class GroupPigmyReportsError extends GroupPigmyReportsState {}
