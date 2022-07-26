import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/todo_states.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../cubit/todo_cubit.dart';
import '../../../widgets/task_item_builder.dart';

class CompleteTaskPage extends StatefulWidget {
  const CompleteTaskPage({Key? key}) : super(key: key);

  @override
  State<CompleteTaskPage> createState() => _CompleteTaskPageState();
}

class _CompleteTaskPageState extends State<CompleteTaskPage> {
  void _getCompletedTasks() {
    TodoBloc.get(context).getCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<TodoEntity> allTasks = TodoBloc.get(context).completeTasks;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is GetCompleteTasksLoading) {
          return const Center(child: Text('Loading...'));
        } else if (state is GetCompleteTasksSuccess) {
          if (state.todos.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (ctx, i) {
                return TaskItemBuilder(
                  todo: state.todos[i],
                  event: _getCompletedTasks,
                );
              },
            );
          }
        } else {
          return ListView.builder(
            itemCount: allTasks.length,
            itemBuilder: (ctx, i) {
              return TaskItemBuilder(
                todo: allTasks[i],
                event: _getCompletedTasks,
              );
            },
          );
        }
      },
    );
  }
}
