import 'package:flutter/material.dart';

import '../models/chat_users_model.dart';
import '../widgets/conversation_list.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Spicy Lemon",
        messageText: "Top, tot dan!",
        imageURL: "https://randomuser.me/api/portraits/women/1.jpg",
        time: "09:46",
        unreadCount:0

    ),
    ChatUsers(
        name: "Brooklyn Kortrijk",
        messageText: "Ik: Plannen we anders een ges..",
        imageURL: "https://randomuser.me/api/portraits/women/2.jpg",
        time: "07:23",
        unreadCount: 1
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Chat",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Text("Alle", style: TextStyle(color: Colors.red, fontSize:16.18)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Ongelezen", style: TextStyle(color: Colors.blueGrey, fontSize:16.18)),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("3 Verzoeken", style: TextStyle(color: Colors.red, fontSize:16.18)),
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 1) ? true : false,
                    unreadCount: chatUsers[index].unreadCount
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
