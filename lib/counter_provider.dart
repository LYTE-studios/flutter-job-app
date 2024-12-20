import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateNotifier for managing counter state
class CounterNotifier extends StateNotifier<int> {
  // Initialize with 0
  CounterNotifier() : super(0);

  // Increment method
  void increment() {
    state++;
  }

  // Decrement method
  void decrement() {
    state--;
  }
}

// Create the provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
