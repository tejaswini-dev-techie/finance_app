part of 'search_collection_bloc.dart';

@immutable
sealed class SearchCollectionEvent {}

class GetSearchDetails extends SearchCollectionEvent {
  final List<ReportList>? oldSearchCusDataList;
  final int? page;
  final bool? showLoading;
  final String? searchKey;
  final String? type; // 1 - Customers Serach | 2 - Group Search

  GetSearchDetails({
    this.oldSearchCusDataList,
    required this.page,
    required this.showLoading,
    required this.searchKey,
    required this.type,
  });
}
