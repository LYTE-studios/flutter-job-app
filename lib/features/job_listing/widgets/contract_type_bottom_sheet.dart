import 'package:flutter/material.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/base_option_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class ContractTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(ContractType contractType) onSelected;
  final String title;

  ContractTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<ContractTypeBottomSheet> createState() =>
      _ContractTypeBottomSheetState();
}

class _ContractTypeBottomSheetState extends State<ContractTypeBottomSheet>
    with ScreenStateMixin {
  List<ContractType> contractTypes = [];

  @override
  Future<void> loadData() async {
    contractTypes = await VacanciesService().getContractTypes();

    setState(() {
      contractTypes = contractTypes;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOptionBottomSheet(
      title: "Contract type",
      loading: loading,
      options: contractTypes.map((e) => e.name).toList(),
      onSelected: (index) {
        widget.onSelected.call(contractTypes[index]);

        Navigator.pop(context);
      },
    );
  }
}
