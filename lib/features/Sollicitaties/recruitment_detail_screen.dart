import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/Sollicitaties/recruitment_screen.dart';
import 'package:jobr/features/job_listing/screens/general/filter_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:jobr/ui/widgets/navigation/jobr_appbar_navigation.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

import '../../ui/theme/jobr_icons.dart';
import '../profile/screens/widgets/custom_job_card.dart';

class RecruitmentDetailScreen extends StatefulWidget {
  final String category;
  final String title;
  final String? image;

  static const String location = 'recruitment/:category';

  static String employerRoute = JobrRouter.getRoute(
    '${RecruitmentScreen.location}/$location',
    JobrRouter.employerInitialroute,
  );

  RecruitmentDetailScreen({
    super.key,
    required this.category,
    required this.title,
    this.image = '',
  });

  @override
  State<RecruitmentDetailScreen> createState() =>
      _RecruitmentDetailScreenState();
}

class _RecruitmentDetailScreenState extends State<RecruitmentDetailScreen>
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
    // Define a constant header height (adjust as necessary)
    const double headerHeight = 70.0;
    return Scaffold(
      appBar: JobrAppbarNavigation(
        trailing: IconButton(
          icon: SvgPicture.asset(
            "assets/images/icons/filter.svg", // Ensure the path is correct and uses .svg extension
            height: 20,
            width: 20,
          ),
          onPressed: () {
            context.push(
              FilterScreen.employerRoute,
            );
          },
        ),
        canGoBack: true,
        appbarTitle: widget.title,
        appBarFontSize: 22,
        prefixIcon: (widget.image != '')
            ? Image.asset(
                widget.image!,
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              )
            : Container(),
      ),
      body: (widget.title == "Sollicitaties")
          ? Stack(
              children: [
                // Scrollable list with top padding to account for header widget and spacing
                ListView.separated(
                  padding: const EdgeInsets.only(
                      top: 16 + headerHeight + 16,
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0),
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: suggestedUsers.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 10, color: Colors.transparent),
                  itemBuilder: (context, index) {
                    final user = suggestedUsers[index];
                    return CustomJobCard(
                      user: user,
                      showLikeButton: (widget.title == 'Sollicitaties'),
                      onButtonPressed: () {
                        context.push(ChatPageScreen.employerRoute);
                      },
                      suggestionPercentage: 75,
                    );
                  },
                ),
                // Positioned header that remains at the top
                Positioned(
                  top: -1,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: HexColor.fromHex('#F5F5F5'),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                width: 45,
                                height: 45,
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  JobrIcons.placeholder1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Brooklyn',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Text(
                                    'Gent, Voorstraat',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          PrimaryButton(
                            buttonText: ' 16 ',
                            onTap: () {
                              context.push(
                                RecruitmentDetailScreen.employerRoute,
                                extra: {
                                  'category': '',
                                  'title': 'Sollicitaties',
                                  "image": "",
                                },
                              );
                            },
                            height: 39,
                            width: 80,
                            icon: Icon(Icons.people),
                            textColor: Colors.white,
                            buttonColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: suggestedUsers.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 10,
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      final user = suggestedUsers[index];
                      return CustomJobCard(
                        user: user,
                        showLikeButton: (widget.title == 'Sollicitaties'),
                        onButtonPressed: () {
                          context.push(ChatPageScreen.employerRoute);
                        },
                        suggestionPercentage: 75,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
