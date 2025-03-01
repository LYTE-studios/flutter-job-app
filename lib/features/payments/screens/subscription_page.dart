import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/configuration.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.grey),
          children: [
            const TextSpan(
              text: 'Door door te gaan ga je akkoord met ',
            ),
            TextSpan(
              text: 'onze voorwaarden.',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.grey, // Changed from blue to grey
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  const url = tosUrl;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch $url';
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPage extends StatefulWidget {
  static const String location = 'subscription_page';

  static String route = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Kies je plan',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            splashColor: Colors.transparent, // New: removes splash color
            highlightColor: Colors.transparent, // New: removes highlight color
            icon: Padding(
              // Removed 'const' from Padding
              padding: const EdgeInsets.only(left: 14.0),
              child: SvgPicture.asset(
                JobrIcons.close,
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                width: 15,
                height: 15,
              ),
            ),
            onPressed: () {
              context.pop();
            },
          ),
          bottom: TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            padding: const EdgeInsets.symmetric(horizontal: 70),
            overlayColor: MaterialStateProperty.all(
                Colors.transparent), // New line to remove pink overlay
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFFADADAD)),
            tabs: const [
              Tab(text: 'Maandelijks'),
              Tab(text: 'Jaarlijks'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MonthlyPlans(),
            YearlyPlans(),
          ],
        ),
      ),
    );
  }
}

class MonthlyPlans extends StatefulWidget {
  const MonthlyPlans({super.key});

  @override
  State<MonthlyPlans> createState() => _MonthlyPlansState();
}

class _MonthlyPlansState extends State<MonthlyPlans> {
  int selectedIndex = 2; // Default select "Scale" card

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 0),
              child: PlanCard(
                title: 'Starter',
                price: 'Gratis',
                description: 'Maak kennis met jobr',
                offers: ' 📍 1 vestiging   📄 1 vacature',
                isSelected: selectedIndex == 0,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 1),
              child: PlanCard(
                title: 'Local ⚡',
                price: '€59,90',
                description: 'Ideaal voor lokale zaken',
                offers:
                    ' 📍 1 vestiging   📄 2 vacatures\n 🔍 AI matchmaking   ✔️ Custom vragenlijst',
                isPopular: true,
                isSelected: selectedIndex == 1,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 2),
              child: PlanCard(
                title: 'Scale',
                price: '€69,90',
                description: 'Voor groeiende kmo’s',
                offers:
                    ' ∞ Onbeperkte kandidaten \n 🔍 AI matchmaking   ✔️ Custom vragenlijst   \n👀 Wie bekeek mijn vacature?',
                backgroundColor: const Color(0x0DFF3E68),
                isSelected: selectedIndex == 2,
              ),
            ),
            const SizedBox(height: 130),
          ],
        ),
        Positioned(
          bottom: 50, // Adjust to ensure button and widget fit
          left: 16,
          right: 16,
          child: PrimaryButton(
            borderRadius: 32,
            buttonText: 'Doorgaan - €49,90/maand',
            onTap: () {
              context.pop();
            },
            buttonColor: HexColor.fromHex('#FF3E68'),
            height: 58,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
        ),
        const Positioned(
          bottom: 8, // Ensure the widget is at the bottom
          left: 0,
          right: 0,
          child: TermsAndConditionsWidget(),
        ),
      ],
    );
  }
}

class YearlyPlans extends StatefulWidget {
  const YearlyPlans({super.key});

  @override
  State<YearlyPlans> createState() => _YearlyPlansState();
}

class _YearlyPlansState extends State<YearlyPlans> {
  int selectedIndex = 2; // Default select "Scale" card

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 0),
              child: PlanCard(
                title: 'Starter',
                price: 'Gratis',
                description: 'Maak kennis met jobr',
                offers: '📍 1 vestiging  📄 1 vacature',
                isSelected: selectedIndex == 0,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 1),
              child: PlanCard(
                title: 'Local ⚡',
                price: '€19,90',
                description: 'Ideaal voor lokale zaken',
                offers:
                    '📍 1 vestiging\n📄 2 vacatures 🔍 AI matchmaking\n👀 Wie bekeek je profiel?',
                isSelected: selectedIndex == 1,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 2),
              child: PlanCard(
                title: 'Scale',
                price: '€89,90',
                description: 'Voor groeiende kmo’s',
                subdetails: 'Alles van Local',
                offers: '✔️ Vragenlijst   🙋‍♂️🙋‍♀️ Meerdere vestigingen',
                isSelected: selectedIndex == 2,
              ),
            ),
            const SizedBox(height: 130),
          ],
        ),
        Positioned(
          bottom: 50, // Adjust to ensure button and widget fit
          left: 16,
          right: 16,
          child: PrimaryButton(
            borderRadius: 32,
            buttonText: 'Doorgaan - €49,90/maand',
            onTap: () {
              context.pop();
            },
            buttonColor: HexColor.fromHex('#FF3E68'),
            height: 58,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
        ),
        const Positioned(
          bottom: 8, // Ensure the widget is at the bottom
          left: 0,
          right: 0,
          child: TermsAndConditionsWidget(),
        ),
      ],
    );
  }
}

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String offers;
  final Color backgroundColor;
  final bool isPopular;
  final String? subdetails;
  final bool isSelected; // New property

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    this.backgroundColor = Colors.white,
    this.isPopular = false,
    this.subdetails,
    required this.offers,
    this.isSelected = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isSelected ? const Color(0xFF0DFF3E68) : const Color(0xFFF3F3F3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Color(0xFFFF3E68).withAlpha((0.64 * 255).round())
              : const Color(0xFFF3F3F3),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isPopular) // Add "Populair" next to the title
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Populair',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFA100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 21,
                    color: (price == 'Gratis')
                        ? const Color(0xFF000000)
                            .withAlpha((0.32 * 255).round())
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                color: Color(0xFFADADAD),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            if (subdetails != null)
              Text(
                subdetails!,
                style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFAA5FE8),
                  height: 1.5,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              offers,
              style: const TextStyle(
                fontSize: 15.5,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
