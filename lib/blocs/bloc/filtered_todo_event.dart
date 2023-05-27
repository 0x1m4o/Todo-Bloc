// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_todo_bloc.dart';

abstract class FilteredTodoEvent extends Equatable {
  const FilteredTodoEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterTodoEvent extends FilteredTodoEvent {
  List<Todo> filteredtodo;
  ChangeFilterTodoEvent({
    required this.filteredtodo,
  });

  ChangeFilterTodoEvent copyWith({
    List<Todo>? filteredtodo,
  }) {
    return ChangeFilterTodoEvent(
      filteredtodo: filteredtodo ?? this.filteredtodo,
    );
  }

  @override
  String toString() => 'ChangeFilterTodoEvent(filteredtodo: $filteredtodo)';
  @override
  List<Object> get props => [filteredtodo];
}
