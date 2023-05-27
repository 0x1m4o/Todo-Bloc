part of 'filtered_todo_bloc.dart';

class FilteredTodoState extends Equatable {
  // Create a variable of list from
  // Todo models that we created before
  final List<Todo> todos;
  FilteredTodoState({
    required this.todos,
  });

  // factory FilteredTodoState.initial() {
  //   return FilteredTodoState(todos: []);
  // }

  @override
  List<Object> get props => [todos];

  FilteredTodoState copyWith({
    List<Todo>? todos,
  }) {
    return FilteredTodoState(
      todos: todos ?? this.todos,
    );
  }

  @override
  bool get stringify => true;
}
