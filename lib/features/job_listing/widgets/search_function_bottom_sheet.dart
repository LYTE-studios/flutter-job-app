import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/navigation/jobr_loading_switcher.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class SearchFunctionBottomSheet extends StatefulWidget with BottomSheetMixin {
  final void Function(String value) onSelected;
  final List<String> options;
  final String title;
  final bool allowMultipleOptionSelection;

  final bool loading;

  const SearchFunctionBottomSheet({
    super.key,
    required this.onSelected,
    required this.options,
    required this.title,
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
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredOptions = [];

  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
    _searchController.addListener(_filterOptions);
  }

  void _filterOptions() {
    setState(() {
      filteredOptions = widget.options
          .where((option) => option
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
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
              const SizedBox(
                width: 60,
              ),
              Center(
                child: Text(
                  widget.title,
                  style: TextStyles.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            cursorHeight: 20,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
            decoration: InputDecoration(
              hintText: "Zoek een functie",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: Colors.grey[400]),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, bottom: 12, left: 12, right: 8),
                child: SvgPicture.asset(
                  'assets/images/icons/search.svg',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 72,
                  ),
                  itemCount: filteredOptions.length,
                  itemBuilder: (context, index) {
                    final option = filteredOptions[index];
                    final isSelected = widget.allowMultipleOptionSelection
                        ? selectedOptions.contains(option)
                        : selectedOption == option;

                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        title: Text(
                          option,
                          style: TextStyles.titleMedium.copyWith(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.pinkAccent
                                  : Colors.black),
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
                            Colors.pink.shade50.withOpacity(0.6),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () {
                            if (widget.allowMultipleOptionSelection) {
                              if (selectedOptions.isNotEmpty) {
                                widget.onSelected(selectedOptions.join(', '));
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
