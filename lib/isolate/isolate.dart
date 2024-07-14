import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isolate/isolate/isolate.spwan.dart';

class IsolateExample extends ConsumerWidget {
  const IsolateExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Isolate basic Example"),
          bottom: const TabBar(tabs: [
            Tab(text: "Spwan"),
            Tab(text: "Compute"),
          ]),
        ),
        body: const TabBarView(
          children: [
            IsolateSpwan(),
            Text("data 2"),
          ],
        ),
      ),
    );
  }
}
