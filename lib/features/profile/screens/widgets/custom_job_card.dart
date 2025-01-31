import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/features/profile/screens/employee_profile_screen_display.dart';
import 'package:jobr/ui/widgets/buttons/action_button.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:readmore/readmore.dart';

class CustomJobCard extends StatefulWidget {
  final String description;
  final String userName;
  final String location;
  final String age;
  final String profileImagePath;
  final String buttonText;
  final String buttonIcon;
  final Color buttonColor;
  final String suggestionPercentage;
  final VoidCallback onButtonPressed;
  final bool showBottomText;
  final int descriptionPadding;
  final bool isAICard;
  final bool showLikeButton;

  const CustomJobCard({
    super.key,
    required this.description,
    required this.userName,
    required this.location,
    required this.age,
    required this.profileImagePath,
    required this.buttonText,
    required this.buttonIcon,
    required this.buttonColor,
    required this.suggestionPercentage,
    required this.onButtonPressed,
    required this.showBottomText,
    this.descriptionPadding = 0,
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
    return Stack(
      children: [
        Container(
          width: widget.isAICard
              ? MediaQuery.of(context).size.width * 0.87
              : MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: HexColor.fromHex('#F6F6F6'),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(context),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.descriptionPadding.toDouble(),
                  ),
                  child: _buildDescription(context),
                ),
                const SizedBox(height: 10),
                _buildActionRow(context),
                if (widget.showBottomText) _buildBottomRow(context),
              ],
            ),
          ),
        ),
        // Like button in the top-left corner
        if (widget.showLikeButton)
          Positioned(
            top: 10,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.pink : Colors.grey.shade400,
                  size: 26,
                ),
                onPressed: toggleLike,
              ),
            ),
          ),
      ],
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
                  _buildAgeInfo(),
                ],
              ),
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
            fontFamily: 'Poppins',
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
          "${widget.age} jaar",
          style: TextStyle(
            fontFamily: 'Poppins',
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
      widget.description,
      trimLines: 3,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: HexColor.fromHex('#4A4C53'),
        fontSize: 17,
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
            buttonText: widget.buttonText,
            icon: widget.buttonIcon,
            backgroundColor: widget.buttonColor,
          ),
        ),
        const SizedBox(width: 10),
        _buildSuggestionPercentage(theme),
      ],
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: HexColor.fromHex('#000000').withOpacity(0.1),
        ),
        ClearInkWell(
          onTap: () {
            context.push(EmployProfileDisplayScreen.employerRoute);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Profiel bekijken',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor.fromHex('#4A4C53'),
                  fontSize: 16,
                  letterSpacing: -0.352,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: HexColor.fromHex('#4A4C53'),
              ),
            ],
          ),
        ),
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
