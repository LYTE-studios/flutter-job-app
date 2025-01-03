import 'package:flutter/material.dart';
import 'package:jobr/features/vacatures/widgets/vacature_card.dart';

class VacatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Remove AppBar height
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Mijn vacatures',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Bekijk al je vacatures en chat met sollicitanten',
                style: TextStyle(
                  fontSize: 15.5,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              VacatureCard(),
            ],
          ),
        ),
      ),
    );
  }
}
