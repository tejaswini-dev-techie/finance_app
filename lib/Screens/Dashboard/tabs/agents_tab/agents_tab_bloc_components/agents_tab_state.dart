part of 'agents_tab_bloc.dart';

@immutable
sealed class AgentsTabState {}

final class AgentsTabLoading extends AgentsTabState {}

final class AgentsTabLoaded extends AgentsTabState {}

final class AgentsTabNoInternet extends AgentsTabState {}

final class AgentsTabError extends AgentsTabState {}
