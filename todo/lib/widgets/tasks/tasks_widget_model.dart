import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/widgets/task_form/task_form_widget.dart';
import 'package:todo/domain/entity/group.dart';
import 'package:todo/domain/entity/task.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  var _tasks = <Task>[];

  // Used toList() to return a completely different list.
  List<Task> get tasks => _tasks.toList();

  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(TaskFormWidget.route, arguments: groupKey);
  }

  void _loadGroup() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _groupBox;
    _readTasks();

    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void deleteTask(int taskIndex) async {
    await _group?.tasks?.deleteFromHive(taskIndex);
    await _group?.save();
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    _groupBox = Hive.openBox<Group>('groups_box');

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }

    Hive.openBox<Task>('tasks_box');

    _loadGroup();
    _setupListenTasks();
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;

  const TasksWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static TasksWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
