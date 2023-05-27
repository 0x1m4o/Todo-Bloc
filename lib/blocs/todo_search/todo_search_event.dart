// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeTodoSearchEvent extends TodoSearchEvent {
  final String searchTerm;
  ChangeTodoSearchEvent({
    required this.searchTerm,
  });

  @override
  String toString() => 'ChangeTodoSearchEvent(searchTerm: $searchTerm)';

  ChangeTodoSearchEvent copyWith({
    String? searchTerm,
  }) {
    return ChangeTodoSearchEvent(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object> get props => [searchTerm];
}
