import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeProfileTab extends StatelessWidget {
  const EmployeeProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Match Percentage Card
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Card(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Match met jouw vacature",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              height: 20,
                              width: 20,
                              "assets/images/recruteren/jobrAI_suggesties.png",
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "90%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1.32,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          height: 20,
                          width: 20,
                          "assets/images/icons/tick.svg",
                          color: Color(0xFF35BD76),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        const Text(
                          "Alle hard skills matchen",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F6ED),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            'Koken',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFFE5F6ED),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            'Klantvriendelijk',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              height: 20,
                              width: 20,
                              "assets/images/icons/recent_icon.svg",
                              color: Colors.grey[500],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            const Text(
                              "Relevante werkervaring",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.32,
                          color: Colors.grey[200],
                        ),
                        Row(
                          children: [
                            Text(
                              '💎 Expert',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF4898DF)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              height: 20,
                              width: 20,
                              "assets/images/logos/info.svg",
                              color: Colors.grey[500],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/images/choclo.png',
                              width: 60, // Adjusted width
                              height: 60, // Adjusted height
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: const Text(
                            "District manager",
                            style: TextStyle(
                              fontSize: 15.9, // Matches the design size
                              fontWeight: FontWeight
                                  .bold, // Matches the bold font in the image
                            ),
                          ),
                          subtitle: const Text(
                            "Choclo Kortrijk\nNov 2023 - Nov 2024 • 1 jr",
                            style: TextStyle(
                              fontSize:
                                  14, // Matches the smaller font in the design
                              color: Colors
                                  .black54, // Matches the subtle gray color in the design
                              height: 1.5, // Line height for better readability
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 8), // Space between the two ListTiles
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/images/placeholder-3.png',
                              width: 60, // Adjusted width
                              height: 60, // Adjusted height
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: const Text(
                            "Head of restaurant",
                            style: TextStyle(
                              fontSize: 15.9, // Matches the design size
                              fontWeight: FontWeight
                                  .bold, // Matches the bold font in the image
                            ),
                          ),
                          subtitle: const Text(
                            "Spicy Lemon Kortrijk\nNov 2020 - Jul 2023 • 2 jr 8 mnd",
                            style: TextStyle(
                              fontSize:
                                  14.1, // Matches the smaller font in the design
                              color: Colors
                                  .black54, // Matches the subtle gray color in the design
                              height: 1.5, // Line height for better readability
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
          // Availability Card
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Card(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Beschikbaarheid",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var day in ['M', 'D', 'W', 'D', 'V', 'Z', 'Z'])
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: day == 'V' || day == 'Z'
                                  ? Colors.red.shade100.withOpacity(0.5)
                                  : Colors.grey.shade200,
                              child: Text(
                                day,
                                style: TextStyle(
                                  color: day == 'V' || day == 'Z'
                                      ? Colors.red
                                      : Colors.grey,
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          VragenlijstCard(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class VragenlijstCard extends StatefulWidget {
  const VragenlijstCard({super.key});

  @override
  State<VragenlijstCard> createState() => _VragenlijstCardState();
}

class _VragenlijstCardState extends State<VragenlijstCard> {
  final Map<String, String> selectedAnswers = {
    'question1': 'Ja',
    'question2': 'Nee',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Vragenlijst",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Divider(
                thickness: 1.32,
                color: Colors.grey[200],
              ),
              _buildQuestion(
                question: "Kan je een plateau dragen met 1 hand?",
                questionId: 'question1',
              ),
              const SizedBox(height: 16),
              _buildQuestion(
                question:
                    "Vind je het fijn om af te kunnen wisselen tussen bar en de zaal?",
                questionId: 'question2',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(
      {required String question, required String questionId}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var answer in ['Ja', 'Nee'])
                Container(
                  // Replaced GestureDetector with Container
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: selectedAnswers[questionId] == answer
                        ? Colors.pinkAccent
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: selectedAnswers[questionId] == answer
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
