import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/todo_states.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../cubit/todo_cubit.dart';
import '../../../widgets/task_item_builder.dart';

class UnCompleteTaskPage extends StatefulWidget {
  const UnCompleteTaskPage({Key? key}) : super(key: key);

  @override
  State<UnCompleteTaskPage> createState() => _UnCompleteTaskPageState();
}

class _UnCompleteTaskPageState extends State<UnCompleteTaskPage> {
  void _getUncompletedTasks() {
    TodoBloc.get(context).getUncompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<TodoEntity> allTasks = TodoBloc.get(context).unCompleteTasks;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is GetUnCompleteTasksLoading) {
          return const Center(child: Text('Loading...'));
        } else if (state is GetUnCompleteTasksSuccess) {
          if (state.todos.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (ctx, i) {
                return TaskItemBuilder(
                  todo: state.todos[i],
                  event: _getUncompletedTasks,
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
                event: _getUncompletedTasks,
              );
            },
          );
        }
      },
    );
  }
}
