import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_objbox/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_objbox/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_objbox/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_objbox/database/objectbox_database.dart';
import 'package:todo_objbox/pages/home_page.dart';
import 'package:todo_objbox/repositories/todo_repository.dart';

void main() {
  runApp(const TodoObjBoxApp());
}

class TodoObjBoxApp extends StatelessWidget {
  const TodoObjBoxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepository(ObjectBoxDatabase()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TodoListCubit>(
            create: (context) => TodoListCubit(context.read<TodoRepository>()),
          ),
          BlocProvider<TodoFilterCubit>(
            create: (context) => TodoFilterCubit(),
          ),
          BlocProvider<FilteredTodosCubit>(
            create: (context) => FilteredTodosCubit(
                initialTodos: context.read<TodoListCubit>().state.todos),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
