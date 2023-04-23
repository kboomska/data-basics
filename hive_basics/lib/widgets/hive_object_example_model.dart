import 'package:hive_flutter/hive_flutter.dart';

part 'hive_object_example_model.g.dart';

class HiveObjectExampleModel {
// Hive.initFlutter() is in main() now!

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PetAdapter());
    }

    var box = await Hive.openBox<User>('testBox');
    // final user = User('Ivan', 54);

    // await box.add(user);
    // final userFromBox = box.getAt(0);

    // print(box.values);
    // print(userFromBox);

    // Without using HiveObject
    // var user = box.get('ivan');
    // if (user != null) {
    //   user.age = 60;
    //   await box.put('ivan', user);
    // }

    // With using HiveObject
    // var user = box.get('ivan');
    // user?.age = 12;
    // await user?.save();

    // print(box.get('ivan'));

    // HiveList and Relationships
    var petBox = await Hive.openBox<Pet>('pets');

    // final cat = Pet('Snow');
    // petBox.add(cat);

    // final dog = Pet('Snickers');
    // petBox.add(dog);

    // final pets = HiveList(petBox, objects: [cat, dog]);
    // var user = User('John', 16, pets);

    // await box.put('user_with_pets', user);

    // print(box.values);

    final pet = box.get('user_with_pets')?.pets?[0];
    print(pet); // Pets name: Snow

    // Compaction
    await box.compact();
    await box.close();

    await petBox.compact();
    await petBox.close();
  }
}

@HiveType(typeId: 0)
class User extends HiveObject {
  // removed HiveFieldId: 2, 3

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(4)
  HiveList<Pet>? pets;

  User(this.name, this.age, this.pets);

  @override
  String toString() => 'Name: $name, age: $age, pets: $pets';
}

@HiveType(typeId: 1)
class Pet extends HiveObject {
  // removed HiveFieldId: None

  @HiveField(0)
  String name;

  Pet(this.name);

  @override
  String toString() => 'Pets name: $name';
}
