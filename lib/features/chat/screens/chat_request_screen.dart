import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/features/chat/screens/chat_request_page_screen.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';


class ChatRequestScreen extends StatefulWidget {
  const ChatRequestScreen({super.key});

  static const String location = 'chat-request';

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );

  @override
  State<ChatRequestScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatRequestScreen> {
  final List<Map<String, dynamic>> chatData = [
    {
      'name': 'Djimon Dilvoye',
      'message': 'Hey! Ik zag op jullie website dat...',
      'time': '07:23',
      'image': 'assets/images/logos/image 15.png',
      'unreadCount': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            ClearInkWell(
              onTap: () {
                context.pop();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingSizes.large,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 21,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Berichtverzoeken',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Text(
                'Hier vind je werkzoekenden die zelf contact opnemen. Dit kan een vraag zijn of een spontane sollicitatie.',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
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
                  context.push(ChatRequestPageScreen.employerRoute);
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
    );
  }

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
                color: chat['unreadCount'] > 0
                    ? const Color(0xFFFF3E68)
                    : const Color(0xFF8F8F8F),
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (chat['unreadCount'] > 0)
              CircleAvatar(
                radius: 10,
                backgroundColor: const Color(0xFFFF3E68),
                child: Text(
                  '${chat['unreadCount']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class Message {
  final String content;
  final bool isSentByMe;

  Message({required this.content, required this.isSentByMe});
}
