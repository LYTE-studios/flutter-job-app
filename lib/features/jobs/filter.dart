import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this import
import 'package:go_router/go_router.dart';
import 'package:jobr/features/jobs/widgets/custom_slider.dart';
import 'package:jobr/features/jobs/widgets/dropdown_menu.dart';
import 'package:jobr/ui/widgets/buttons/primary_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _sliderValue = 23;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Filters',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/icons/cross.svg',
            color: Colors.black,
            height: 15,
            width: 15,
          ),
          onPressed: () {
            Navigator.pop(context); // Pops the screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contract Type Dropdown
            const Text(
              'Contracttype',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const CustomDropdown(
                items: ["Option1", "`Option2"], hintText: 'Maak een keuze'),
            const SizedBox(height: 4),

            Divider(
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 4),
            // Function Dropdown
            const Text(
              'Functie',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const CustomDropdown(
                items: ["Option1", "`Option2"], hintText: 'Maak een keuze'),

            const SizedBox(height: 4),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(height: 4),
            //Si Sector Selection
            const Text(
              'Sector',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // Handle sector selection
              },
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[100]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/icons/add.svg',
                    color: Colors.black87,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(height: 4),
            // Required Experience Dropdown
            const Text(
              'Benodigde ervaring',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const CustomDropdown(
                items: ["Option1", "`Option2"], hintText: 'Maak een keuze'),

            const SizedBox(height: 4),
            // Distance Slider
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Afstand',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Image.asset('assets/images/jobs/map.png'),
                    Text(
                      '  ${_sliderValue.toInt()}km',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6.0,
                activeTrackColor: theme.primaryColor,
                inactiveTrackColor: Colors.grey[300],
                thumbColor: theme.primaryColor,
                // Inner circle color
                overlayColor: theme.primaryColor.withOpacity(0.2),
                thumbShape: CustomThumbShape(
                  // Use custom thumb shape
                  enabledThumbRadius: 12.0, // Adjust size
                  borderColor: Colors.white, // White border
                ),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 24.0),
              ),
              child: Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: '$_sliderValue km',
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
            ),
            const Spacer(),
            // Show Results Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  buttonText: 'Toon resultaten',
                  onTap: () {
                    context.push(
                      '/jobs/filters/jobupdates',
                    );
                  },
                  buttonColor: Colors.pinkAccent,
                  height: 55,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
