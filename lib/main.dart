import 'package:deep_flutter_learning/isolates/isolates.dart';
import 'package:deep_flutter_learning/lifecycle_of_a_widget/widget_lifecycle.dart';
import 'package:deep_flutter_learning/render_objects/render_objects.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: Home()),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const MyCenter(
                    child: Text('Hello'),
                  ),
                ),
              );
            },
            child: const Text(
              'Custom center',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const IsolatesLearning(),
                ),
              );
            },
            child: const Text(
              'Isolates',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const WidgetLifecycle(),
                ),
              );
            },
            child: const Text(
              'Widget life cycle',
            ),
          )
        ],
      ),
    );
  }
}
