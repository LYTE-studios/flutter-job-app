import 'package:flutter/cupertino.dart';

/// A mixin that provides common functionality for managing loading states and error messages.
mixin ScreenStateMixin<T extends StatefulWidget> on State<T> {
  bool loading = false; // Indicates whether the screen is in a loading state.
  String? errorMessage; // Stores an error message if any.

  /// Sets the loading state and updates the UI.
  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  /// A method to load data asynchronously. Can be overridden by subclasses.
  Future<void> loadData() async {}

  @override
  void initState() {
    super.initState();
    Future(() async {
      setLoading(true);
      await loadData();
      setLoading(false);
    });
  }
}