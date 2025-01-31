import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobr/configuration.dart';
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
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Kies je plan',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Icon(Icons.close, color: Colors.black, size: 25),
            ),
            onPressed: () {},
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            onTap: _onTabTapped,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
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

class MonthlyPlans extends StatelessWidget {
  const MonthlyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            PlanCard(
              title: 'Starter',
              price: 'Gratis',
              description: 'Maak kennis met jobr',
              offers: ' 📍 1 vestiging   📄 1 vacature',
            ),
            PlanCard(
              title: 'Local ⚡',
              price: '€59,90',
              description: 'Ideaal voor lokale zaken',
              offers:
                  ' 📍 1 vestiging   📄 2 vacatures\n 🔍 AI matchmaking   ✔️ Custom vragenlijst',
              isPopular: true,
            ),
            PlanCard(
              title: 'Scale',
              price: '€69,90',
              description: 'Voor groeiende kmo’s',
              offers:
                  ' ∞ Onbeperkte kandidaten \n 🔍 AI matchmaking   ✔️ Custom vragenlijst   \n👀 Wie bekeek mijn vacature?',
              backgroundColor: Color.fromARGB(255, 255, 249, 251),
            ),
            SizedBox(height: 20),
          ],
        ),
        Positioned(
          bottom: 50, // Adjust to ensure button and widget fit
          left: 16,
          right: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {},
            child: const Text(
              'Doorgaan - €49,90/maand',
              style: TextStyle(color: Colors.white, fontSize: 20),
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

class YearlyPlans extends StatelessWidget {
  const YearlyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            PlanCard(
              title: 'Starter',
              price: 'Gratis',
              description: 'Maak kennis met jobr',
              offers: '📍 1 vestiging  📄 1 vacature',
            ),
            PlanCard(
              title: 'Local ⚡',
              price: '€19,90',
              description: 'Ideaal voor lokale zaken',
              offers:
                  '📍 1 vestiging\n📄 2 vacatures 🔍 AI matchmaking\n👀 Wie bekeek je profiel?',
              isPopular: true,
            ),
            PlanCard(
              title: 'Scale',
              price: '€89,90',
              description: 'Voor groeiende kmo’s',
              offers:
                  '📍 Meerdere vestigingen   📄 5 vacatures\n🔍 AI matchmaking  👀 Wie bekeek je profiel? \n ✔️ Vragenlijst',
              backgroundColor: Color.fromARGB(255, 255, 249, 251),
            ),
            SizedBox(height: 20),
          ],
        ),
        Positioned(
          bottom: 50, // Adjust to ensure button and widget fit
          left: 16,
          right: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {},
            child: const Text('Doorgaan - €478,80/jaar',
                style: TextStyle(color: Colors.white, fontSize: 20)),
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

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    this.backgroundColor = Colors.white,
    this.isPopular = false,
    required this.offers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: (title == 'Scale')
              ? Theme.of(context).primaryColor.withOpacity(.3)
              : Colors.black12, // Conditional border color
          width: (title == 'Scale') ? 2 : 0.5, // Border width
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
                          fontSize: 24,
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
                              color: Colors.orange,
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
                    fontSize: 22,
                    color: (price == 'Gratis')
                        ? Colors.grey
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              offers,
              style: const TextStyle(
                fontSize: 16,
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
