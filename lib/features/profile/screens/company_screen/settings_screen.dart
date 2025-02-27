import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/configuration.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/features/authentication/screens/splash_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';

class SettingsScreen extends StatefulWidget {
  static const location = 'settings';

  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with ScreenStateMixin {
  String versionNumber = '';

  @override
  Future<void> loadData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      versionNumber = packageInfo.version;
    });

    return super.loadData();
  }

  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 8,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 29.0),
                          child: Text(
                            content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: onConfirm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14), // Adjusted padding
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.8,
                                50), // Set a fixed height
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/icons/cross.svg',
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    _showCustomDialog(
      context: context,
      title: 'Weet je zeker dat je wilt uitloggen?',
      content: 'Uitloggen zal je sessie beëindigen.',
      buttonText: 'Uitloggen',
      onConfirm: () async {
        await AccountsService().logout();
        context.pop();
        router.pushReplacement(SplashScreen.route);
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    _showCustomDialog(
      context: context,
      title: 'Weet je zeker dat je je account wilt verwijderen?',
      content:
          'Verwijderen is een permanente actie en kan niet worden teruggedraaid.',
      buttonText: 'Account verwijderen',
      onConfirm: () {
        // Handle delete account action
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/images/icons/cross.svg',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Instellingen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                buildListTile(
                  title: 'Privacybeleid',
                  onTap: () {
                    launchUrl(Uri.parse(privacyPolicyUrl));
                  },
                ),
                buildListTile(
                  title: 'Algemene voorwaarden',
                  onTap: () {
                    launchUrl(Uri.parse(tosUrl));
                  },
                ),
                buildListTile(
                  title: 'Betalingen herstellen',
                  onTap: () {
                    // Handle navigation to Betalingen herstellen
                  },
                ),
                buildListTile(
                  title: 'Account Settings',
                  onTap: () {
                    // Handle navigation to Betalingen herstellen
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            bottom: true,
            child: Column(
              children: [
                PrimaryButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  textColor: Colors.grey,
                  buttonColor: Color(0xFFF7F7F7),
                  height: 50,
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    _showLogoutDialog(context);
                  },
                  buttonText: 'Uitloggen',
                ),
                SizedBox(height: 8),
                PrimaryButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  textColor: Colors.red,
                  buttonColor: Color(
                      0xFFFEF4F4), // Colors.red.shade100.withOpacity(0.3),
                  height: 50,
                  onTap: () {
                    _showDeleteDialog(context);
                  },
                  buttonText: 'Account verwijderen',
                ),
                SizedBox(height: 24),
                Text(
                  'Version $versionNumber',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 21),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.black,
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(height: 1, color: Colors.grey[300]),
    );
  }
}
