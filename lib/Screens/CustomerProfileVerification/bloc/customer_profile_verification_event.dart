part of 'customer_profile_verification_bloc.dart';

@immutable
sealed class CustomerProfileVerificationEvent {}

class GetCustomerVerificationDetails extends CustomerProfileVerificationEvent {
  final List<InfoList>? oldInfoList;
  final int? page;
  final bool? showLoading;

  GetCustomerVerificationDetails({
    this.oldInfoList,
    this.page,
    this.showLoading,
  });
}
