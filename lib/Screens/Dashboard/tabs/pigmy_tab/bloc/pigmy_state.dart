part of 'pigmy_bloc.dart';

@immutable
sealed class PigmyState {}

final class PigmyLoading extends PigmyState {}

final class PigmyLoaded extends PigmyState {}

final class PigmyNoInternet extends PigmyState {}

final class PigmyError extends PigmyState {}
