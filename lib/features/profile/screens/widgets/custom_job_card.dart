import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/ui/theme/jobr_icons.dart';
import 'package:jobr/ui/theme/text_styles.dart';
import 'package:jobr/ui/widgets/buttons/action_button.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:readmore/readmore.dart';

class CustomJobCard extends StatefulWidget {
  final double height;

  final User user;

  final double suggestionPercentage;
  final bool isAICard;
  final bool showLikeButton;

  final VoidCallback onButtonPressed;

  const CustomJobCard({
    super.key,
    required this.user,
    this.height = 272,
    required this.suggestionPercentage,
    required this.onButtonPressed,
    this.isAICard = false,
    this.showLikeButton = false,
  });

  @override
  State<CustomJobCard> createState() => _CustomJobCardState();
}

class _CustomJobCardState extends State<CustomJobCard> {
  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(EmployProfileDisplayScreen.employerRoute);
      },
      child: Container(
        height: widget.height,
        constraints: const BoxConstraints(minHeight: 250),
        decoration: BoxDecoration(
          color: HexColor.fromHex('#F6F6F6'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildDescription(context),
                  ),
                  _buildActionRow(context),
                ],
              ),
            ),
            if (widget.showLikeButton)
              Positioned(
                top: 10,
                right: 16,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      icon: Icon(
                        Icons.favorite,
                        color: isLiked
                            ? HexColor.fromHex('#FF3E68')
                            : Colors.grey.shade300,
                        size: 26,
                      ),
                      onPressed: toggleLike,
                    ),
                  ),
                ),
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
                widget.user.username,
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
                  _buildAgeInfo(),
                ],
              ),
              const SizedBox(height: 4),
              if (widget.user.rating != null)
                StarRating(
                  rating: widget.user.rating ?? 0,
                )
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
          image: AssetImage(widget.user.profilePicturePath ?? ''),
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
          widget.user.employeeProfile?.cityName ?? '',
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

  Widget _buildAgeInfo() {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: HexColor.fromHex('#D9D9D9'),
          size: 8,
        ),
        const SizedBox(width: 4),
        Text(
          "${widget.user.employeeProfile?.age ?? 0} jaar",
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
    return ReadMoreText(
      widget.user.employeeProfile?.biography ?? '',
      trimLines: 3,
      style: TextStyles.bodyMedium.copyWith(
        fontSize: 16,
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
    );
  }

  Widget _buildActionRow(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ActionButton(
            onButtonPressed: widget.onButtonPressed,
            buttonText: 'Chat starten',
            icon: JobrIcons.send,
            backgroundColor: HexColor.fromHex('#3976FF'),
          ),
        ),
        const SizedBox(width: 10),
        _buildSuggestionPercentage(theme),
      ],
    );
  }

  Widget _buildSuggestionPercentage(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/recruteren/jobrAI_suggesties.png",
            height: 18,
          ),
          const SizedBox(width: 4),
          FittedBox(
            child: Text(
              " ${widget.suggestionPercentage}%",
              style: TextStyle(
                fontFamily: 'Inter',
                color: theme.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int totalStars;
  final double size;

  const StarRating({
    Key? key,
    required this.rating,
    this.totalStars = 5,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: -4,
          children: List.generate(totalStars, (index) {
            if (rating >= index + 1) {
              return Icon(Icons.star_rounded,
                  size: size, color: const Color(0xFFFFD400));
            } else if (rating > index) {
              final double fraction = rating - index;
              return Stack(
                children: [
                  Icon(Icons.star_rounded,
                      size: size, color: const Color(0xFFD9D9D9)),
                  ClipRect(
                    clipper: _StarClipper(fraction),
                    child: Icon(Icons.star_rounded,
                        size: size, color: const Color(0xFFFFD400)),
                  ),
                ],
              );
            } else {
              return Icon(Icons.star_rounded,
                  size: size, color: const Color(0xFFD9D9D9));
            }
          }),
        ),
      ],
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fraction;
  _StarClipper(this.fraction);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
