import 'package:flutter/material.dart';
import 'package:jobr/data/models/contract_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'search_contract_bottom_sheet.dart'; // new file

class ContractTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(List<ContractType> contractTypes) onSelected; // changed signature
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
  bool isLoading = false;

  @override
  Future<void> loadData() async {
    setState(() => isLoading = true);
    contractTypes = await VacanciesService().getContractTypes();
    setState(() {
      isLoading = false;
    });
    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SearchContractBottomSheet(
      allowMultipleOptionSelection: true, // enable multiple selections
      onSelected: (String value) {
        // value is comma separated, e.g.: "Option1, Option2"
        List<String> names = value.split(', ');
        List<ContractType> selected = contractTypes
            .where((ct) => names.contains(ct.name))
            .toList();
        widget.onSelected(selected);
        Navigator.of(context).pop();
      },
      options: contractTypes.map((e) => e.name).toList(),
      title: "Contract type",
      description: "Zoek een contract type",
    );
  }
}
