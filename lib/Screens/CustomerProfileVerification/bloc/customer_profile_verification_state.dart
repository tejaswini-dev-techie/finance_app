part of 'customer_profile_verification_bloc.dart';

@immutable
sealed class CustomerProfileVerificationState {}

final class CustomerProfileVerificationLoading
    extends CustomerProfileVerificationState {}

final class CustomerProfileVerificationLoaded
    extends CustomerProfileVerificationState {}

final class CustomerProfileVerificationNoInternet
    extends CustomerProfileVerificationState {}

final class CustomerProfileVerificationError
    extends CustomerProfileVerificationState {}
