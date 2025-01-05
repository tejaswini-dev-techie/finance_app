part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserProfileDetails extends ProfileEvent {
  final String? type;
  final String? customerID;

  GetUserProfileDetails({
    required this.type,
    required this.customerID,
  });
}
