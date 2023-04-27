// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/domain/entity/group.dart';
import 'package:todo/domain/entity/task.dart';

class TaskFormWidgetModel {
  int groupKey;
  String taskText = '';

  TaskFormWidgetModel({
    required this.groupKey,
  });

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }

    final taskBox = await Hive.openBox<Task>('tasks_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('groups_box');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);

    Navigator.of(context).pop();
  }
}

class TaskFormWidgetModelProvider extends InheritedWidget {
  final TaskFormWidgetModel model;

  const TaskFormWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          child: child,
        );

  static TaskFormWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetModelProvider>();
  }

  static TaskFormWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetModelProvider>()
        ?.widget;
    return widget is TaskFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<Listenable> oldWidget) {
    return false;
  }
}
