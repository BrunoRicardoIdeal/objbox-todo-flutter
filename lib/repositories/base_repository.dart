// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

import 'package:todo_objbox/database/objectbox_database.dart';
import 'package:todo_objbox/models/todo.dart';

abstract class IRepository {
  Future<dynamic> add(dynamic obj);
  Future<dynamic> update(dynamic obj);
  Future<dynamic> delete(int id);
  Future<Box> getBox();
  Future<List<dynamic>> getAll();
  void init();
}

class BaseRepository implements IRepository {
  final ObjectBoxDatabase database;
  late final Box box;

  BaseRepository({
    required this.database,
  }) {
    init();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Box> getBox() {
    throw UnimplementedError();
  }

  @override
  Future add(obj) {
    throw UnimplementedError();
  }

  @override
  Future update(obj) {
    throw UnimplementedError();
  }

  @override
  void init() async {
    box = await getBox();
  }

  @override
  Future<List> getAll() {
    throw UnimplementedError();
  }
}

class TesteTodoRepository extends BaseRepository {
  TesteTodoRepository({required super.database});

  @override
  Future<Box<Todo>> getBox() async {
    final store = await database.getStore();
    return store.box<Todo>();
  }

  // @override
  // Future<Todo> add(String desc){
  //   // Todo todo = Todo(desc: desc, completed: false);
  //   // box.put(todo);
  //   // return todo;
  // }
}
