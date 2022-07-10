// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_objbox/models/todo.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;
  FilteredTodosCubit({required this.initialTodos})
      : super(FilteredTodosState(filteredTodos: initialTodos));

  void setFilteredTodos(
      bool onlyCompleted, String searchTerm, List<Todo> todos) {
    List<Todo> resultTodos;
    if (onlyCompleted) {
      resultTodos = todos.where((Todo todo) => !todo.completed).toList();
    } else {
      resultTodos = todos;
    }

    if (searchTerm.isNotEmpty) {
      resultTodos = resultTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodos: resultTodos));
  }
}
