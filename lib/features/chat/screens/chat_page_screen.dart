import 'package:flutter/material.dart';

import '../models/chatUsersModel.dart';
import '../widgets/conversationList.dart';

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
        unreadCount: 2
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
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
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
                        child: Text("All", style: TextStyle(color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text("Ongelezen", style: TextStyle(color: Colors.blueGrey)),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("3 Verzoeken", style: TextStyle(color: Colors.red)),
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
