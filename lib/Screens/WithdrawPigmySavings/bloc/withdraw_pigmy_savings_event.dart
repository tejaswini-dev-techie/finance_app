part of 'withdraw_pigmy_savings_bloc.dart';

@immutable
sealed class WithdrawPigmySavingsEvent {}

class WithdrawPigmySavingsDetailsEvent extends WithdrawPigmySavingsEvent {
  final String? type; /* 1 - Individual | 2 - Agent */
  final String? customerID;

  WithdrawPigmySavingsDetailsEvent({
    required this.type,
    required this.customerID,
  });
}
