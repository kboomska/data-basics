import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

part 'hive_value_listenable_example_model.g.dart';

class HiveValueListenableExampleModel {
// Hive.initFlutter() is in main() now!

  Future<Box<User>>? userBox;

  void setup() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    userBox = Hive.openBox<User>('user_box');
    userBox?.then((box) {
      box.listenable().addListener(() {
        print(box.length);
        print(box.values);
      });
    });
  }

  void doSome() async {
    final box = await userBox;

    final user = User('Ivan', 17);
    box?.add(user);
  }
}

@HiveType(typeId: 0)
class User extends HiveObject {
  // removed HiveFieldId: 2, 3, 4

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  User(this.name, this.age);

  @override
  String toString() => 'Name: $name, age: $age';
}
