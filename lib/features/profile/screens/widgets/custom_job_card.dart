import 'package:flutter/material.dart';
import 'package:jobr/ui/widget/common_button.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:readmore/readmore.dart';

class CustomJobCard extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
            _buildDescription(context),
            const SizedBox(height: 10),
            _buildActionRow(context),
            if (showBottomText == true) _buildBottomRow(context)
          ],
        ),
      ),
    );
  }

  Row _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        _buildProfileImage(),
        const SizedBox(width: 10),
        _buildUserInfo(theme),
      ],
    );
  }

  Container _buildProfileImage() {
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        image: DecorationImage(
          image: AssetImage(profileImagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Column _buildUserInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        Row(
          children: [
            _buildLocationInfo(),
            const SizedBox(width: 8),
            _buildAgeInfo(),
          ],
        ),
      ],
    );
  }

  Row _buildLocationInfo() {
    return Row(
      children: [
        Image.asset(
          height: 20,
          width: 20,
          "assets/images/recruteren/location.png",
        ),
        const SizedBox(width: 4),
        Text(
          location,
          style: TextStyle(
            fontFamily: 'Inter',
            color: HexColor.fromHex('#666666'),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Row _buildAgeInfo() {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: HexColor.fromHex('#D9D9D9'),
          size: 8,
        ),
        const SizedBox(width: 4),
        Text(
          "$age jaar",
          style: TextStyle(
            fontFamily: 'Inter',
            color: HexColor.fromHex('#666666'),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  ReadMoreText _buildDescription(BuildContext context) {
    final theme = Theme.of(context);
    return ReadMoreText(
      description,
      trimLines: 3,
      style: TextStyle(
        fontFamily: 'Inter',
        color: HexColor.fromHex('#4A4C53'),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      trimMode: TrimMode.Line,
      trimCollapsedText: '\nleer meer',
      trimExpandedText: '...Toon minder',
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

  Row _buildActionRow(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CommonButton(
            onButtonPressed: onButtonPressed,
            buttonText: buttonText,
            icon: buttonIcon,
            backgroundColor: buttonColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: _buildSuggestionPercentage(theme),
        ),
      ],
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: HexColor.fromHex('#000000').withOpacity(0.1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profiel bekijken',
              style: TextStyle(
                fontFamily: 'Inter',
                color: HexColor.fromHex('#4A4C53'),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: HexColor.fromHex('#4A4C53'),
            )
          ],
        ),
      ],
    );
  }

  Container _buildSuggestionPercentage(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            height: 18,
            "assets/images/recruteren/jobrAI_suggesties.png",
          ),
          FittedBox(
            child: Text(
              "$suggestionPercentage%",
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
