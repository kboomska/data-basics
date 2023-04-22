import 'dart:io';

import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:flutter/material.dart';

class FileExampleWidgetModel extends ChangeNotifier {
  void readFile() async {
    // pathProvider.getApplicationDocumentsDirectory();
    // pathProvider.getApplicationSupportDirectory();
    // pathProvider.getTemporaryDirectory();
    // pathProvider.getLibraryDirectory();

    final directory = await pathProvider.getApplicationDocumentsDirectory();

    final filePath = '${directory.path}/test_file';
    final file = File(filePath);
    print(filePath);

    // final isExist = await file.exists(); // false
    await file.writeAsString('Hello Flutter!');

    final isExist = await file.exists(); // true
    print(isExist);

    if (!isExist) {
      await file.create();
    }

    final result = await file.readAsString();
    print(result);

    // Image.file(file); // Read an image

    final stat = await file.stat();
    print(stat);

    print(directory.parent);
    print(directory.uri);

    final fileSinc = file.openWrite();
    fileSinc.close(); // It's important to close the file!
  }
}

class FileExampleWidgetProvider extends InheritedNotifier {
  final FileExampleWidgetModel model;

  const FileExampleWidgetProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static FileExampleWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FileExampleWidgetProvider>();
  }

  static FileExampleWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<FileExampleWidgetProvider>()
        ?.widget;
    return widget is FileExampleWidgetProvider ? widget : null;
  }
}
