import 'package:flutter/material.dart';
import 'package:jobr/data/models/language.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/search_function_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class LanguageBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(Language language) onSelected;
  final String title;

  LanguageBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet>
    with ScreenStateMixin {
  List<Language> languages = [];

  @override
  Future<void> loadData() async {
    languages = await VacanciesService().getLanguages();

    setState(() {
      languages = languages;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SearchFunctionBottomSheet(
      allowMultipleOptionSelection: true,
      onSelected: (String value) {
        widget.onSelected.call(languages.firstWhere(
          (element) => element.name == value,
          orElse: () => languages.first,
        ));

        Navigator.of(context).pop();
      },
      options: languages.map((e) => e.name).toList(),
      title: "Function type",
    );
  }
}
