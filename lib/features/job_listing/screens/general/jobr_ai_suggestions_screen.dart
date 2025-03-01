import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/profile/screens/widgets/custom_job_card.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';

class JobrAiSuggestionsScreen extends StatefulWidget {
  static const String location = 'ai-suggestions';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruitmentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  const JobrAiSuggestionsScreen({super.key});

  @override
  State<JobrAiSuggestionsScreen> createState() =>
      _JobrAiSuggestionsScreenState();
}

class _JobrAiSuggestionsScreenState extends State<JobrAiSuggestionsScreen>
    with ScreenStateMixin {
  List<User> suggestedUsers = [];

  @override
  Future<void> loadData() async {
    suggestedUsers = await AccountsService().getAiSuggestions();
    setState(() {
      suggestedUsers = suggestedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JobrAppbarNavigation(
        appbarTitle: 'Jobr-AI suggesties',
        canGoBack: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        itemCount: suggestedUsers.length,
        itemBuilder: (context, index) {
          final user = suggestedUsers[index];
          return CustomJobCard(
            user: user,
            suggestionPercentage: 74,
            onButtonPressed: () {
              context.push(ChatPageScreen.employerRoute);
            },
          );
        },
      ),
    );
  }
}
