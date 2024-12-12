class ChatMessage {
  final String message;
  final bool isSentByMe;
  final bool showSeen; // New property

  ChatMessage({
    required this.message,
    required this.isSentByMe,
    this.showSeen = false, // Default is false
  });
}
