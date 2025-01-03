import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../ui/theme/jobr_icons.dart';

class ChooseSectorScreen extends StatefulWidget {
  static const String location = 'choose-sector';
  const ChooseSectorScreen({super.key});

  @override
  State<ChooseSectorScreen> createState() => _ChooseSectorScreenState();
}

class _ChooseSectorScreenState extends State<ChooseSectorScreen> {
  List<Sector> sectors = [
    Sector(
      name: 'Horeca',
      image: 'assets/images/images/Food Bar.png',
    ),
    Sector(
      name: 'Winkel',
      image: 'assets/images/images/Shopping Basket.png',
    ),
    Sector(
      name: 'Event',
      image: 'assets/images/images/Star.png',
    ),
    Sector(
      name: 'Telecom',
      image: 'assets/images/images/Phone.png',
    ),
    Sector(
      name: 'Zorg',
      image: 'assets/images/images/Doctors Bag.png',
    ),
    Sector(
      name: 'Tech/ICT',
      image: 'assets/images/images/iMac.png',
    ),
    Sector(
      name: 'Bouw',
      image: 'assets/images/images/Brick Wall.png',
    ),
    Sector(
      name: 'Vastgoed',
      image: 'assets/images/images/Real Estate.png',
    ),
    Sector(
      name: 'Logistiek',
      image: 'assets/images/images/Trolley.png',
    ),
    Sector(
      name: 'Transport',
      image: 'assets/images/images/Car.png',
    ),
    Sector(
      name: 'Marketing',
      image: 'assets/images/images/Statistics.png',
    ),
    Sector(
      name: 'Toerisme',
      image: 'assets/images/images/Island On Water.png',
    ),
    Sector(
      name: 'Industrie',
      image: 'assets/images/images/Factory.png',
    ),
    Sector(
      name: 'Andere',
      image: 'assets/images/images/andere.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              JobrIcons.close,
              width: 30,
              height: 30,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Kies een sector",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: width,
        height: height * .9,
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
          runSpacing: 10,
          spacing: 8,
          // alignment: WrapAlignment.spaceBetween,
          children: List.generate(
            sectors.length,
            (index) => Container(
                width: 85.8,
                height: 85.8,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(12.92),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      sectors[index].image,
                      width: 41.35,
                      height: 41.35,
                      fit: BoxFit.contain,
                    ),
                    FittedBox(
                      child: Text(
                        sectors[index].name,
                        style: const TextStyle(
                          fontSize: 14.47,
                          fontFamily: 'Inter',
                          // height: 17.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Sector {
  final String name;
  final String image;

  Sector({required this.name, required this.image});
}
