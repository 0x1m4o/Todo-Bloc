// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoListEvent extends TodoListEvent {
  final String todoDesc;
  const AddTodoListEvent({
    required this.todoDesc,
  });

  AddTodoListEvent copyWith({
    String? todoDesc,
  }) {
    return AddTodoListEvent(
      todoDesc: todoDesc ?? this.todoDesc,
    );
  }

  @override
  String toString() => 'AddTodoListEvent(todoDesc: $todoDesc)';

  @override
  List<Object> get props => [todoDesc];
}

class UpdateTodoListEvent extends TodoListEvent {
  final String id;
  final String updateTodoDesc;
  const UpdateTodoListEvent({
    required this.id,
    required this.updateTodoDesc,
  });

  @override
  String toString() =>
      'UpdateTodoListEvent(id: $id, updateTodoDesc: $updateTodoDesc)';

  UpdateTodoListEvent copyWith({
    String? id,
    String? updateTodoDesc,
  }) {
    return UpdateTodoListEvent(
      id: id ?? this.id,
      updateTodoDesc: updateTodoDesc ?? this.updateTodoDesc,
    );
  }

  @override
  List<Object> get props => [id, updateTodoDesc];
}

class ToggleTodoListEvent extends TodoListEvent {
  final String id;
  const ToggleTodoListEvent({required this.id});

  @override
  String toString() => 'ToggleTodoListEvent(id: $id)';

  ToggleTodoListEvent copyWith({String? id}) {
    return ToggleTodoListEvent(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];
}

class RemoveTodoListEvent extends TodoListEvent {
  final Todo todo;
  const RemoveTodoListEvent({
    required this.todo,
  });

  RemoveTodoListEvent copyWith({
    Todo? todo,
  }) {
    return RemoveTodoListEvent(
      todo: todo ?? this.todo,
    );
  }

  @override
  String toString() => 'RemoveTodoListEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}
