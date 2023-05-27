import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_app_bloc/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app_bloc/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app_bloc/models/todo_model.dart';
import 'package:todo_app_bloc/utils/debounce.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
              label: Text('Search Task'),
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search)),
          onChanged: (String? search) {
            if (search != null) {
              BlocProvider.of<TodoSearchBloc>(
                context,
              ).add(ChangeTodoSearchEvent(searchTerm: search));
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: filterButton(context, Filter.all),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(flex: 3, child: filterButton(context, Filter.active)),
            SizedBox(
              width: 5,
            ),
            Expanded(flex: 4, child: filterButton(context, Filter.completed)),
          ],
        )
      ],
    );
  }
}

Widget filterButton(BuildContext context, Filter filter) {
  final todos = context.watch<TodoListBloc>().state.todos;
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: textColor(context, filter)))),
    child: TextButton(
        style: TextButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            foregroundColor: Colors.white),
        onPressed: () {
          context
              .read<TodoFilterBloc>()
              .add(ChangeTodoFilterEvent(newFilter: filter));
        },
        child: Text(
          "${filter == Filter.all ? 'All (${todos.length})' : filter == Filter.active ? 'Active (${todos.where((value) => !value.completed).length.toString()})' : 'Completed (${todos.where((value) => value.completed).length.toString()})'}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor(context, filter),
          ),
        )),
  );
}

Color textColor(BuildContext context, Filter filter) {
  final currentFilter = context.watch<TodoFilterBloc>().state.filter;
  return currentFilter == filter ? Colors.blue : Colors.grey;
}
