// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_todos_cubit.dart';

class SearchTodosState extends Equatable {
  final String searchTerm;
  const SearchTodosState({
    required this.searchTerm,
  });

  factory SearchTodosState.initial() {
    return const SearchTodosState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  SearchTodosState copyWith({
    String? searchTerm,
  }) {
    return SearchTodosState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  bool get stringify => true;
}
