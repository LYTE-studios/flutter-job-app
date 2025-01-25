class Message {
  final int id;
  final String content;
  final String sender;
  final String timestamp;

  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      sender: json['sender'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender,
      'timestamp': timestamp,
    };
  }
}
