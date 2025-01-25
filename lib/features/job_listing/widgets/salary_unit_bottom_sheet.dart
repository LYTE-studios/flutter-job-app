import 'package:flutter/material.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/base_option_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class SalaryUnitTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(String salaryUnitType) onSelected;
  final String title;

  SalaryUnitTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<SalaryUnitTypeBottomSheet> createState() =>
      _SalaryUnitTypeBottomSheetState();
}

class _SalaryUnitTypeBottomSheetState extends State<SalaryUnitTypeBottomSheet>
    with ScreenStateMixin {
  List<String> salaryUnitTypes = ['Per uur', 'Per maand', 'Per jaar'];

  @override
  Future<void> loadData() async {
    // salaryUnitTypes = await VacanciesService().getsalaryUnitTypes();

    // setState(() {
    //   salaryUnitTypes = salaryUnitTypes;
    // });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOptionBottomSheet(
      title: "Kies een contract type",
      loading: loading,
      options: salaryUnitTypes.map((e) => e).toList(),
      onSelected: (index) {
        widget.onSelected.call(salaryUnitTypes[index]);

        Navigator.pop(context);
      },
    );
  }
}
