part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardLoaded extends DashboardState {}

final class DashboardNoInternet extends DashboardState {}

final class DashboardError extends DashboardState {}
