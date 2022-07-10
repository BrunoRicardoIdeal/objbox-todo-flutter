import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_filter_state.dart';

class TodoFilterCubit extends Cubit<TodoFilterState> {
  TodoFilterCubit() : super(TodoFilterState.initial());

  void toggleNotCompletedOnly() {
    bool notComp = !state.notCompletedOnly;
    emit(state.copyWith(notCompletedOnly: notComp));
  }
}
