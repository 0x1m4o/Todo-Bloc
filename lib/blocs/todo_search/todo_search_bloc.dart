import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<ChangeTodoSearchEvent>((event, emit) {
      emit(state.copyWith(searchTerm: event.searchTerm));
    }, transformer: debounce(Duration(milliseconds: 1000)));
  }

  EventTransformer<ChangeTodoSearchEvent> debounce<ChangeTodoSearchEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
