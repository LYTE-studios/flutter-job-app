import 'package:flutter/material.dart';
import 'package:jobr/data/models/company_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/models/status_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class StatusTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(StatusType statusType) onSelected;

  final String title;

  StatusTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<StatusTypeBottomSheet> createState() => _StatusTypeBottomSheetState();
}

class _StatusTypeBottomSheetState extends State<StatusTypeBottomSheet>
    with ScreenStateMixin {
  List<StatusType> statusTypes = [];
  bool isLoading = false; // NEW

  @override
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SearchFunctionBottomSheet(
      description: 'Zoek een statuut type',
      onSelected: (String value) {
        widget.onSelected.call(statusTypes.firstWhere(
          (element) => element.name == value,
          orElse: () => statusTypes.first,
        ));

        Navigator.of(context).pop();
      },
      options: statusTypes.map((e) => e.name).toList(),
      title: "Statuut type",
    );
  }
}
