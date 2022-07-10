import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_todos_state.dart';

class SearchTodosCubit extends Cubit<SearchTodosState> {
  SearchTodosCubit() : super(SearchTodosState.initial());

  void setSearchTerm(String searchTerm) {
    emit(state.copyWith(searchTerm: searchTerm));
  }
}
