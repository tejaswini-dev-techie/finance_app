part of 'group_members_details_bloc.dart';

@immutable
sealed class GroupMembersDetailsEvent {}

class GetGroupMemDetEvent extends GroupMembersDetailsEvent {
  final List<GroupMembersList>? oldGrpMemList;
  final int? page;
  final bool? showLoading;
  final String? type; // type: 1 - G PIGMY | 2 - G Loans

  GetGroupMemDetEvent({
    this.oldGrpMemList,
    required this.page,
    required this.showLoading,
    required this.type,
  });
}
