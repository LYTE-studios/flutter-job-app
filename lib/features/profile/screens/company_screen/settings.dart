import 'package:flutter/material.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/profile/screens/company_screen/social_button.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';

class SettingsScreen extends StatelessWidget {
  static const location = 'settings';

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0,
              elevation: 0,
              leading: innerBoxIsScrolled
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/image-6.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : null,
              backgroundColor: theme.colorScheme.surface,
              clipBehavior: Clip.none,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    // Background Image
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/images/profile_image.png',
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),

                    // Circular Profile Image
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/image-6.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    // Close Button
                    const Positioned(
                      top: 60,
                      left: 20,
                      child: CloseButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Social Media Links
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row with Facebook and TikTok
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildSocialButton(
                          icon: JobrIcons.facebook,
                          label: 'Toevoegen',
                          showPlus: true,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                        buildSocialButton(
                          icon: JobrIcons.tiktok,
                          label: 'Toevoegen',
                          showPlus: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 5 / 2),
                    // Second row with Instagram
                    buildSocialButton(
                      icon: JobrIcons.instagram,
                      label: '@brooklyn.be',
                      showClose: true,
                      isInstagram: true,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Company Information Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow("Bedrijfsnaam", "Brooklyn"),
                    _buildInfoRow("Website", "www.brooklyn.be"),
                    _buildInfoRowWithIcon(
                      "Locatie",
                      "Kortrijk",
                      Icons.location_pin,
                    ),
                    _buildInfoRow("Werknemers", "2-10 werknemers"),
                    _buildInfoRow(
                      "Bio",
                      "Multibrandstores & Webshop. Brooklyn, dat's een mix van merken en heel veel broeken. Dat laatste nemen we als broekspecialist au sérieux met een jeans assortiment om 'u' tegen te zeggen.",
                    ),
                    _buildInfoRow("Aantal vestigingen", "Kies een aantal"),
                    _buildInfoRow("Sector", "Maak een keuze"),
                    _buildRowWithButtons("Interne opleiding"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: TextStyles.deepgrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildInfoRowWithIcon(String title, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  color: TextStyles.deepgrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.pink, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildRowWithButtons(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.79,
                  fontFamily: 'Inter',
                  color: TextStyles.deepgrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pink,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.35),
                          ),
                        ),
                        child: const Text(
                          "Ja",
                          style: TextStyle(
                            fontSize: 16.79,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: const Color(0xFFF8F8F8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Nee",
                          style: TextStyle(
                            fontSize: 16.79,
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFFEEEEEE),
                  ),
                ],
              ),
            ),
          ],
        ),
        //const SizedBox(height: 8),
      ],
    );
  }
}
