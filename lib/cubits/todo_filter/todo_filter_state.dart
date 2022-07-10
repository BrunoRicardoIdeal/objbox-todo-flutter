part of 'todo_filter_cubit.dart';

class TodoFilterState extends Equatable {
  final bool notCompletedOnly;
  const TodoFilterState({
    required this.notCompletedOnly,
  });

  factory TodoFilterState.initial() {
    return const TodoFilterState(notCompletedOnly: false);
  }

  TodoFilterState copyWith({
    bool? notCompletedOnly,
  }) {
    return TodoFilterState(
      notCompletedOnly: notCompletedOnly ?? this.notCompletedOnly,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [notCompletedOnly];
}
