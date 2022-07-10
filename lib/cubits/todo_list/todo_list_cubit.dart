// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_objbox/models/todo.dart';
import 'package:todo_objbox/repositories/todo_repository.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final TodoRepository todoRepository;

  TodoListCubit(
    this.todoRepository,
  ) : super(TodoListState.initial());

  void addTodo(String desc) async {
    emit(state.copyWith(
        todos: state.todos, todoListStatus: TodoListStatus.loading));
    try {
      Todo newTodo = await todoRepository.insert(desc);
      final newTodos = [...state.todos, newTodo];
      emit(state.copyWith(
          todos: newTodos, todoListStatus: TodoListStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
          todos: state.todos, todoListStatus: TodoListStatus.error));
    }
  }

  void removeTodo(int id) async {
    if (!await todoRepository.delete(id)) {
      throw Exception('Element not found in database');
    }
    final newTodos = state.todos.where((Todo todo) => todo.id != id).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void toggleTodo(int id) async {
    Todo updatedTodo = Todo();
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        updatedTodo =
            Todo(id: todo.id, desc: todo.desc, completed: !todo.completed);
        return updatedTodo;
      }
      return todo;
    }).toList();

    if (updatedTodo.id != 0) {
      await todoRepository.update(updatedTodo);
    }

    emit(state.copyWith(todos: newTodos));
  }

  Future<List<Todo>> getAll() async {
    return await todoRepository.getAll();
  }

  Future<void> init() async {
    final todos = await getAll();
    emit(state.copyWith(todos: todos));
  }
}
