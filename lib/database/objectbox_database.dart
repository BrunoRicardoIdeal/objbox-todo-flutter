import 'objectbox.g.dart';

// class ObjectBoxDatabase {
//   Store? _store;

//   Future<Store> getStore() async {
//     return _store ??= await openStore();
//   }
// }

class ObjectBoxDatabase {
  static final ObjectBoxDatabase _singleton = ObjectBoxDatabase._internal();
  Store? _store;

  factory ObjectBoxDatabase() {
    return _singleton;
  }

  Future<Store> getStore() async {
    return _store ??= await openStore();
  }

  ObjectBoxDatabase._internal();
}
