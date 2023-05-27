// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

part 'filtered_todo_event.dart';
part 'filtered_todo_state.dart';

class FilteredTodoBloc extends Bloc<FilteredTodoEvent, FilteredTodoState> {
  late final StreamSubscription todoListStreamSubscription;
  late final StreamSubscription todoFilterStreamSubscription;
  late final StreamSubscription todoSearchStreamSubscription;

  final TodoListBloc todoListBloc;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;

  final List<Todo> initialTodo;
  FilteredTodoBloc({
    required this.todoListBloc,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.initialTodo,
  }) : super(FilteredTodoState(todos: initialTodo)) {
    todoListStreamSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      setFilteredTodo();
    });

    todoFilterStreamSubscription =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodo();
    });
    todoSearchStreamSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodo();
    });

    on<ChangeFilterTodoEvent>((event, emit) {
      emit(state.copyWith(todos: event.filteredtodo));
    });
  }
  void setFilteredTodo() {
    // Created a new list of Todo to overrides the todoList
    List<Todo> filteredTodo;
    // Created a switch case for different filter.
    switch (todoFilterBloc.state.filter) {
      // If the Filter tab is 'active'.
      case Filter.active:
        // We filter out the todo that do not completed
        filteredTodo = todoListBloc.state.todos
            .where((Todo todos) => !todos.completed)
            .toList();
        break;

      // If the Filter tab is 'completed'.
      case Filter.completed:
        // We filter out the todo that completed
        filteredTodo = todoListBloc.state.todos
            .where((Todo todos) => todos.completed)
            .toList();
        break;

      // If the Filter tab is 'all'.
      // We include all of todo list.
      case Filter.all:
      default:
        filteredTodo = todoListBloc.state.todos;
        break;
    }

    // After that we make sure that is textfield is not empty. If it is not empty. We filter again based on the value on the textfields.
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      filteredTodo = filteredTodo
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }

    add(ChangeFilterTodoEvent(
      filteredtodo: filteredTodo,
    ));
  }

  @override
  Future<void> close() {
    todoFilterStreamSubscription.cancel();
    todoListStreamSubscription.cancel();
    todoSearchStreamSubscription.cancel();
    return super.close();
  }
}
