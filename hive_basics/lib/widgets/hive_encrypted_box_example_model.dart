import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_encrypted_box_example_model.g.dart';

class HiveEncryptedBoxExampleModel {
// Hive.initFlutter() is in main() now!

  void doSome() async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryptionKeyString = await secureStorage.read(key: 'key');

    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'key',
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: 'key');

    final encryptionKeyUint8List = base64Url.decode(key!);

    print('Encryption key Uint8List: $encryptionKeyUint8List');

    final encryptedBox = await Hive.openBox(
      'vaultBox',
      encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
    );

    encryptedBox.put('secret', 'Hive is cool');

    print(encryptedBox.get('secret'));
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
