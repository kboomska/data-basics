import 'package:flutter/material.dart';

import 'package:hive_basics/widgets/hive_generate_adapter_example_model.dart';
import 'package:hive_basics/widgets/hive_type_adapters_example_model.dart';
import 'package:hive_basics/widgets/hive_example_model.dart';

class HiveExampleWidget extends StatefulWidget {
  const HiveExampleWidget({super.key});

  @override
  State<HiveExampleWidget> createState() => _HiveExampleWidgetState();
}

class _HiveExampleWidgetState extends State<HiveExampleWidget> {
  // final model = HiveExampleModel();
  // final model = HiveTypeAdaptersExampleModel();
  final model = HiveGenerateAdapterExampleModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: model.doSome,
            child: const Text('Press'),
          ),
        ),
      ),
    );
  }
}
