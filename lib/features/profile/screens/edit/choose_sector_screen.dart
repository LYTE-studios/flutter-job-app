import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/jobs/jobdetail_screen.dart';
import 'package:jobr/features/profile/screens/profile_screen.dart';

import '../../../../ui/theme/jobr_icons.dart';

class ChooseSectorScreen extends StatefulWidget {
  static const String location = 'choose-sector';
  static String route = JobrRouter.getRoute(
    '${ProfileScreen.location}/$location',
    JobrRouter.employeeInitialroute,
  );

  final bool isSectorRedirector;
  const ChooseSectorScreen({super.key, this.isSectorRedirector = false});

  @override
  State<ChooseSectorScreen> createState() => _ChooseSectorScreenState();
}

class _ChooseSectorScreenState extends State<ChooseSectorScreen> {
  List<Sector> sectors = [
    Sector(
      name: 'Horeca',
      image: 'assets/images/images/Food Bar.png',
      tagCategory: 'students',
    ),
    Sector(
      name: 'Winkel',
      image: 'assets/images/images/Shopping Basket.png',
      tagCategory: 'freelancers',
    ),
    Sector(
      name: 'Event',
      image: 'assets/images/images/Star.png',
      tagCategory: 'interns',
    ),
    Sector(
      name: 'Telecom',
      image: 'assets/images/images/Phone.png',
      tagCategory: 'students',
    ),
    Sector(
      name: 'Zorg',
      image: 'assets/images/images/Doctors Bag.png',
      tagCategory: 'freelancers',
    ),
    Sector(
      name: 'Tech/ICT',
      image: 'assets/images/images/iMac.png',
      tagCategory: 'interns',
    ),
    Sector(
      name: 'Bouw',
      image: 'assets/images/images/Brick Wall.png',
      tagCategory: 'interns',
    ),
    Sector(
      name: 'Vastgoed',
      image: 'assets/images/images/Real Estate.png',
      tagCategory: 'freelancers',
    ),
    Sector(
      name: 'Logistiek',
      image: 'assets/images/images/Trolley.png',
      tagCategory: 'students',
    ),
    Sector(
      name: 'Transport',
      image: 'assets/images/images/Car.png',
      tagCategory: 'interns',
    ),
    Sector(
      name: 'Marketing',
      image: 'assets/images/images/Statistics.png',
      tagCategory: 'students',
    ),
    Sector(
      name: 'Toerisme',
      image: 'assets/images/images/Island On Water.png',
      tagCategory: 'freelancers',
    ),
    Sector(
      name: 'Industrie',
      image: 'assets/images/images/Factory.png',
      tagCategory: 'interns',
    ),
    Sector(
      name: 'Andere',
      image: 'assets/images/images/andere.png',
      tagCategory: 'students',
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
              width: 15,
              height: 15,
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
        child: GridView.builder(
          itemCount: sectors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 6,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (widget.isSectorRedirector) {
                  context.push(
                    JobDetailScreen.employeeRoute,
                    extra: {
                      'category':
                          sectors[index].tagCategory, // fixed index access
                      'title': sectors[index].name, // fixed index access
                      'image': sectors[index].image, // fixed index access
                    },
                  );
                  return;
                }
                Navigator.pop(context, sectors[index]);
              },
              child: Container(
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
                      width: sectors[index].name == 'Andere' ? 25 : 35.35,
                      height: sectors[index].name == 'Andere' ? 30 : 35.35,
                      fit: BoxFit.contain,
                    ),
                    FittedBox(
                      child: Text(
                        sectors[index].name,
                        style: const TextStyle(
                          fontSize: 14.47,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Sector {
  final String name;
  final String image;
  final String tagCategory;

  Sector({required this.name, required this.image, required this.tagCategory});
}
