// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Abstract {
  void isso();
  void aquilo();

  List<Object> listaDeAlgo();

  Future<Object> retornaFuture();
}

class Filho implements Abstract {
  @override
  void aquilo() {
    // TODO: implement aquilo
  }

  @override
  void isso() {
    print('isso');
  }

  @override
  List<Object> listaDeAlgo() {
    return [1, 2, 3];
  }

  @override
  Future<Object> retornaFuture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Objeto(id: 1);
  }
}

class Neto extends Filho {
  @override
  List<int> listaDeAlgo() {
    var list = super.listaDeAlgo();
    list.add(4);
    return list as List<int>;
  }
}

class Objeto {
  int id = 0;
  Objeto({
    required this.id,
  });
}
