import 'package:hive_flutter/hive_flutter.dart';

class HiveExampleModel {
  HiveExampleModel() {
    Hive.initFlutter();
  }
  Future<void> doSome() async {
    var box = await Hive.openBox<dynamic>('testBox');

    await box.put('name', 'Ivan');
    await box.put('age', 29);

    final name = box.get('name') as String?;
    print(name);

    final age = box.get('age') as int?;
    print(age);

    // await box.put('surname', 'Petrov');
    final surname = box.get('surname', defaultValue: 'undefined') as String;
    print(surname);

    await box.put('friends', ['Igor', 'Vladislav', 'Makar']);
    final friends = box.get('friends') as List<String>?;
    print(friends);

    await box
        .putAll({0: 'the key is integer', 'another_key': 'something else'});
    final dynamic value = box.get('another_key');
    print(value);

    final index = await box.add(['List', 'of', 'String']);
    final dynamic listValue = box.getAt(index);
    print(listValue);
    print(index); // index = 1, because earlier we put a value with key 0.

    print('');

    print(box.keys.toList());
    await box.delete(1);
    print(box.keys.toList());

    print('');

    await box.put('emptyValue', null);
    print(box.keys.toList());
    print(box.values.toList());

    await box.clear();
    print(box.isEmpty);

    await box.close();

    // await box.deleteFromDisk();

    // Hive.box('testBox');
    // Hive.lazyBox();
  }
}
