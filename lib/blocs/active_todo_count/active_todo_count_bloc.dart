import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription streamSubscription;
  TodoListCubit todoListCubit = TodoListCubit();
  final int initialActiveTodoCount;

  ActiveTodoCountBloc(
      {required this.todoListCubit, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    // on<ActiveTodoCountEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    streamSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      final int currentActiveTodoCount = todoListState.todos
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;

      add(CalculateActiveTodoCountEvent(
          activeTodoCount: currentActiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>((event, emit) =>
        emit(state.copyWith(activeTodoCount: event.activeTodoCount)));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
