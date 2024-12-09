import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.h,
              floating: false,
              clipBehavior: Clip.none, // Avoid clipping
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  clipBehavior: Clip.none, // Allow overflow
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/images/image-4.png',
                        fit: BoxFit.cover,
                        height: 280.h,
                      ),
                    ),
                    Positioned(
                      bottom: 0.r, // Adjust based on desired overlap
                      left: 10,
                      child: Container(
                        width: 123.r,
                        height: 123.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 4
                                  .r), // Border to separate the profile picture
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/images/profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.r,
                      right: 10.r,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print('object');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        label: Text(
                          "Aanpassen",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Louis Ottevaere",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "louisottevaere@gmail.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red, size: 16),
                  SizedBox(width: 4),
                  Text("Kortrijk"),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Ik ben Louis, 30 jaar en super gemotiveerd om te doen waar ik het beste in ben: mensen de beste service geven.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat("36", "sollicitaties"),
                  _buildStat("12", "sessies"),
                  _buildStat("0", "verzoeken"),
                ],
              ),
              const SizedBox(height: 16),
              const DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      tabs: [
                        Tab(text: "Algemeen"),
                        Tab(text: "Media"),
                      ],
                    ),
                    SizedBox(
                      height: 300, // Placeholder height
                      child: TabBarView(
                        children: [
                          Center(child: Text("Algemeen Content")),
                          Center(child: Text("Media Content")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
