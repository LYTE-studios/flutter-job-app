// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'chat_request_job_seeker.dart';

// class ChatRequestJobSeekerVerzoeken extends StatefulWidget {
//   const ChatRequestJobSeekerVerzoeken({super.key});

//   @override
//   State<ChatRequestJobSeekerVerzoeken> createState() =>
//       _ChatRequestJobSeekerVerzoeken();
// }

// class _ChatRequestJobSeekerVerzoeken
//     extends State<ChatRequestJobSeekerVerzoeken> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     final List<Map<String, dynamic>> chatData = [
//       {
//         'name': 'Djimon Delvoye',
//         'message': 'Hey! Ik zag op jullie website dat...',
//         'time': '07:23',
//         'image': 'assets/images/logos/djimon_delvoye.png',
//         'unreadCount': 1,
//       },
//     ];
//     ScreenUtil.init(
//       context,
//       designSize: Size(393, 852), // Example: Figma design dimensions
//       minTextAdapt: true,
//       splitScreenMode: true,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // Removes the default back arrow
//         /* leadingWidth: 80,
//         leading: const Icon(Icons.arrow_back_ios,size: 30,color:  Color(0xFF000000)),*/
//         title: Row(
//           children: [
//             const SizedBox(
//               width: 22,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(Icons.arrow_back_ios,
//                   size: 21.w, color: const Color(0xFF000000)),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               'Berichtverzoeken',
//               style: TextStyle(
//                 fontSize: 17.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         width: screenWidth,
//         height: screenHeight,
//         color: Colors.white,
//         child: Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 17.0),
//             child:Column(
//               children: [
//                 SizedBox(height: 4.h),
//                Padding(padding: EdgeInsets.only(left: 12,right: 12),child:  Text(
//                  "Hier vind je werkzoekenden die zelf contact opnemen. Dit kan een vraag zijn of een spontane sollicitatie.",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500,color: Color(0xFF6D6D6D)),)),
//                 const SizedBox(height: 18),
//                 const Divider(
//                   color:   Color(0x0F000000),
//                   height: 20,
//                   thickness: 1.5,
//                   indent: 74,
//                 ),
//                 Expanded(
//                     child: GestureDetector(
//                       onTap: () { Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ChatRequestJobSeeker(),
//                         ),
//                       );},
//                       child: ListView.builder(
//                         itemCount: chatData.length,
//                         itemBuilder: (context, index) {
//                           final chat = chatData[index];
//                           return Column(
//                             children: [
//                               _buildChatItem(chat),
//                               const Divider(
//                                 color:   Color(0x0F000000),
//                                 height: 20,
//                                 thickness: 1.5,
//                                 indent: 74,
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     )
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }

// Widget _buildChatItem(Map<String, dynamic> chat) {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       // Profile Picture
//       Container(
//         width: 67,
//         height: 67,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             image: AssetImage(chat['image']),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       const SizedBox(width: 16),
//       // Chat Details
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               chat['name'],
//               style: const TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               chat['message'],
//               style: const TextStyle(
//                 color: Color(0xFF8F8F8F),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(width: 16),
//       // Time and Unread Count
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(
//             chat['time'],
//             style: TextStyle(
//               color: chat['unreadCount'] > 0 ?const Color(0xFFFF3E68) : const Color(0xFF8F8F8F),
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (chat['unreadCount'] > 0)
//             CircleAvatar(
//               radius: 10,
//               backgroundColor:const Color(0xFFFF3E68),
//               child: Text(
//                 '${chat['unreadCount']}',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Eloquia',
//                 ),
//               ),
//             ),
//         ],
//       ),
//     ],
//   );
// }
