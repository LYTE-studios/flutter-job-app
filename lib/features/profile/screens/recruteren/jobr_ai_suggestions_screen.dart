import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/recruteren_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widget/common_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class JobrAiSuggestionsScreen extends StatelessWidget {
  static const String location = '/ai-suggestions';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruterenScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  const JobrAiSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarNavigation(
        appbarTitle: 'Jobr-AI suggesties',
        canGoBack: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return CustomJobCard(
            description:
                "Ik ben Yassine, 20 jaar en super gemotiveerd om doen waar ik het beste in ben: mensen de beste serv klasjdnas sdakldnas dalskdnalksn lkasjdlks lmasndklnasl dlasndlknasl dasln",
            age: "20",
            buttonColor: HexColor.fromHex('#3976FF'),
            buttonText: "Chat starten",
            buttonIcon: JobrIcons.send,
            location: "Brussel",
            userName: "Yassine Vuran",
            onButtonPressed: () {},
            profileImagePath: "assets/images/images/image-3.png",
            suggestionPercentage: "74",
            showBottomText: true,
          );
        },
      ),
    );
  }
}
