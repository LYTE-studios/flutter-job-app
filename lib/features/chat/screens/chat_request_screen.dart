import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/ui/theme/padding_sizes.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';

import '../../../data/models/message.dart';

class ChatRequestScreen extends StatefulWidget {
  const ChatRequestScreen({super.key});

  static const String location = 'chat-request';

  static String employerRoute = JobrRouter.getRoute(
    location,
    JobrRouter.employerInitialroute,
  );

  @override
  State<ChatRequestScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatRequestScreen> {
  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the default back arrow
        /* leadingWidth: 80,
        leading: const Icon(Icons.arrow_back_ios,size: 30,color:  Color(0xFF000000)),*/
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
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Spicy Lemon',
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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: SafeArea(
            bottom: true,
            top: false,
            child: Column(
              children: [
                const Divider(
                  color: Color(0x0F000000),
                  height: 20,
                  thickness: 2,
                ),
                const Text(
                  "Zaterdag",
                  style: TextStyle(fontSize: 16, color: Color(0xFF696969)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  padding: const EdgeInsets.all(16),
                  // Internal padding
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  // External spacing
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Winkelmedewerker',
                            style: TextStyle(
                              fontSize: 17,
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
                          // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.21),
                            side: const BorderSide(
                                color: Color(0xFFFF3E68),
                                width: 1.92), // Border style
                          ),
                        ),
                        child: const Text(
                          'Bekijk vacature',
                          style: TextStyle(
                            color: Color(0xFFFF3E68),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Column(
                        // crossAxisAlignment: message.isSentByMe
                        //     ? CrossAxisAlignment.end
                        //     : CrossAxisAlignment.start,
                        children: [
                          Align(
                            // alignment: message.isSentByMe
                            //     ? Alignment.centerRight
                            //     : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                // color: message.isSentByMe
                                //     ? const Color(0xFF3976FF)
                                //     : const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(17.79),
                              ),
                              child: Text(
                                message.content,
                                style: const TextStyle(
                                  // color: message.isSentByMe
                                  //     ? Colors.white
                                  //     : Colors.black,
                                  fontSize: 16.74,
                                ),
                              ),
                            ),
                          ),
                          // if (message.showSeen == true)
                          //   const Padding(
                          //     padding: EdgeInsets.only(top: 2.0, right: 8.0),
                          //     child: Text(
                          //       "Verzonden",
                          //       style: TextStyle(
                          //         color: Color(0xFF6B6B6B),
                          //         fontSize: 13,
                          //       ),
                          //     ),
                          //   ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    // Wrap the TextField with a SizedBox to adjust width
                    const Expanded(
                      child: SizedBox(
                        height: 42,
                        // Adjust the width as needed
                        child: TextField(
                          style: TextStyle(
                              fontSize: 19.5,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFFBABABA)),
                          decoration: InputDecoration(
                            hintText: 'Hier typen...',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.0), // Adjust the height
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
                const SizedBox(
                  height: PaddingSizes.medium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
