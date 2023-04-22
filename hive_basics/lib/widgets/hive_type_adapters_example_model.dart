import 'package:hive_flutter/hive_flutter.dart';

class HiveTypeAdaptersExampleModel {
// Hive.initFlutter() is in main() now!

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }

    var box = await Hive.openBox<User>('testBox');
    final user = User('Ivan', 54);

    // await box.add(user);
    final userFromBox = box.getAt(0);

    // print(box.values);
    print(userFromBox);
  }
}

class User {
  String name;
  int age;

  User(this.name, this.age);

  @override
  String toString() => 'Name: $name, age: $age';
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final name = reader.readString();
    final age = reader.readInt();

    return User(name, age);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.age);
  }
}
