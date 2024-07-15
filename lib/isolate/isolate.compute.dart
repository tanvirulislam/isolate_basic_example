import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isolate/isolate/isolate.spwan.dart';
import 'package:isolate/isolate/provider.dart';

class IsolateCompute extends ConsumerWidget {
  const IsolateCompute({super.key});

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
            onPressed: () async {
              final result = await compute(heavyTask, loopNumber);
              notifier.addValue(result);
            },
            child: const Text("With isolate"),
          ),
          height10,
          Text("Value: ${provider ?? ''}")
        ],
      ),
    );
  }
}
