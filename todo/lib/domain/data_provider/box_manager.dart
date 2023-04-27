import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/domain/entity/group.dart';
import 'package:todo/domain/entity/task.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();

  BoxManager._();

  Future<Box<Group>> openGroupBox() async {
    return _openBox('groups_box', 1, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox() async {
    return _openBox('tasks_box', 2, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
    String boxName,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox<T>(boxName);
  }
}
