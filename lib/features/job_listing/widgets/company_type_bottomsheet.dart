import 'package:flutter/material.dart';
import 'package:jobr/data/models/company_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class CompanyTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(CompanyType companyType) onSelected;

  final String title;

  CompanyTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<CompanyTypeBottomSheet> createState() => _CompanyTypeBottomSheetState();
}

class _CompanyTypeBottomSheetState extends State<CompanyTypeBottomSheet>
    with ScreenStateMixin {
  List<CompanyType> companyTypes = [];
  bool isLoading = false; // NEW

  @override
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return SearchFunctionBottomSheet(
      onSelected: (String value) {
        widget.onSelected.call(companyTypes.firstWhere(
          (element) => element.name == value,
          orElse: () => companyTypes.first,
        ));

        Navigator.of(context).pop();
      },
      options: companyTypes.map((e) => e.name).toList(),
      title: "Bedrijf type",
    );
  }
}
