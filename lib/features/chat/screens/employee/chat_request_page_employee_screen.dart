import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

class ChatRequestEmployeePageScreen extends StatefulWidget {
  const ChatRequestEmployeePageScreen({super.key});

  static const String location = 'chat-request-page';

  static String employeeRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employeeInitialroute,
  );
  @override
  State<ChatRequestEmployeePageScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatRequestEmployeePageScreen> {
  final List<Message> messages = [
    Message(
      content: '''Hey Lotte,

We zijn nog op zoek naar een
student die ons kan
komen versterken in de weekends.
Jouw profiel komt echt helemaal
overeen met wat we zoeken! Moest
je interesse hebben: je kan de vacature
onder dit bericht vinden. Ik kijk uit
naar een antwoord :)''',
      isSentByMe: true,
    ),
    Message(
      content:
          '''Hey!\nIk zag op jullie website dat julie altijd op zoek zijn naar nieuwe studenten om bij jullie aan de slag te gaan. Is dat nog steeds het geval? Zo ja, zou ik heel graag solliciteren :)\nAlvast bedankt!\nDjimon''',
      isSentByMe: false,
    ),
    Message(
      content:
          '''Hey!\nIk zag op jullie website dat julie altijd op zoek zijn naar nieuwe studenten om bij jullie aan de slag te gaan. Is dat nog steeds het geval? Zo ja, zou ik heel graag solliciteren :)\nAlvast bedankt!\nDjimon''',
      isSentByMe: false,
    ),
    Message(
      content: '''Hey Lotte,

We zijn nog op zoek naar een
student die ons kan
komen versterken in de weekends.
Jouw profiel komt echt helemaal
overeen met wat we zoeken! Moest
je interesse hebben: je kan de vacature
onder dit bericht vinden. Ik kijk uit
naar een antwoord :)''',
      isSentByMe: false,
    ),
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
                  size: 23,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/logos/image 15.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Djimon Dilvoye',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const SvgIcon(
              "assets/images/logos/info.svg",
              leaveUnaltered: true,
              size: 24,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
          child: Column(
            children: [
              const Divider(
                color: Color(0x0F000000),
                height: 20,
                thickness: 2,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isFirstMessage = index == 0;
                      final isLastMessage = index == messages.length - 1;
                      return Column(
                        crossAxisAlignment: message.isSentByMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (isFirstMessage)
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Zaterdaag",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF696969),
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: message.isSentByMe ? 64.0 : 0,
                              right: message.isSentByMe ? 0 : 64.0,
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: message.isSentByMe
                                    ? const Color(0xFF3976FF)
                                    : const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(17.79),
                                  bottomRight: const Radius.circular(17.79),
                                  topLeft: message.isSentByMe
                                      ? const Radius.circular(17.79)
                                      : Radius.zero,
                                  topRight: message.isSentByMe
                                      ? Radius.zero
                                      : const Radius.circular(17.79),
                                ),
                              ),
                              child: Text(
                                message.content,
                                style: TextStyle(
                                  color: message.isSentByMe
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          if (isLastMessage)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, right: 0, top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                padding: const EdgeInsets.all(17),
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        backgroundColor:
                                            const Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(19.21),
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
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Message input field positioned at the bottom
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20.0,
                ),
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
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
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
      ),
    );
  }
}

class Message {
  final String content;
  final bool isSentByMe;

  Message({required this.content, required this.isSentByMe});
}
