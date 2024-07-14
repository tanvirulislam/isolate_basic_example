import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = NotifierProvider<CountNotifier, int?>(CountNotifier.new);

class CountNotifier extends Notifier<int?> {
  @override
  build() => null;
  void addValue(int number) {
    // final value = count(number);
    state = number;
    Future.delayed(
      const Duration(seconds: 3),
      () => ref.invalidateSelf(),
    );
  }
}
