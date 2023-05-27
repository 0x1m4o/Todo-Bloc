import 'package:flutter/material.dart';
import 'package:todo_app_bloc/blocs/active_todo_count/active_todo_count_bloc.dart';
import 'package:todo_app_bloc/blocs/bloc/filtered_todo_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_app_bloc/cubits/active_todo_count/active_todo_count_dart_cubit.dart';
import 'package:todo_app_bloc/cubits/filter_todo/filter_todo_cubit.dart';
import 'package:todo_app_bloc/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:todo_app_bloc/cubits/todo_search/todo_search_cubit.dart';
import 'package:todo_app_bloc/pages/todos_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoFilterBloc(),
        ),
        BlocProvider(
          create: (context) => TodoSearchBloc(),
        ),
        BlocProvider(
          create: (context) => TodoListBloc(),
        ),
        BlocProvider(
          create: (context) => ActiveTodoCountBloc(
              todoListBloc: BlocProvider.of<TodoListBloc>(context),
              initialActiveTodoCount:
                  context.read<TodoListBloc>().state.todos.length),
        ),
        BlocProvider(
            create: (context) => FilteredTodoBloc(
                  todoListBloc: BlocProvider.of<TodoListBloc>(context),
                  todoFilterBloc: BlocProvider.of<TodoFilterBloc>(context),
                  todoSearchBloc: BlocProvider.of<TodoSearchBloc>(context),
                  initialTodo:
                      BlocProvider.of<TodoListBloc>(context).state.todos,
                ))
      ],
      child: const MaterialApp(
        home: TodosPage(),
      ),
    );
  }
}
