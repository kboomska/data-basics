import 'package:hive_flutter/hive_flutter.dart';

part 'hive_generate_adapter_example_model.g.dart';

class HiveGenerateAdapterExampleModel {
// Hive.initFlutter() is in main() now!

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    var box = await Hive.openBox<User>('testBox');
    final user = User('Ivan', 54, 2);

    await box.add(user);
    final userFromBox = box.getAt(0);

    print(box.values);
    // print(userFromBox);
  }
}

@HiveType(typeId: 0)
class User {
  // removed HiveFieldId: 2

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(3)
  int? children;

  User(this.name, this.age, this.children);

  @override
  String toString() => 'Name: $name, age: $age, children: $children';
}
