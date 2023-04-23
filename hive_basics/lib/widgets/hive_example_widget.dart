import 'package:flutter/material.dart';

// import 'package:hive_basics/widgets/hive_generate_adapter_example_model.dart';
import 'package:hive_basics/widgets/hive_value_listenable_example_model.dart';
// import 'package:hive_basics/widgets/hive_type_adapters_example_model.dart';
// import 'package:hive_basics/widgets/hive_encrypted_box_example_model.dart';
// import 'package:hive_basics/widgets/hive_object_example_model.dart';
// import 'package:hive_basics/widgets/hive_example_model.dart';

class HiveExampleWidget extends StatefulWidget {
  const HiveExampleWidget({super.key});

  @override
  State<HiveExampleWidget> createState() => _HiveExampleWidgetState();
}

class _HiveExampleWidgetState extends State<HiveExampleWidget> {
  // final model = HiveExampleModel();
  // final model = HiveTypeAdaptersExampleModel();
  // final model = HiveGenerateAdapterExampleModel();
  // final model = HiveObjectExampleModel();
  // final model = HiveEncryptedBoxExampleModel();
  final model = HiveValueListenableExampleModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: model.doSome,
                child: const Text('Add'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: model.setup,
                child: const Text('Setup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
