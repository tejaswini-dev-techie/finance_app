part of 'group_members_details_bloc.dart';

@immutable
sealed class GroupMembersDetailsState {}

final class GroupMembersDetailsLoading extends GroupMembersDetailsState {}

final class GroupMembersDetailsLoaded extends GroupMembersDetailsState {}

final class GroupMembersDetailsNoInternet extends GroupMembersDetailsState {}

final class GroupMembersDetailsError extends GroupMembersDetailsState {}


