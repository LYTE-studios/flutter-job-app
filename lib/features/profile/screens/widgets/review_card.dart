import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/ui/widgets/buttons/action_button.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatefulWidget {
  final String description;
  final String role;
  final String timePeriod;
  final String userName;
  final String location;
  final String category;
  final String profileImagePath;
  final VoidCallback? onIconTap;

  final int descriptionPadding;

  final double? rating;

  const ReviewCard({
    super.key,
    required this.description,
    required this.userName,
    required this.location,
    required this.category,
    required this.profileImagePath,
    this.descriptionPadding = 0,
    this.rating,
    required this.role,
    required this.timePeriod,
    this.onIconTap,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Removed fixed height to allow dynamic sizing based on content.
      decoration: BoxDecoration(
        color: HexColor.fromHex('#F6F6F6'),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildProfileHeader(context),
            if (widget.rating != null)
              Column(
                children: [
                  const SizedBox(height: 10),
                  CustomStarRating(
                    onIconTap: widget.onIconTap,
                    rating: widget.rating!,
                    containerBackgroundColor: HexColor.fromHex('#F0F0F0'),
                    borderColor: HexColor.fromHex('#EDEDED'),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            // Removed Expanded to avoid unbounded height error.
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.descriptionPadding.toDouble(),
              ),
              child: _buildDescription(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileImage(),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildLocationInfo(),
                  const SizedBox(width: 8),
                  _buildCategoryInfo(),
                ],
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        image: DecorationImage(
          image: AssetImage(widget.profileImagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Image.asset(
          "assets/images/recruteren/location.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 4),
        Text(
          widget.location,
          style: TextStyle(
            color: HexColor.fromHex('#666666'),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.0001,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCategoryInfo() {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: HexColor.fromHex('#D9D9D9'),
          size: 8,
        ),
        const SizedBox(width: 4),
        Text(
          "${widget.category}",
          style: TextStyle(
            color: HexColor.fromHex('#666666'),
            fontSize: 15,
            letterSpacing: 0.0001,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Modified row to avoid overflow:
        Row(
          children: [
            Expanded(
              child: Text(
                widget.role,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: HexColor.fromHex('#403E3E'),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.timePeriod,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: HexColor.fromHex('#A1A0A0'),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        if (widget.description.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(
                  color: HexColor.fromHex('#000000').withOpacity(0.05),
                ),
              ),
              ReadMoreText(
                widget.description,
                trimLines: 3,
                style: TextStyle(
                  color: HexColor.fromHex('#4A4C53').withOpacity(0.66),
                  fontSize: 14,
                  letterSpacing: 0.0001,
                  fontWeight: FontWeight.w500,
                ),
                trimMode: TrimMode.Line,
                trimCollapsedText: '\nLeer meer',
                trimExpandedText: ' Toon minder',
                lessStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: theme.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                moreStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: theme.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        SizedBox(height: 14),
      ],
    );
  }
}
