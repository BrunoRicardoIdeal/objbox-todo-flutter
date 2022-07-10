import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_filter_state.dart';

class TodoFilterCubit extends Cubit<TodoFilterState> {
  TodoFilterCubit() : super(TodoFilterState.initial());

  void setCompletedOnly(bool value) {
    emit(state.copyWith(notCompletedOnly: value));
  }

  void toggleNotCompletedOnly() {
    bool notComp = !state.notCompletedOnly;
    emit(state.copyWith(notCompletedOnly: notComp));
  }
}
