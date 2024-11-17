part of 'update_payment_details_bloc.dart';

@immutable
sealed class UpdatePaymentDetailsState {}

final class UpdatePaymentDetailsLoading extends UpdatePaymentDetailsState {}

final class UpdatePaymentDetailsLoaded extends UpdatePaymentDetailsState {}

final class UpdatePaymentDetailsNoInternet extends UpdatePaymentDetailsState {}

final class UpdatePaymentDetailsError extends UpdatePaymentDetailsState {}
