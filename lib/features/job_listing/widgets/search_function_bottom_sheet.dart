import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/navigation/jobr_loading_switcher.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SearchFunctionBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(String value) onSelected;
  final List<String> options;
  final String title;
  final String? description;
  final bool allowMultipleOptionSelection;

  final bool loading;

  SearchFunctionBottomSheet({
    super.key,
    required this.onSelected,
    required this.options,
    required this.title,
    this.description,
    this.allowMultipleOptionSelection = false,
    this.loading = false,
  });

  @override
  State<SearchFunctionBottomSheet> createState() =>
      _SearchFunctionBottomSheetState();
}

class _SearchFunctionBottomSheetState extends State<SearchFunctionBottomSheet> {
  String? selectedOption;
  List<String> selectedOptions = [];

  late List<String> options = widget.options;

  late List<String> initialOptions = widget.options;

  late final TextEditingController _searchController = TextEditingController()
    ..addListener(() {
      setState(() {
        if (_searchController.text.isNotEmpty) {
          options = widget.options
              .where((option) => option
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();

          if (selectedOption != null) {
            if (!options.contains(selectedOption)) options.add(selectedOption!);
          }

          for (String option in selectedOptions) {
            if (!options.contains(option)) {
              options.add(option);
            }
          }
        } else {
          options = widget.options;
        }
      });
    });

  @override
  Widget build(BuildContext context) {
    if (initialOptions != widget.options) {
      initialOptions = widget.options;
      options = widget.options;
      _searchController.clear();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: PaddingSizes.small,
          right: PaddingSizes.small,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            size: 29,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            widget.title,
                            style: TextStyles.titleMedium,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 56,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            TextField(
              cursorHeight: 24,
              controller: _searchController,
              style: TextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: widget.description ?? "Zoek een functie",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey[400],
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 12,
                    left: 12,
                    right: 8,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/icons/search.svg',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  JobrLoadingSwitcher(
                    loading: widget.loading,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: PaddingSizes.small,
                        bottom: 89,
                      ),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = widget.allowMultipleOptionSelection
                            ? selectedOptions.contains(option)
                            : selectedOption == option;

                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            title: Text(
                              option,
                              style: TextStyles.titleMedium.copyWith(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.black,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (widget.allowMultipleOptionSelection) {
                                  if (isSelected) {
                                    selectedOptions.remove(option);
                                  } else {
                                    selectedOptions.add(option);
                                  }
                                } else {
                                  selectedOption = option;
                                }
                              });
                            },
                            selected: isSelected,
                            selectedTileColor:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 58,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: (selectedOption != null ||
                                        selectedOptions.isNotEmpty)
                                    ? HexColor.fromHex("#FF3E68")
                                    : HexColor.fromHex('#DADADA'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(65),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onPressed: () {
                                if (widget.allowMultipleOptionSelection) {
                                  if (selectedOptions.isNotEmpty) {
                                    widget
                                        .onSelected(selectedOptions.join(', '));
                                  }
                                } else {
                                  if (selectedOption != null) {
                                    widget.onSelected(selectedOption!);
                                  }
                                }
                              },
                              child: const Text(
                                "Bevestigen",
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
