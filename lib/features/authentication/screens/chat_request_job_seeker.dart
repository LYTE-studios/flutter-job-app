import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/chat_message.dart';

class ChatRequestJobSeeker extends StatefulWidget {
  const ChatRequestJobSeeker({super.key});

  @override
  State<ChatRequestJobSeeker> createState() => _ChatRequestJobSeeker();
}

class _ChatRequestJobSeeker extends State<ChatRequestJobSeeker> {
  final List<ChatMessage> messages = [
    ChatMessage(
        message: 'Perfect, kom dan maar af!', isSentByMe: true, showSeen: true),
    ChatMessage(message: 'Thanks, tot morgen!', isSentByMe: false),
    // Show "seen" text here
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(
      context,
      designSize: Size(393, 852), // Example: Figma design dimensions
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the default back arrow
        /* leadingWidth: 80,
        leading: const Icon(Icons.arrow_back_ios,size: 30,color:  Color(0xFF000000)),*/
        title: Row(
          children: [
            const SizedBox(
              width: 22,
            ),
             GestureDetector(
               onTap: () {Navigator.pop(context);
               },
               child: Icon(Icons.arrow_back_ios,
                   size: 21.w, color: const Color(0xFF000000)),
             ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/logos/louis_ottevaere.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
             Text(
              'Louis Ottevaere',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 26.0),
            child: SvgPicture.asset(
              "assets/images/logos/dial.svg",
              height: 28,
              width: 28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: SvgPicture.asset(
              "assets/images/logos/info.svg",
              height: 28,
              width: 28,
            ),
          ),
        ],
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  color: Color(0x0F000000),
                  height: 20,
                  thickness: 2,
                ),
                const Text(
                  "Vandaag",
                  style: TextStyle(fontSize: 16, color: Color(0xFF696969)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  padding: const EdgeInsets.all(16),
                  // Internal padding
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  // External spacing
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Winkelmedewerker',
                            style: TextStyle(
                              fontSize: 17.05.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Student',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120.w,
                        height: 31.h,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF6F6F6),
                              elevation: 0,
                              // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19.21),
                                side: const BorderSide(
                                    color: Color(0xFFFF3E68),
                                    width: 1.92), // Border style
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/logos/paper.svg",
                                    height: 12.74, width: 11.16),
                                SizedBox(width: 3.sp),
                                const Text(
                                  'Sollicitatie',
                                  style: TextStyle(
                                    color: Color(0xFFFF3E68),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Eloquia',
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: 300,
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3976FF),
                              borderRadius: BorderRadius.circular(17.79),
                            ),
                            child:  const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hey Louis,',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.74,
                                  fontFamily: 'DMSans',
                                ),),
                                SizedBox(height: 20),
                                Text('Kan je morgen langskomen voor een sollicitatiegesprek?',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.74,
                                  fontFamily: 'DMSans',
                                ),),
                              ],
                            )
                        ),)
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            width: 300,
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F6F6),
                              borderRadius: BorderRadius.circular(17.79),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 2.w,
                                      height: 34.h, // Adjust height for alignment
                                      margin:
                                      const EdgeInsets.only(left: 12, top: 12),
                                      color: Color(0xFF3976FF),
                                    ),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(12, 12, 12, 4),
                                          child: Text(
                                            "Louis",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                          child: Text(
                                            "Kan ik morgen eventueel langs...",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Text(
                                    "Hey! Ja hoor, ik kan rond 15u?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.74,
                                      fontFamily: 'DMSans',
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
               SizedBox(
                 height: screenHeight / 2.8,
                 child:  Expanded(
                   child: ListView.builder(
                     itemCount: messages.length,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder: (context, index) {
                       final message = messages[index];
                       return Column(
                         crossAxisAlignment: message.isSentByMe
                             ? CrossAxisAlignment.end
                             : CrossAxisAlignment.start,
                         children: [
                           Align(
                             alignment: message.isSentByMe
                                 ? Alignment.centerRight
                                 : Alignment.centerLeft,
                             child: Container(
                               margin: const EdgeInsets.symmetric(vertical: 5.0),
                               padding: const EdgeInsets.all(10.0),
                               decoration: BoxDecoration(
                                 color: message.isSentByMe
                                     ? const Color(0xFF3976FF)
                                     : const Color(0xFFF6F6F6),
                                 borderRadius: BorderRadius.circular(17.79),
                               ),
                               child: Text(
                                 message.message,
                                 style: TextStyle(
                                   color: message.isSentByMe
                                       ? Colors.white
                                       : Colors.black,
                                   fontSize: 16.74,
                                   fontFamily: 'DMSans',
                                 ),
                               ),
                             ),
                           ),
                           if (message.showSeen == true)
                             const Padding(
                               padding: EdgeInsets.only(top: 2.0, right: 8.0),
                               child: Text(
                                 "Gelezen",
                                 style: TextStyle(
                                   color: const Color(0xFF3976FF),
                                   fontSize: 13,
                                   fontFamily: 'DMSans',
                                 ),
                               ),
                             ),
                         ],
                       );
                     },
                   ),
                 ),
               ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Wrap the TextField with a SizedBox to adjust width
                    SizedBox(
                      width: 333,
                      height: 39.h,
                      // Adjust the width as needed
                      child: TextField(
                        style: TextStyle(
                            fontSize: 16.74.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Hier typen...',
                          hintStyle: TextStyle(fontSize: 16.74.sp ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(1))),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0), // Adjust the height
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      "assets/images/logos/send_message.svg",
                      height: 32,
                      width: 32,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
