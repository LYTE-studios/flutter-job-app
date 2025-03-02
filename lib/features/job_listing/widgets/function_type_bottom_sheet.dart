import 'package:flutter/material.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class FunctionTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final FunctionType? selectedOption; // New parameter
  final void Function(FunctionType functionType) onSelected;
  final String title;
  final bool showTitle;

  FunctionTypeBottomSheet({
    super.key,
    this.showTitle = false,
    this.selectedOption, // Pass older selection
    required this.onSelected,
    required this.title,
  });

  @override
  State<FunctionTypeBottomSheet> createState() =>
      _FunctionTypeBottomSheetState();
}

class _FunctionTypeBottomSheetState extends State<FunctionTypeBottomSheet>
    with ScreenStateMixin {
  List<FunctionType> functionTypes = [];
  bool isLoading = false; // NEW

  @override
  Future<void> loadData() async {
    setState(() => isLoading = true);
    functionTypes = await VacanciesService().getFunctionTypes();
    setState(() {
      isLoading = false;
      functionTypes = functionTypes;
    });
    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SearchFunctionBottomSheet(
      onSelected: (String value) {
        widget.onSelected.call(functionTypes.firstWhere(
          (element) => element.name == value,
          orElse: () => functionTypes.first,
        ));

        Navigator.of(context).pop();
      },
      options: functionTypes.map((e) => e.name).toList(),
      title: widget.showTitle ? widget.title : "Function type",
      initiallySelectedOption:
          widget.selectedOption?.name, // highlight previous
    );
  }
}
