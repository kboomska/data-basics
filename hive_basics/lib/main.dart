import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_basics/app/my_app.dart';

void main() async {
  // if main() is asyncronous, then need to add this line:
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  const app = MyApp();
  runApp(app);
}
