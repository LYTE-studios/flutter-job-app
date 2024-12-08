import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/chat_message.dart';

class ChatRequest extends StatefulWidget {
  const ChatRequest({super.key});

  @override
  State<ChatRequest> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatRequest> {

  final List<ChatMessage> messages = [
    ChatMessage(message: 'Hey Louis,', time: '09:46', isSentByMe: false),
    ChatMessage(message: 'Kan je morgen langskomen voor een sollicitatiegesprek?', time: '09:47', isSentByMe: false),
    ChatMessage(message: 'Kan ik morgen eventueel langs ...', time: '09:48', isSentByMe: true),
    ChatMessage(message: 'Hey! Ja hoor, ik kan rond 15u?', time: '09:49', isSentByMe: false),
    ChatMessage(message: 'Perfect, kom dan maar af!', time: '09:50', isSentByMe: true),
    ChatMessage(message: 'Thanks, tot morgen!', time: '09:51', isSentByMe: false),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: const Icon(Icons.arrow_back_ios),
        title: Row(
          children: [
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
            SizedBox(width: 8,),
            const Text(
              'Spicy Lemon',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Eloquia',
              ),
            ),
          ],
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 13.0),child: SvgPicture.asset("assets/images/logos/info.svg",height: 28,width: 28,),)
        ],
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            children: [
              const Divider(
                color:   Color(0x0F000000),
                height: 20,
                thickness: 1,
              ),
              const Text("Zaterdag",style: TextStyle( fontSize: 16),),
              Container(
                decoration: BoxDecoration(
                  color:  const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(17),
                ),
                padding: const EdgeInsets.all(16), // Internal padding
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // External spacing
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
                              fontFamily: 'Eloquia',
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
                        backgroundColor: Colors.white, // Button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                          side: const BorderSide(color: Color(0xFFFF3E68), width: 1), // Border style
                        ),
                      ),
                      child: Text(
                        'Bekijk vacature',
                        style: TextStyle(
                          color: Color(0xFFFF3E68),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Eloquia',
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
                    return Align(
                      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: message.isSentByMe ? const Color(0xFF3976FF) : const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(17.79),
                        ),
                        child: Column(
                          crossAxisAlignment: message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message,
                              style: TextStyle(color: message.isSentByMe ? Colors.white : Colors.black,fontSize: 16.74,fontFamily: 'DMSans',),
                            ),
                            Text(
                              message.time,
                              style: TextStyle(color: message.isSentByMe ? Colors.white70 : Colors.black54, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wrap the TextField with a SizedBox to adjust width
                  const SizedBox(
                    width: 333,
                    height: 39,
                    // Adjust the width as needed
                    child: TextField(
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: 'Hier typen...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0), // Adjust the height
                      ),
                    ),
                  ),
                  SizedBox(width:6 ),
                  SvgPicture.asset("assets/images/logos/send_message.svg",height: 32,width: 32,)
                ],
              ),
SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
