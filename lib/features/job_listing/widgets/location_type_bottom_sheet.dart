import 'package:flutter/material.dart';
import 'package:jobr/data/models/location_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/job_listing/widgets/base_option_bottom_sheet.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class LocationTypeBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(LocationType locationType) onSelected;
  final String title;

  LocationTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.title,
  });

  @override
  State<LocationTypeBottomSheet> createState() =>
      _LocationTypeBottomSheetState();
}

class _LocationTypeBottomSheetState extends State<LocationTypeBottomSheet>
    with ScreenStateMixin {
  List<LocationType> locationType = [];

  @override
  Future<void> loadData() async {
    locationType = await VacanciesService().getLocationTypes();

    setState(() {
      locationType = locationType;
    });

    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseOptionBottomSheet(
      title: "Location",
      loading: loading,
      options: locationType.map((e) => e.name).toList(),
      onSelected: (index) {
        widget.onSelected.call(locationType[index]);

        Navigator.pop(context);
      },
    );
  }
}
