import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final String description;
  final String label;

  const BottomSheetContent({
    Key? key,
    required this.description,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Center(
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 25,
                weight: 100,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(
                  "Learn More",
                  style: TextStyle(
                    color: Colors.pinkAccent.withOpacity(0.7),
                      fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Positioned(
                  bottom: -2, // Adjust this value for spacing
                  child: Container(
                    height: 4, // Thickness of the underline
                    width: 90, // Width of the underline matching the text
                    color: Colors.pinkAccent.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
