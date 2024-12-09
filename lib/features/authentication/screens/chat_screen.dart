import 'package:flutter/material.dart';
import 'package:flutter_exam/core/routing/mixins/screen_state_mixin.dart';
import 'package:flutter_exam/features/authentication/screens/chat_request.dart';
import 'package:flutter_exam/features/authentication/screens/email_register_screen.dart';
import 'package:flutter_exam/features/authentication/widgets/privacy_policy_block.dart';
import 'package:flutter_exam/ui/buttons/jobr_icon_button.dart';
import 'package:flutter_exam/ui/theme/jobr_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Sample chat data
  final List<Map<String, dynamic>> chatData = [
    {
      'name': 'Spicy Lemon',
      'message': 'Top, tot dan!',
      'time': '09:46',
      'image': 'assets/images/logos/spicy_lemon.png',
      'unreadCount': 0,
    },
    {
      'name': 'Brooklyn Kortrijk',
      'message': 'Ik: Plannen we anders..',
      'time': '07:23',
      'image': 'assets/images/logos/brooklyn_kortrijk.png',
      'unreadCount': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Padding(padding: EdgeInsets.only(left:6),child: Text(
          'Chat',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            fontFamily: 'Eloquia',
          ),
        )),
        centerTitle: false, // Ensures the title is aligned to the left
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0), // Add padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildCategoryButton('Alle', const Color(0xFFFFEEF1), const Color(0xFFFF3E68).withOpacity(0.9),),
                      const SizedBox(width: 6),
                      _buildCategoryButton('Ongelezen', const Color(0xFFF8F8F8), const Color(0xFFA0A0A0)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '3 verzoeken',
                      style: TextStyle(
                        color: Color(0xFFFF3E68),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
               const Divider(
                color:   Color(0x0F000000),
                height: 20,
                thickness: 1.5,
                indent: 74,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatRequest(),
                    ),
                  );},
                  child: ListView.builder(
                    itemCount: chatData.length,
                    itemBuilder: (context, index) {
                      final chat = chatData[index];
                      return Column(
                        children: [
                          _buildChatItem(chat),
                          const Divider(
                            color:   Color(0x0F000000),
                            height: 20,
                            thickness: 1.5,
                            indent: 74,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build chat items
  Widget _buildChatItem(Map<String, dynamic> chat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Picture
        Container(
          width: 67,
          height: 67,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(chat['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Chat Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat['name'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                chat['message'],
                style: const TextStyle(
                  color: Color(0xFF8F8F8F),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Time and Unread Count
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time'],
              style: TextStyle(
                color: chat['unreadCount'] > 0 ?const Color(0xFFFF3E68) : const Color(0xFF8F8F8F),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (chat['unreadCount'] > 0)
              CircleAvatar(
                radius: 10,
                backgroundColor:const Color(0xFFFF3E68),
                child: Text(
                  '${chat['unreadCount']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Eloquia',
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Helper method to build category buttons
  Widget _buildCategoryButton(String text, Color bgColor, Color textColor) {
    return SizedBox(
      height: 35,
      width: text == 'Alle' ? 52 : 104, // Adjust width for 'Alle' and 'Ongelezen'
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: bgColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
