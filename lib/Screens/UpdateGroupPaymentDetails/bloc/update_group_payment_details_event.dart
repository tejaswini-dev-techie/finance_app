part of 'update_group_payment_details_bloc.dart';

@immutable
sealed class UpdateGroupPaymentDetailsEvent {}

class GetPaymentDetailsEvent extends UpdateGroupPaymentDetailsEvent {
  final String? cusID;
  final String? type;

  GetPaymentDetailsEvent({
    required this.cusID,
    required this.type,
  });
}
