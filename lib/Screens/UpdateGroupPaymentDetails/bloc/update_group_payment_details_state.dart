part of 'update_group_payment_details_bloc.dart';

@immutable
sealed class UpdateGroupPaymentDetailsState {}

final class UpdateGroupPaymentDetailsLoading
    extends UpdateGroupPaymentDetailsState {}

final class UpdateGroupPaymentDetailsLoaded
    extends UpdateGroupPaymentDetailsState {}

final class UpdateGroupPaymentDetailsNoInternet
    extends UpdateGroupPaymentDetailsState {}

final class UpdateGroupPaymentDetailsError
    extends UpdateGroupPaymentDetailsState {}
