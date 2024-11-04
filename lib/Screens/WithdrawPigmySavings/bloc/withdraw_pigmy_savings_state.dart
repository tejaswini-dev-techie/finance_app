part of 'withdraw_pigmy_savings_bloc.dart';

@immutable
sealed class WithdrawPigmySavingsState {}

final class WithdrawPigmySavingsLoading extends WithdrawPigmySavingsState {}

final class WithdrawPigmySavingsLoaded extends WithdrawPigmySavingsState {}

final class WithdrawPigmySavingsNoInternet extends WithdrawPigmySavingsState {}

final class WithdrawPigmySavingsError extends WithdrawPigmySavingsState {}
