import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

int bigFor(int a) {
  for (int i = 0; i < 50000; i++) {
    print(i);
  }
  return 10;
}

class IsolatesLearning extends StatefulWidget {
  const IsolatesLearning({super.key});

  @override
  State<IsolatesLearning> createState() => _IsolatesLearningState();
}

class _IsolatesLearningState extends State<IsolatesLearning> {
  void _doSomeHeavyComputation() async {
    try {
      await compute<int, void>(bigFor, 10);
    } catch (e) {
      print(e);
    }
  }

  void _doSomeHeavyComputation2() async {
    try {
      IsolateWorker();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolates'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _doSomeHeavyComputation2,
              child: const Text('Do some heavy computation'),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static void isolateEntry(dynamic message) {
    if (message is SendPort) {}
  }
}

class IsolateWorker {
  late Isolate _isolate;

  late SendPort _isolateSendPort;

  late ReceivePort _mainReceivePort;

  final _isolateCompleter = Completer();

  Future<void> get isolateIsReady => _isolateCompleter.future;

  IsolateWorker() {
    _initIsolate();
  }

  void _initIsolate() async {
    _mainReceivePort = ReceivePort();
    _isolate = await Isolate.spawn(_isolateEntry, _mainReceivePort.sendPort);

    _mainReceivePort.listen((message) {
      if (message is SendPort) {
        _isolateSendPort = message;
        _isolateCompleter.complete();
      } else {
        print(message);
      }
    });
    await isolateIsReady;
    _isolateSendPort.send('Olá');
  }

  static void _isolateEntry(dynamic message) {
    late SendPort mainSendPort;

    final receivePort = ReceivePort();

    receivePort.listen(
      (message) {
        print(message);
      },
    );

    if (message is SendPort) {
      mainSendPort = message;
      message.send(receivePort.sendPort);
    }

    mainSendPort.send('LOL');
  }
}
