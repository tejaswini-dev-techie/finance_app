part of 'search_customer_bloc.dart';

@immutable
sealed class SearchCustomerState {}

final class SearchCustomerLoading extends SearchCustomerState {}

final class SearchCustomerLoaded extends SearchCustomerState {}

final class SearchCustomerNoInternet extends SearchCustomerState {}

final class SearchCustomerError extends SearchCustomerState {}
