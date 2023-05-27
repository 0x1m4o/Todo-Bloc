import 'package:flutter/material.dart';
import 'package:todo_app_bloc/blocs/active_todo_count/active_todo_count_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Todo App',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),

        // BlocListener<TodoListBloc, TodoListState>(
        //   listener: (context, state) {
        //     context.read<ActiveTodoCountBloc>().add(
        //         CalculateActiveTodoCountEvent(
        //             activeTodoCount: state.todos
        //                 .where((Todo todos) => !todos.completed)
        //                 .toList()
        //                 .length));
        //   },
        //   child: BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
        //     builder: (context, state) {
        //       return Text(
        //           state.activeTodoCount == 0
        //               ? 'All Task is Done'
        //               : '${state.activeTodoCount} Items Left',
        //           style: TextStyle(
        //               color: state.activeTodoCount == 0
        //                   ? Colors.green
        //                   : Colors.red));
        //     },
        //   ),
        // ),
        Text(
            context.watch<ActiveTodoCountBloc>().state.activeTodoCount == 0
                ? 'All Task is Done'
                : '${context.watch<ActiveTodoCountBloc>().state.activeTodoCount} Items Left',
            style: TextStyle(
                color: context
                            .watch<ActiveTodoCountBloc>()
                            .state
                            .activeTodoCount ==
                        0
                    ? Colors.green
                    : Colors.red))
      ],
    );
  }
}
