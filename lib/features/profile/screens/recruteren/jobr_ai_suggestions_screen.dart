import 'package:flutter/material.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrAiSuggestionsScreen extends StatelessWidget {
  static const String route = '/jobr-ai-suggestions';
  static const String location = 'suggestions';

  const JobrAiSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Jobr-AI Suggesties",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return CustomJobCard(
            description:
                "Ik ben Yassine, 20 jaar en super gemotiveerd om doen waar ik het beste in ben: mensen de beste serv",
            age: "20",
            buttonColor: HexColor.fromHex('#3976FF'),
            buttonText: "Chat starten",
            buttonIcon: JobrIcons.send,
            location: "Brussel",
            userName: "Yassine Vuran",
            onButtonPressed: () {},
            profileImagePath: "assets/images/images/image-3.png",
            suggestionPercentage: "74",
          );
        },
      ),
    );
  }
}
