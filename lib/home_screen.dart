import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_provider.dart';

final greetingProvider = Provider<String>((ref) {
  return "Hello world";
});
