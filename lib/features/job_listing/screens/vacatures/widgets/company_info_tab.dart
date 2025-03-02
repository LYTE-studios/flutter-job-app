import 'package:flutter/material.dart';

class CompanyInfoTab extends StatelessWidget {
  const CompanyInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Requirements
          const Text(
            "Een uniform is vereist voor deze job",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Een witte Brooklyn tshirt, zwarte schoenen",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Een diploma is vereist voor deze job",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Minimaal bachelor in",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Je haalt energie uit",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          // Bullet points
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              Expanded(
                child: Text(
                  "Adviseren van business in het nemen van beslissingen voor de implementatie van nieuwe tools, in lijn met de strategische planning;",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "• ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              Expanded(
                child: Text(
                  "Awareness creëren voor continue verbeteren van processen en tools;",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Read more link
          Text(
            "Meer lezen",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.pinkAccent,
            ),
          ),
          const SizedBox(height: 16),
          // Map Section
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/images/Frame-m.png',
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Main location marker (red)
              ],
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
