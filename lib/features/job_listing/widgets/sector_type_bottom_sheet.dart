import 'package:flutter/material.dart';
import 'package:jobr/data/models/sector_type.dart';
import 'package:jobr/features/job_listing/widgets/base_option_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class SectorTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(SectorType SectorType) onSelected;
  final String title;

  SectorTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<SectorTypeBottomSheet> createState() =>
      _SectorTypeBottomSheetState();
}

class _SectorTypeBottomSheetState extends State<SectorTypeBottomSheet>
    with ScreenStateMixin {
  List<SectorType> SectorTypes = [];

  @override
  Future<void> loadData() async {
    // SectorTypes = await VacanciesService().getSectorTypes();

    setState(() {
      // SectorTypes = SectorTypes;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOptionBottomSheet(
      title: "Section type",
      loading: loading,
      options: SectorTypes.map((e) => e.name).toList(),
      onSelected: (index) {
        widget.onSelected.call(SectorTypes[index]);

        Navigator.pop(context);
      },
    );
  }
}
