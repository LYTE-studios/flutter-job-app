import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/vacancy.dart';

mixin CreateJobListingMixin<T extends StatefulWidget> on State<T> {
  late Vacancy vacancy;

  @override
  void initState() {
    vacancy = router.state.extra as Vacancy;

    super.initState();
  }
}
