import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../cubit/todo_cubit.dart';
import '../../../cubit/todo_states.dart';
import '../../../widgets/task_item_builder.dart';

class FavoriteTasksPage extends StatefulWidget {
  const FavoriteTasksPage({Key? key}) : super(key: key);

  @override
  State<FavoriteTasksPage> createState() => _FavoriteTasksPageState();
}

class _FavoriteTasksPageState extends State<FavoriteTasksPage> {
  void _getFavTasks() {
    TodoBloc.get(context).getFavTasks();
  }

  @override
  Widget build(BuildContext context) {
    List<TodoEntity> allTasks = TodoBloc.get(context).favTasks;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is GetFavoritesTasksLoading) {
          return const Center(child: Text('Loading...'));
        } else if (state is GetFavoritesTasksSuccess) {
          if (state.todos.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (ctx, i) {
                return TaskItemBuilder(
                  todo: state.todos[i],
                  event: _getFavTasks,
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
                event: _getFavTasks,
              );
            },
          );
        }
      },
    );
  }
}
