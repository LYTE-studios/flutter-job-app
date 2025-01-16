import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/ui/buttons/primary_button.dart';

class VacatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0, // Set elevation to 0 to remove shadow
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/images/images/kortrijk.png',
              // Replace with your image URL
              fit: BoxFit.cover,
              height: 130,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/images/icons/location.svg',
                          color: Colors.pinkAccent,
                          height: 17,
                          width: 17,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Kortrijk",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " •",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " 0,60km",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "€15/uur",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Job Title and Subtitle
                Row(
                  children: [
                    // Logo
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: Image.asset(
                          'assets/images/logos/brooklyn_kortrijk.png'),
                    ),
                    SizedBox(width: 12),
                    // Title and Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kassa medewerker",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "Brooklyn Kortrijk",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      suffixIcon: SvgPicture.asset(
                        'assets/images/icons/edit.svg',
                        color: Colors.grey,
                        height: 20,
                        width: 20,
                      ),
                      width: 200,
                      buttonText: '  Aanpassen',
                      onTap: () {},
                      borderRadius: 32,
                      height: 40,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 16.5),
                      textColor: Colors.grey,
                      buttonColor: Colors.grey.shade200,
                    ),
                    PrimaryButton(
                      buttonText: ' 16 ',
                      onTap: () {},
                      height: 39,
                      width: 80,
                      suffixIcon: Icon(Icons.people),
                      textColor: Colors.white,
                      buttonColor: Colors.pink.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
