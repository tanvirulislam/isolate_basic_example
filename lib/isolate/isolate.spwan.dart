import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isolate/isolate/provider.dart';

class IsolateSpwan extends ConsumerWidget {
  const IsolateSpwan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(countProvider);
    final notifier = ref.read(countProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const CircularProgressIndicator(),
          height10,
          ElevatedButton(
            onPressed: () {
              final val = heavyTask(loopNumber);
              notifier.addValue(val);
            },
            child: const Text("Without isolate"),
          ),
          height10,
          ElevatedButton(
            onPressed: () => withIsolate(ref),
            child: const Text("With isolate"),
          ),
          height10,
          Text("Value: ${provider ?? ''}")
        ],
      ),
    );
  }
}

int heavyTask(int number) {
  int initialValue = 0;
  for (var i = 0; i < number; i++) {
    initialValue++;
  }
  return initialValue;
}

void withIsolate(WidgetRef ref) {
  final receivePort = ReceivePort();
  Isolate.spawn(count, receivePort.sendPort);
  receivePort.listen(
    (message) {
      ref.read(countProvider.notifier).addValue(message);
    },
  );
}

void count(SendPort port) {
  int initialValue = 0;
  for (var i = 0; i < loopNumber; i++) {
    initialValue++;
  }
  port.send(initialValue);
}

SizedBox height10 = const SizedBox(height: 10);
int loopNumber = 4000000000;
