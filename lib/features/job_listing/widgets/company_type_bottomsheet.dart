import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/company_type.dart';
import 'package:jobr/data/models/function_type.dart';
import 'package:jobr/data/services/vacancies_service.dart';
import 'package:jobr/features/profile/screens/edit/create_new_company_screen.dart';
import 'package:jobr/ui/mixins/bottom_sheet_mixin.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/navigation/jobr_loading_switcher.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

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
    return SearchCompanyTypeBottomSheet(
      onSelected: (String value) {
        widget.onSelected.call(companyTypes.firstWhere(
          (element) => element.name == value,
          orElse: () => companyTypes.first,
        ));

        Navigator.of(context).pop();
      },
      options: companyTypes.map((e) => e.name).toList(),
      title: "kies een bedrijf",
      description: 'Zoek een bedrijf',
    );
  }
}

class SearchCompanyTypeBottomSheet extends StatefulWidget
    with BottomSheetMixin {
  final void Function(String value) onSelected;
  final List<String> options;
  final String title;
  final String? description;

  SearchCompanyTypeBottomSheet({
    super.key,
    required this.onSelected,
    required this.options,
    required this.title,
    this.description,
  });

  @override
  State<SearchCompanyTypeBottomSheet> createState() =>
      _SearchCompanyTypeBottomSheetState();
}

class _SearchCompanyTypeBottomSheetState
    extends State<SearchCompanyTypeBottomSheet> {
  String? selectedOption;

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
          top: PaddingSizes.small,
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
                    loading: false,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: PaddingSizes.small,
                        bottom: 89,
                      ),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        final isSelected = selectedOption == option;

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
                                selectedOption = option;
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
                                backgroundColor: HexColor.fromHex("#FF3E68"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(65),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              onPressed: () {
                                if (selectedOption == null) {
                                  context.push(CreateNewCompanyScreen.route);
                                } else {
                                  widget.onSelected(selectedOption!);
                                }
                              },
                              child: Text(
                                selectedOption == null
                                    ? "Nieuw bedrijf toevoegen"
                                    : "Bevestigen",
                                style: const TextStyle(
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
