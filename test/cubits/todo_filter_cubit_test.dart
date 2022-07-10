import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_objbox/cubits/todo_filter/todo_filter_cubit.dart';

void main() {
  group('TodoFilterCubit group', () {
    late TodoFilterCubit todoFilterCubit;

    setUp(() {
      todoFilterCubit = TodoFilterCubit();
    });

    tearDown(() {
      todoFilterCubit.close();
    });

    test(
      "The initial state has been given for constructor",
      () {
        expect(todoFilterCubit.state, TodoFilterState.initial());
      },
    );

    blocTest<TodoFilterCubit, TodoFilterState>(
      'emits [true] when toggle the filter from true',
      build: () => todoFilterCubit,
      act: (cubit) => cubit.toggleNotCompletedOnly(),
      expect: () =>
          const <TodoFilterState>[TodoFilterState(notCompletedOnly: true)],
    );
  });
}
