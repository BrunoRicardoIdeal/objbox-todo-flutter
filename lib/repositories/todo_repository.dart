import 'package:objectbox/objectbox.dart';
import 'package:todo_objbox/database/objectbox_database.dart';
import 'package:todo_objbox/models/todo.dart';

class TodoRepository {
  final ObjectBoxDatabase database;

  TodoRepository(this.database);

  Future<Box> getBox() async {
    final store = await database.getStore();
    return store.box<Todo>();
  }

  Future<Todo> insert(String desc) async {
    Todo todo = Todo(desc: desc, completed: false);
    final box = await getBox();
    box.put(todo);
    return todo;
  }

  Future<List<Todo>> getAll() async {
    List<Todo> todos;
    final box = await getBox();
    todos = box.getAll() as List<Todo>;
    return todos;
  }

  Future<bool> delete(int id) async {
    final box = await getBox();
    return box.remove(id);
  }

  Future<Todo> update(Todo todo) async {
    final box = await getBox();
    box.put(todo);
    return todo;
  }
}
