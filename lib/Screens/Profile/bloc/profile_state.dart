part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {}

final class ProfileNoInternet extends ProfileState {}

final class ProfileError extends ProfileState {}
