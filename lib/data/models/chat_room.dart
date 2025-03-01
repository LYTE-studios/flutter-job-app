import 'package:jobr/data/models/user.dart';

import 'message.dart';

class ChatRoom {
  final int id;

  final User employer;

  final User employee;

  final List<Message> messages;

  ChatRoom({
    required this.id,
    required this.employer,
    required this.employee,
    required this.messages,
  });

  ChatRoom.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'] as int,
        employer = User.fromJson(json['employer']),
        employee = User.fromJson(json['employee']),
        messages = (json['messages'] as List)
            .map(
              (e) => Message.fromJson(e),
            )
            .toList();

  /// Method to convert a Vacancy object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
