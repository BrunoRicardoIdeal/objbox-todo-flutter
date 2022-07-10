// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_cubit.dart';

enum TodoListStatus { initial, loading, loaded, error }

class TodoListState extends Equatable {
  final List<Todo> todos;
  final TodoListStatus todoListStatus;
  const TodoListState({
    required this.todos,
    required this.todoListStatus,
  });

  factory TodoListState.initial() {
    return const TodoListState(
        todos: [], todoListStatus: TodoListStatus.initial);
  }

  @override
  List<Object> get props => [todos, todoListStatus];

  @override
  bool get stringify => true;

  TodoListState copyWith({
    List<Todo>? todos,
    TodoListStatus? todoListStatus,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
      todoListStatus: todoListStatus ?? this.todoListStatus,
    );
  }
}
