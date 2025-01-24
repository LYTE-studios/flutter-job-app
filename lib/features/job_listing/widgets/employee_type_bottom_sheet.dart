import 'package:flutter/material.dart';
import 'package:jobr/data/models/employee_type.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class EmployeeTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(EmployeeType employeeType) onSelected;
  final String title;

  EmployeeTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<EmployeeTypeBottomSheet> createState() =>
      _EmployeeTypeBottomSheetState();
}

class _EmployeeTypeBottomSheetState extends State<EmployeeTypeBottomSheet>
    with ScreenStateMixin {
  List<EmployeeType> employeeTypes = [];

  @override
  Future<void> loadData() async {
    // employeeTypes = await VacanciesService().getEmployeeTypes();
    setState(() {});

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SearchFunctionBottomSheet(
      onSelected: (String value) {
        widget.onSelected.call(employeeTypes.firstWhere(
          (element) => element.name == value,
          orElse: () => employeeTypes.first,
        ));

        Navigator.of(context).pop();
      },
      options: employeeTypes.map((e) => e.name).toList(),
      title: "Employee type",
    );
  }
}
