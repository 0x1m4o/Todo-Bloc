import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/blocs/bloc/filtered_todo_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_list/todo_list_bloc.dart';
import 'package:todo_app_bloc/blocs/todo_search/todo_search_bloc.dart';
import 'package:todo_app_bloc/models/todo_model.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodoBloc>().state.todos;

    return (todos.length == 0)
        ? StatefulBuilder(
            builder: (context, setState) {
              return Center(
                child: Text('No Data'),
              );
            },
          )
        : ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  onDismissed: (_) {
                    context
                        .read<TodoListBloc>()
                        .add(RemoveTodoListEvent(todo: todos[index]));
                  },
                  confirmDismiss: (_) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Task'),
                          content:
                              Text('Are you sure wan\'t to delete this task ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Delete'))
                          ],
                        );
                      },
                    );
                  },
                  background: showBackground(0),
                  secondaryBackground: showBackground(1),
                  key: ValueKey(todos[index].id),
                  child: TodoItem(todo: todos[index]));
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
          );
  }
}

Widget showBackground(int direction) {
  return Container(
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.symmetric(horizontal: 10),
    color: Colors.red,
    alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
    child: Icon(
      Icons.delete,
      size: 30,
      color: Colors.white,
    ),
  );
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    required this.todo,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textEditingController.text = widget.todo.desc;
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Edit Dialog'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: error ? 'Task value is required' : null),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error =
                              textEditingController.text.isEmpty ? true : false;
                        });

                        if (!error) {
                          context.read<TodoListBloc>().add(UpdateTodoListEvent(
                              id: widget.todo.id,
                              updateTodoDesc: textEditingController.text));
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Update'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          return Checkbox(
              value: widget.todo.completed,
              onChanged: (bool? checked) {
                print('${widget.todo.id}');
                BlocProvider.of<TodoListBloc>(context)
                    .add(ToggleTodoListEvent(id: widget.todo.id));
                // widget.todo.completed = !widget.todo.completed;
              });
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
