part of 'search_collection_bloc.dart';

@immutable
sealed class SearchCollectionState {}

final class SearchCollectionLoading extends SearchCollectionState {}

final class SearchCollectionLoaded extends SearchCollectionState {}

final class SearchCollectionNoInternet extends SearchCollectionState {}

final class SearchCollectionError extends SearchCollectionState {}
