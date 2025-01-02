import 'package:flutter/material.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<Map<String, String>> options = [];
  List<bool> isExpanded = [];
  List<TextEditingController> descriptionControllers = [];

  void addOption(String title) {
    setState(() {
      options.add({'title': title, 'description': ''});
      isExpanded.add(false); // Initially, no option is expanded
      descriptionControllers.add(TextEditingController());
    });
  }

  void updateDescription(int index, String description) {
    setState(() {
      options[index]['description'] = description;
    });
  }

  void toggleExpansion(int index) {
    setState(() {
      isExpanded[index] = !isExpanded[index]; // Toggle expansion state
    });
  }

  void showOptionsBottomSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return const OptionsBottomSheet();
      },
    );

    if (result != null && result.isNotEmpty) {
      addOption(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Nieuwe vacature",
          style: TextStyles.titleMedium,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: HexColor.fromHex("#FF3E68"),
                ),
                height: 6,
                width: MediaQuery.of(context).size.width,
              ),
              Expanded(
                child: Container(
                  height: 6,
                  color: Colors.grey[300], // Remaining 80% width
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Beschrijving",
              style: TextStyles.titleMedium.copyWith(fontSize: 22),
            ),
            Text(
              "Schrijf een inleidende jobbeschrijving en kies \nextra onderwerpen.",
              style: TextStyles.bodyMedium
                  .copyWith(fontSize: 14.5, color: HexColor.fromHex("#6D6D6D")),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              // onTap: showOptionsBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#F7F7F7"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Je job als Barista",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Uit wat bestaat de takenlijst, wat houdt de job juist in, ...",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Display dynamically added options here
                    Column(
                      children: options.asMap().entries.map((entry) {
                        int index = entry.key;
                        String title = entry.value['title']!;
                        String description = entry.value['description']!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              GestureDetector(
                                onTap: () => toggleExpansion(index),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Expandable description with ellipsis
                              if (description.isNotEmpty) ...[
                                // If description exists, show full description
                                if (!isExpanded[index]) ...[
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                                // Show the full description when expanded
                                if (isExpanded[index]) ...[
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ] else ...[
                                // If description doesn't exist, show text field
                                if (!isExpanded[index]) ...[
                                  TextField(
                                    controller: descriptionControllers[index],
                                    onChanged: (value) {
                                      updateDescription(index, value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Type here...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none, // No border
                                    ),
                                    maxLines: 4,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ]
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    // Button to add new option
                    GestureDetector(
                      onTap: showOptionsBottomSheet,
                      child: const Text(
                        '+ Kies onderwerp',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      "Een uitkomst is vereist voor deze job",
      "Een diploma/opleiding is vereist voor deze job",
      "Je haalt energie uit...",
      "Je prioriteiten zijn...",
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                "Kies onderwerp",
                style: TextStyles.titleMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      options[index],
                      style: TextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                    onTap: () => Navigator.pop(context, options[index]),
                  ),
                  const Divider(
                    thickness: 0.5,
                  )
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
