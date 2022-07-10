// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_objbox/models/todo.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodos;
  FilteredTodosCubit({required this.initialTodos})
      : super(FilteredTodosState(filteredTodos: initialTodos));

  void setFilteredTodos(bool onlyCompleted, List<Todo> todos) {
    List<Todo> resultTodos;
    if (onlyCompleted) {
      resultTodos = todos.where((Todo todo) => !todo.completed).toList();
    } else {
      resultTodos = todos;
    }
    emit(state.copyWith(filteredTodos: resultTodos));
  }
}
