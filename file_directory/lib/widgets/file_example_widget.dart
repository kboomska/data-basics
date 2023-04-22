import 'package:flutter/material.dart';

import 'file_example_widget_model.dart';

class FileExampleWidget extends StatefulWidget {
  const FileExampleWidget({super.key});

  @override
  State<FileExampleWidget> createState() => _FileExampleWidgetState();
}

class _FileExampleWidgetState extends State<FileExampleWidget> {
  final _model = FileExampleWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FileExampleWidgetProvider(
            model: _model,
            child: Column(
              children: const [
                _ReadFileButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReadFileButton extends StatelessWidget {
  const _ReadFileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: FileExampleWidgetProvider.read(context)!.model.readFile,
      child: const Text('Read file'),
    );
  }
}
