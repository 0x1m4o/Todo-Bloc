import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(TodoFilterState.initial()) {
    on<ChangeTodoFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.newFilter));
    });
  }
}
