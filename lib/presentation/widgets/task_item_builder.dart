import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';
import '../cubit/todo_cubit.dart';
import '../pages/edit_task_page/edit_task_page.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({
    Key? key,
    required TodoEntity todo,
    required VoidCallback event,
  })  : _todo = todo,
        _event = event,
        super(key: key);
  final TodoEntity _todo;
  final VoidCallback _event;
  @override
  Widget build(BuildContext context) {
    var cubit = TodoBloc.get(context);
    return ListTile(
      leading: _todo.isCompleted
          ? CompleteCheckBox(isComplete: true, color: _todo.color)
          : CompleteCheckBox(isComplete: false, color: _todo.color),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => EditTaskPage(todo: _todo),
            ),
          );
        },
        child: Text(_todo.title),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.more_horiz,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      '${_todo.isCompleted ? 'Uncomplete' : 'Complete'} the task',
                    ),
                    onTap: _todo.isCompleted
                        ? () {
                            cubit
                                .completeTheTask(id: _todo.id, isComplete: 0)
                                .whenComplete(
                              () {
                                _event();
                                Navigator.pop(context);
                              },
                            );
                          }
                        : () {
                            cubit
                                .completeTheTask(id: _todo.id, isComplete: 1)
                                .whenComplete(
                              () {
                                _event();
                                Navigator.pop(context);
                              },
                            );
                          },
                  ),
                  ListTile(
                      title: Text(
                        '${_todo.isFav ? 'Remove from' : 'Add to'} favorites',
                      ),
                      onTap: !_todo.isFav
                          ? () {
                              cubit
                                  .addToFav(id: _todo.id, isFav: 1)
                                  .whenComplete(
                                () {
                                  _event();
                                  Navigator.pop(context);
                                },
                              );
                            }
                          : () {
                              cubit
                                  .addToFav(id: _todo.id, isFav: 0)
                                  .whenComplete(
                                () {
                                  _event();
                                  Navigator.pop(context);
                                },
                              );
                            }),
                  ListTile(
                    title: const Text('Delete the task'),
                    onTap: () {
                      cubit
                          .deletTheTask(
                              id: _todo.id,
                              notificationId: _todo.notificationId)
                          .whenComplete(
                        () {
                          _event();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CompleteCheckBox extends StatelessWidget {
  const CompleteCheckBox({
    Key? key,
    required bool isComplete,
    required int color,
  })  : _isComplete = isComplete,
        _color = color,
        super(key: key);
  final bool _isComplete;
  final int _color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: _isComplete ? Color(_color) : null,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          width: 1.0,
          color: Color(_color),
        ),
      ),
      child: _isComplete
          ? const Center(
              child: Icon(
                Icons.done_rounded,
                size: 15.0,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
