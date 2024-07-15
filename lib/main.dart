import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isolate/isolate/isolate.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IsolateExample(),
      // home: const Countdown(),
    );
  }
}

StreamController controller = StreamController();

class Countdown extends ConsumerWidget {
  const Countdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    countDown(60);
    return Scaffold(
      appBar: AppBar(title: const Text("Example of Stream Controller")),
      body: StreamBuilder(
        stream: controller.stream,
        initialData: iniTialValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print(snapshot.data);
          return Text(snapshot.data.toString());
        },
      ),
    );
  }
}

int iniTialValue = 60;

void countDown(int from) {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (from >= 0) {
      controller.sink.add(from);
      from--;
    } else {
      timer.cancel();
      controller.close();
    }
  });
}
