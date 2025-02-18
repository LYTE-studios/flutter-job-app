import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/edit/fill_choice_form.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../../../ui/theme/jobr_icons.dart';

class MakeAChoiceScreen extends StatefulWidget {
  static const String location = 'make-a-choice';
  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  const MakeAChoiceScreen({super.key});

  @override
  State<MakeAChoiceScreen> createState() => _MakeAChoiceScreenState();
}

class _MakeAChoiceScreenState extends State<MakeAChoiceScreen> {
  // Create the category list
  final categories = [
    CategoryModel(
      category: "Sport & vrije tijd",
      items: [
        ItemModel(id: 1, text: "Ik haal mijn energie uit..."),
        ItemModel(id: 2, text: "Mijn favoriete boek is..."),
        ItemModel(id: 3, text: "Wat ik belangrijk vind is..."),
        ItemModel(id: 4, text: "Zo omschrijf ik mezelf in 3 woorden"),
        ItemModel(id: 5, text: "Ik sta elke dag op om..."),
        ItemModel(
            id: 6,
            text: "Dit is wat ik het liefste doe na een hele lange werkdag"),
      ],
    ),
    CategoryModel(
      category: "Carrière",
      items: [
        ItemModel(id: 1, text: "Ik haal mijn energie uit..."),
        ItemModel(id: 2, text: "Mijn favoriete boek is..."),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.close,
              width: 15,
              height: 15,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Maak een keuze",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                categories[index].category,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Divider(color: Color(0xFF000000).withOpacity(0.05)),
              const SizedBox(height: 5),
              ...categories[index].items.map(
                    (item) => InkWell(
                      onTap: () => context.push(
                        FillChoiceForm.route,
                        extra: item.text,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex('#F8F8F8'),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SvgPicture.asset(
                              JobrIcons.blockquote,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.text,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryModel {
  final String category;
  final List<ItemModel> items;

  CategoryModel({
    required this.category,
    required this.items,
  });
}

class ItemModel {
  final int id;
  final String text;

  ItemModel({
    required this.id,
    required this.text,
  });
}
