part of 'search_customer_bloc.dart';

@immutable
sealed class SearchCustomerEvent {}

class GetSearchDetails extends SearchCustomerEvent {
  final List<SearchMembersList>? oldSearchCusDataList;
  final int? page;
  final bool? showLoading;
  final String? searchKey;

  GetSearchDetails({
    this.oldSearchCusDataList,
    required this.page,
    required this.showLoading,
    required this.searchKey,
  });
}
