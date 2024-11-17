part of 'group_pigmy_bloc.dart';

@immutable
sealed class GroupPigmyState {}

final class GroupPigmyLoading extends GroupPigmyState {}

final class GroupPigmyLoaded extends GroupPigmyState {}

final class GroupPigmyNoInternet extends GroupPigmyState {}

final class GroupPigmyError extends GroupPigmyState {}
