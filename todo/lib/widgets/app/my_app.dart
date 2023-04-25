import 'package:flutter/material.dart';

import 'package:todo/widgets/group_form/group_form_widget.dart';
import 'package:todo/widgets/task_form/task_form_widget.dart';
import 'package:todo/widgets/groups/groups_widget.dart';
import 'package:todo/widgets/tasks/tasks_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        GroupsWidget.route: (context) => const GroupsWidget(),
        GroupFormWidget.route: (context) => const GroupFormWidget(),
        TasksWidget.route: (context) => const TasksWidget(),
        TaskFormWidget.route: (context) => const TaskFormWidget(),
      },
      initialRoute: GroupsWidget.route,
    );
  }
}
