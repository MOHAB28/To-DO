import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../cubit/todo_cubit.dart';
import '../../../cubit/todo_states.dart';
import '../../../widgets/task_item_builder.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  void _allTaskBLoc() {
    TodoBloc.get(context).getAllTasks('ALL TASKS');
  }

  @override
  Widget build(BuildContext context) {
    List<TodoEntity> allTasks = TodoBloc.get(context).allTasks;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is GetAllTasksLoading) {
          return const Center(child: Text('Loading...'));
        } else if (state is GetAllTasksSuccess) {
          if (state.todos.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (ctx, i) {
                return TaskItemBuilder(
                  todo: state.todos[i],
                  event: _allTaskBLoc,
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
                event: _allTaskBLoc,
              );
            },
          );
        }
      },
    );
  }
}
