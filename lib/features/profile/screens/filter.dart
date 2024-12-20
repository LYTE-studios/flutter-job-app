import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/jobs/widgets/custom_slider.dart';
import 'package:jobr/ui/buttons/primary_button.dart';

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
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Maak een keuze',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 20), // Center vertically
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Slightly curved border
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
              items: const [
                DropdownMenuItem(value: '1', child: Text('Option 1')),
                DropdownMenuItem(value: '2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
            ),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Maak een keuze',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 20), // Center vertically
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Slightly curved border
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
              items: const [
                DropdownMenuItem(value: '1', child: Text('Option 1')),
                DropdownMenuItem(value: '2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
            ),
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
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border.all(color: Colors.grey[100]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.grey, size: 40),
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Maak een keuze',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 20), // Center vertically
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Slightly curved border
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
              items: const [
                DropdownMenuItem(value: '1', child: Text('Option 1')),
                DropdownMenuItem(value: '2', child: Text('Option 2')),
              ],
              onChanged: (value) {},
            ),
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
                    Text('  $_sliderValue km'),
                  ],
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6.0,
                activeTrackColor: theme.primaryColor,
                inactiveTrackColor: Colors.grey[300],
                thumbColor: theme.primaryColor, // Inner circle color
                overlayColor: theme.primaryColor.withOpacity(0.2),
                thumbShape: CustomThumbShape(
                  // Use custom thumb shape
                  enabledThumbRadius: 12.0, // Adjust size
                  borderColor: Colors.white, // White border
                ),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
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
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                buttonText: 'Toon resultaten',
                onTap: () {
                    context.push(
                      '/jobs/filters/jobupdates',
                    );
                  },
                buttonColor: Colors.pink.withOpacity(0.9),
                height: 50,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
