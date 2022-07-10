import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_objbox/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_objbox/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  void _toggleTodo(BuildContext context) {
    context.read<TodoListCubit>().toggleTodo(todo.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _toggleTodo(context),
      title: Text(todo.desc),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          _toggleTodo(context);
        },
      ),
    );
  }
}
