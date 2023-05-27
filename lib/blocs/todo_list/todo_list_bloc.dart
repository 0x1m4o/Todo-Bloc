import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoListEvent>(_addTodoEvent);
    on<UpdateTodoListEvent>(_updateTodoEvent);
    on<ToggleTodoListEvent>(_toggleTodoEvent);
    on<RemoveTodoListEvent>(_removeTodoEvent);
  }

  void _addTodoEvent(AddTodoListEvent event, Emitter<TodoListState> emit) {
    // Here we create a new Todo member.
    final newTodo = Todo(desc: event.todoDesc);

    // Add the Todo that created before to the all state todo list
    final newTodos = [...state.todos, newTodo];

    emit(state.copyWith(todos: newTodos));
  }

  void _updateTodoEvent(
      UpdateTodoListEvent event, Emitter<TodoListState> emit) {
    // First we need to find from the list the same Id as the clicked one from parameters sends.
    // If it is the same so we can update the value of it.
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
            id: event.id,
            desc: event.updateTodoDesc,
            completed: todo.completed);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodoEvent(
      ToggleTodoListEvent event, Emitter<TodoListState> emit) {
    // Same as Updatedata above, but we make the value of completed reverse.
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        print('Todo ID : ${todo.id}');
        return Todo(id: event.id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodoEvent(
      RemoveTodoListEvent event, Emitter<TodoListState> emit) {
    // Where Todo is return to true that todo is in the value
    // But we filter the same id is not inserted/removed from list.
    final newTodos =
        state.todos.where((Todo todo) => todo.id != event.todo.id).toList();

    emit(state.copyWith(todos: newTodos));
  }
}
