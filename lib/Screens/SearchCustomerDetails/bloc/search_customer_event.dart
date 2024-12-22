part of 'search_customer_bloc.dart';

@immutable
sealed class SearchCustomerEvent {}

class GetSearchDetails extends SearchCustomerEvent {
  final List<SearchMembersList>? oldSearchCusDataList;
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
