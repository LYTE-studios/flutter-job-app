import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobCardSollicitaties extends StatefulWidget {
  final String backgroundImagePath;
  final String location;
  final String jobType;
  final String salaryText;
  final String companyLogoPath;
  final String jobTitle;
  final String companyName;
  final String suggestionPercentage;
  final String suggestionIconPath;
  final bool? isJobTypeTextBlack; // Make optional
  final bool? isSalaryTextBlack; // Make optional

  const JobCardSollicitaties({
    super.key,
    required this.backgroundImagePath,
    required this.location,
    required this.jobType,
    required this.salaryText,
    required this.companyLogoPath,
    required this.jobTitle,
    required this.companyName,
    required this.suggestionPercentage,
    required this.suggestionIconPath,
    this.isJobTypeTextBlack, // Make optional
    this.isSalaryTextBlack, // Make optional
  });

  @override
  _JobCardSollicitatiesState createState() => _JobCardSollicitatiesState();
}

class _JobCardSollicitatiesState extends State<JobCardSollicitaties> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Background image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  widget.backgroundImagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Like button with circular background
              Positioned(
                top: 14,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      isLiked
                          ? 'assets/images/icons/like_icon-pink.svg'
                          : 'assets/images/icons/like_icon_grey.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location, job type, and salary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/location.svg',
                          width: 18,
                          height: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.location,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.jobType,
                          style: TextStyle(
                            color: widget.isJobTypeTextBlack == true
                                ? Colors.black
                                : Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            fontSize: 17,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.salaryText,
                      style: TextStyle(
                        color: widget.isSalaryTextBlack == true
                            ? Colors.black
                            : Colors.grey[500],
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Job title and company
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Company logo
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(widget.companyLogoPath),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.jobTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.5,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              widget.companyName,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Suggestion percentage
                    Container(
                      margin: const EdgeInsets.only(
                          top: 12), // Add top margin to move it lower
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.suggestionIconPath,
                            height: 17,
                            width: 17,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.suggestionPercentage,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
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
