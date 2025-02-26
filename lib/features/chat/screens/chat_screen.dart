import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/message.dart';
import 'package:jobr/data/services/chat_service.dart';
import 'package:jobr/features/chat/screens/employee/chat_page_employee_screen.dart';
import 'package:jobr/features/chat/screens/employer/chat_page_screen.dart';
import 'package:jobr/features/chat/screens/chat_request_screen.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/mixins/screen_state_mixin.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';

class ChatScreen extends StatefulWidget {
  static const String location = 'chat';
  final bool isEmployeeSide;
  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );
  const ChatScreen({super.key, this.isEmployeeSide = false});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ScreenStateMixin {
  String selectedCategory = 'Alle';

  List<Message> chatData = [];

  @override
  Future<void> loadData() async {
    chatData = await ChatService().getMessages();

    setState(() {
      chatData = chatData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: SafeArea(
            top: true,
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: PaddingSizes.medium,
                ),
                const Text(
                  'Chat',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildCategoryButton(
                          'Alle',
                          const Color(0xFFFFEEF1),
                          const Color(0xFFFF3E68).withOpacity(0.9),
                        ),
                        const SizedBox(width: 6),
                        _buildCategoryButton(
                          'Ongelezen',
                          const Color(0xFFF8F8F8),
                          const Color(0xFFA0A0A0),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.isEmployeeSide) {
                          context.push(ChatRequestScreen.employeeRoute);
                        } else {
                          context.push(ChatRequestScreen.employerRoute);
                        }
                      },
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
                  color: Color(0x0F000000),
                  height: 20,
                  thickness: 1.5,
                  indent: 74,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (widget.isEmployeeSide) {
                      context.push(ChatPageEmployeeScreen.employeeRoute);
                    } else {
                      context.push(ChatPageScreen.employerRoute);
                    }
                  },
                  child: ListView.builder(
                    itemCount: chatData.length,
                    itemBuilder: (context, index) {
                      final chat = chatData[index];
                      return Column(
                        children: [
                          _buildChatItem(chat),
                          const Divider(
                            color: Color(0x0F000000),
                            height: 20,
                            thickness: 1.5,
                            indent: 74,
                          ),
                        ],
                      );
                    },
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build chat items
  Widget _buildChatItem(Message chat) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Picture
        Container(
          width: 67,
          height: 67,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(chat.sender),
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
                // chat['name'],
                '',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                // chat['message'],
                '',
                style: TextStyle(
                  color: HexColor.fromHex('8F8F8F'),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
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
              // chat['time'],
              '',
              style: TextStyle(
                // color: chat['unreadCount'] > 0
                //     ? const Color(0xFFFF3E68)
                //     : const Color(0xFF8F8F8F),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            // if (chat['unreadCount'] > 0)
            //   CircleAvatar(
            //     radius: 10,
            //     backgroundColor: const Color(0xFFFF3E68),
            //     child: Text(
            //       '${chat['unreadCount']}',
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 12,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ],
    );
  }

  // Helper method to build category buttons
  Widget _buildCategoryButton(
      String text, Color defaultBgColor, Color defaultTextColor) {
    final bool isSelected = selectedCategory == text;
    final bool isOngelenzenSelected = selectedCategory == 'Ongelezen';

    // Define colors based on selection state
    Color bgColor;
    Color textColor;

    if (text == 'Alle') {
      if (isOngelenzenSelected) {
        bgColor = const Color(0xFFF8F8F8).withOpacity(0.4);
        textColor = const Color(0xFFA0A0A0);
      } else {
        bgColor = const Color(0xFFFFEEF1).withOpacity(0.4);
        textColor = const Color(0xFFFF3E68).withOpacity(0.9);
      }
    } else {
      // For 'Ongelezen' button
      if (isSelected) {
        bgColor = const Color(0xFFFFEEF1).withOpacity(0.4);
        textColor = const Color(0xFFFF3E68).withOpacity(0.9);
      } else {
        bgColor = const Color(0xFFF8F8F8).withOpacity(0.4);
        textColor = const Color(0xFFA0A0A0);
      }
    }

    return SizedBox(
      height: 35,
      width: text == 'Alle' ? 52 : 104,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (selectedCategory != text) {
              selectedCategory = text;
            }
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
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
