import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/message.dart';
import 'package:jobr/features/Sollicitaties/sollicitaties_tabs_info.dart';
import 'package:lyte_studios_flutter_ui/ui/icons/svg_icon.dart';

class ChatPageEmployeeScreen extends StatefulWidget {
  const ChatPageEmployeeScreen({super.key});

  static const String location = 'chat-page';

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );
  @override
  State<ChatPageEmployeeScreen> createState() => _ChatPageEmployeeScreenState();
}

class _ChatPageEmployeeScreenState extends State<ChatPageEmployeeScreen> {
  final List<Message> messages = [
//     Message(content: '''Hey Emma! Ik zag je sollicitatie voor
// onze winkelmedewerker-vacature.
// Je profiel spreekt ons enorm aan.
// Wanneer zie je het zitten om eens
// langs te komen?''', isSentByMe: false),
//     Message(
//         content: "Kan je morgen langskomen voor een sollicitatiegesprek?",
//         isSentByMe: false),
//     Message(
//         content:
//             "Kan ik morgen eventueel langs... Hey! Ja hoor, ik kan rond 15u?",
//         isSentByMe: true),
//     Message(content: "Perfect, kom dan maar af!", isSentByMe: false),
//     Message(content: "Thanks, tot morgen!", isSentByMe: true),
  ];

  // New variables for text input control and icon color change
  final TextEditingController _messageController = TextEditingController();
  bool hasMessage = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        hasMessage = _messageController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

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
              icon: const Icon(Icons.arrow_back_ios, size: 23),
            ),
            GestureDetector(
              onTap: () => context.push(JobInfoScreen.route),
              child: Row(
                children: [
                  Container(
                    width: 33,
                    height: 33,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/logos/spicy_lemon.png"),
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
                ],
              ),
            ),

            // const Spacer(),
            // GestureDetector(
            //   onTap: () => context.push(JobInfoScreen.route),
            //   child: SvgIcon(
            //     "assets/images/logos/info.svg",
            //     size: 24,
            //     color: Colors.grey[400],
            //   ),
            // ),
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

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Container(
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
                          'Pitarist',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Student',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
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
                          const Text(
                            'Bekijken',
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
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Vandaag",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    color: Color(0xFF696969),
                  ),
                ),
              ),
            ),

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
                      children: [],
                    );
                  }

                  // Chat messages
                  final message = messages[messages.length - 1 - index];
                  return Align(
                    // alignment: message.isSentByMe
                    //     ? Alignment.centerRight
                    //     : Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          // left: message.isSentByMe ? 64.0 : 0,
                          // right: message.isSentByMe ? 0 : 64.0,
                          ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          // color: message.isSentByMe
                          //     ? const Color(0xFF3976FF)
                          //     : const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(17.79),
                            // topRight: message.isSentByMe
                            //     ? Radius.zero
                            //     : const Radius.circular(17.79),
                            // bottomLeft: message.isSentByMe
                            //     ? const Radius.circular(17.79)
                            //     : Radius.zero,
                            bottomRight: const Radius.circular(17.79),
                          ),
                        ),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            // color: message.isSentByMe
                            //     ? Colors.white
                            //     : Colors.black,
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
                        controller: _messageController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Hier typen...',
                          hintStyle: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFBABABA),
                          ),
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
                    !hasMessage
                        ? "assets/images/icons/empty_send_icon.svg"
                        : "assets/images/logos/send_message.svg",
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
