import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({super.key});

  @override
  State<WidgetLifecycle> createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {
  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    SchedulerBinding.instance.addPersistentFrameCallback((r) {
      print(SchedulerBinding.instance.schedulerPhase);
    });
    // Future.delayed(Duration.zero, () {
    //   print(SchedulerBinding.instance.schedulerPhase);
    // });

    scheduleMicrotask(() async {
      print(SchedulerBinding.instance.schedulerPhase);
      await Future.delayed(Duration.zero);
      print(SchedulerBinding.instance.schedulerPhase);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(SchedulerBinding.instance.schedulerPhase);

    return Scaffold(
      appBar: AppBar(title: const Text('WidgetLifecycle')),
    );
  }
}
