part of 'update_payment_details_bloc.dart';

@immutable
sealed class UpdatePaymentDetailsEvent {}

class GetPaymentDetailsEvent extends UpdatePaymentDetailsEvent {}
