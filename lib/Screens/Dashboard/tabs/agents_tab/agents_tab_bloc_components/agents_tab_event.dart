part of 'agents_tab_bloc.dart';

@immutable
sealed class AgentsTabEvent {}

class GetAgentsDetailsEvent extends AgentsTabEvent {
  final String? startDate;
  final String? endDate;
  final bool? showLoader;

  GetAgentsDetailsEvent({
    this.startDate,
    this.endDate,
    this.showLoader = false,
  });
}
