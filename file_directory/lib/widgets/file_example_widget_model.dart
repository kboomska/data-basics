import 'package:flutter/material.dart';

class FileExampleWidgetModel extends ChangeNotifier {
  void readFile() async {}
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
