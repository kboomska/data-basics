import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/domain/entity/group.dart';

class GroupFormWidgetModel {
  String groupName = '';

  void saveGroup(BuildContext context) async {
    if (groupName.isEmpty) return;

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }

    final box = await Hive.openBox<Group>('groups_box');
    final group = Group(name: groupName);
    await box.add(group);

    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvider extends InheritedNotifier {
  final GroupFormWidgetModel model;

  const GroupFormWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          child: child,
        );

  static GroupFormWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  static GroupFormWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupFormWidgetModelProvider>()
        ?.widget;
    return widget is GroupFormWidgetModelProvider ? widget : null;
  }
}
