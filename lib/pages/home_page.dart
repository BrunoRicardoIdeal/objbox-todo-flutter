import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_objbox/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_objbox/cubits/search_todos/search_todos_cubit.dart';
import 'package:todo_objbox/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_objbox/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_objbox/widget.dart/todo_item.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _snackBarVisible = false;
  bool _searchVisible = false;
  bool _absorbing = false;
  final _newTodoController = TextEditingController();
  final GlobalKey<FormState> _formSnackKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<TodoListCubit>().init();
  }

  SnackBar _getSnackBar() {
    return SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(days: 1),
      onVisible: () {
        setState(() {
          _snackBarVisible = true;
        });
      },
      content: Form(
        key: _formSnackKey,
        child: SizedBox(
          height: 135.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                autofocus: true,
                controller: _newTodoController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  filled: true,
                  label: Text('Insert a new TODO'),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.white),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a valid todo';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_addTodo()) {
                    _dismissSnackbar();
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dismissSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      _snackBarVisible = false;
      _absorbing = false;
    });
  }

  bool _addTodo() {
    final form = _formSnackKey.currentState;
    if (form == null || !form.validate()) return false;
    String desc = _newTodoController.text;
    _newTodoController.clear();
    context.read<TodoListCubit>().addTodo(desc);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    final notCompletedOnly =
        context.watch<TodoFilterCubit>().state.notCompletedOnly;

    final searchWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) =>
              context.read<SearchTodosCubit>().setSearchTerm(value),
          decoration: const InputDecoration(
            labelText: 'Search todos',
            prefixIcon: Icon(Icons.search),
          ),
        ));

    return WillPopScope(
      onWillPop: () async {
        if (_snackBarVisible) {
          _dismissSnackbar();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ObjBox TODO'),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_snackBarVisible) {
                    _dismissSnackbar();
                    return;
                  }
                  _searchVisible = !_searchVisible;
                });
              },
              icon: Icon(
                  _searchVisible ? Icons.search_off_rounded : Icons.search),
            ),
            IconButton(
              onPressed: () {
                if (_snackBarVisible) {
                  _dismissSnackbar();
                  return;
                }
                context.read<TodoFilterCubit>().toggleNotCompletedOnly();
              },
              icon: Icon(
                  notCompletedOnly ? Icons.filter_alt_off : Icons.filter_alt),
            ),
          ],
        ),
        floatingActionButton: _snackBarVisible
            ? null
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  final snackBar = _getSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    _absorbing = true;
                  });
                }),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (_snackBarVisible) {
              _dismissSnackbar();
            }
          },
          child: AbsorbPointer(
            absorbing: _absorbing,
            child: MultiBlocListener(
              listeners: [
                BlocListener<TodoListCubit, TodoListState>(
                    listener: (context, state) {
                  context.read<FilteredTodosCubit>().setFilteredTodos(
                      context.read<TodoFilterCubit>().state.notCompletedOnly,
                      context.read<SearchTodosCubit>().state.searchTerm,
                      state.todos);
                }),
                BlocListener<SearchTodosCubit, SearchTodosState>(
                    listener: (context, state) {
                  context.read<FilteredTodosCubit>().setFilteredTodos(
                      context.read<TodoFilterCubit>().state.notCompletedOnly,
                      state.searchTerm,
                      context.read<TodoListCubit>().state.todos);
                }),
                BlocListener<TodoFilterCubit, TodoFilterState>(
                    listener: (context, state) {
                  context.read<FilteredTodosCubit>().setFilteredTodos(
                      context.read<TodoFilterCubit>().state.notCompletedOnly,
                      context.read<SearchTodosCubit>().state.searchTerm,
                      context.read<TodoListCubit>().state.todos);
                }),
              ],
              child: Column(
                children: [
                  _searchVisible ? searchWidget : Container(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: context.read<TodoListCubit>().init,
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(todos[index].id),
                            background: Container(
                              color: Colors.red,
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                            ),
                            onDismissed: (direction) {
                              context
                                  .read<TodoListCubit>()
                                  .removeTodo(todos[index].id);
                            },
                            child: TodoItem(todo: todos[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
