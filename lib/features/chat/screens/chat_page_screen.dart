import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  static const String location = 'chat-page';

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  final List<Message> messages = [
    Message(content: "Hey Louis,", isSentByMe: true),
    Message(
        content: "Kan je morgen langskomen voor een sollicitatiegesprek?",
        isSentByMe: true),
    Message(
        content:
            "Kan ik morgen eventueel langs... Hey! Ja hoor, ik kan rond 15u?",
        isSentByMe: false),
    Message(content: "Perfect, kom dan maar af!", isSentByMe: true),
    Message(content: "Thanks, tot morgen!", isSentByMe: false),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, size: 21),
            ),
            Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/logos/spicy_lemon.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Louis Ottevaere',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const SvgIcon("assets/images/icons/phone.svg",
                color: Colors.pinkAccent, size: 20),
            const SizedBox(width: 8),
            const SvgIcon("assets/images/logos/info.svg", size: 24),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: Color(0x0F000000),
              height: 20,
              thickness: 2,
            ),
            const SizedBox(height: 8),

            // Chat messages container
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length +
                    1, // +1 for "Vandaag" and "WinkelMedewerker"
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    // Add "Vandaag" and "WinkelMedewerker" at the top
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Vandaag",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF696969),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          padding: const EdgeInsets.all(17),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Winkelmedewerker',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Student',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF6F6F6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19.21),
                                    side: const BorderSide(
                                      color: Color(0xFFFF3E68),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icons/paper.svg',
                                      height: 15,
                                      width: 15,
                                    ),
                                    const SizedBox(width: 2),
                                    const Text(
                                      'Sollicitatie',
                                      style: TextStyle(
                                        color: Color(0xFFFF3E68),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  // Chat messages
                  final message = messages[messages.length - 1 - index];
                  return Align(
                    alignment: message.isSentByMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: message.isSentByMe ? 64.0 : 0,
                        right: message.isSentByMe ? 0 : 64.0,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: message.isSentByMe
                              ? const Color(0xFF3976FF)
                              : const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(17.79),
                            topRight: message.isSentByMe
                                ? Radius.zero
                                : const Radius.circular(17.79),
                            bottomLeft: message.isSentByMe
                                ? const Radius.circular(17.79)
                                : Radius.zero,
                            bottomRight: const Radius.circular(17.79),
                          ),
                        ),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            color: message.isSentByMe
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16.74,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Message input field positioned at the bottom
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 42,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 19.5,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFFBABABA),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Hier typen...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF6F6F6),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SvgPicture.asset(
                    "assets/images/logos/send_message.svg",
                    height: 42,
                    width: 42,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String content;
  final bool isSentByMe;

  Message({required this.content, required this.isSentByMe});
}
