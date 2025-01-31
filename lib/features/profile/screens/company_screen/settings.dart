import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';

class SettingsScreen extends StatelessWidget {
  static const location = 'settings';

  static const String route = '/$location';

  const SettingsScreen({super.key});

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
                    // Handle navigation to Privacybeleid
                  },
                ),
                buildListTile(
                  title: 'Algemene voorwaarden',
                  onTap: () {
                    // Handle navigation to Algemene voorwaarden
                  },
                ),
                buildListTile(
                  title: 'Betalingen herstellen',
                  onTap: () {
                    // Handle navigation to Betalingen herstellen
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              PrimaryButton(
                width: MediaQuery.of(context).size.width * 0.8,
                textColor: Colors.grey,
                buttonColor: Color(0xFFF7F7F7),
                height: 50,
                onTap: () {
                  // Handle "Uitloggen" action
                },
                buttonText: 'Uitloggen',
              ),
              SizedBox(height: 8),
              PrimaryButton(
                width: MediaQuery.of(context).size.width * 0.8,
                textColor: Colors.red,
                buttonColor:
                    Color(0xFFFEF4F4), // Colors.red.shade100.withOpacity(0.3),
                height: 50,
                onTap: () {
                  // Handle "Uitloggen" action
                },
                buttonText: 'Account verwijderen',
              ),
              SizedBox(height: 24),
              Text(
                'Version 0.0.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 24),
            ],
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
