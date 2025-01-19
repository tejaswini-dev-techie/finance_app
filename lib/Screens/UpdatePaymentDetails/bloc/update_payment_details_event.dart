part of 'update_payment_details_bloc.dart';

@immutable
sealed class UpdatePaymentDetailsEvent {}

class GetPaymentDetailsEvent extends UpdatePaymentDetailsEvent {
  final String? cusID;
  final String? type;
  final String? amtType;
  final bool? showLoader;

  GetPaymentDetailsEvent({
    required this.cusID,
    required this.type,
    this.amtType = "EMI",
    this.showLoader = false,
  });
}
