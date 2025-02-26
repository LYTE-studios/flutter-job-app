import '../models/message.dart';
import '../services/api_service.dart';

class ChatService extends ApiService {
  ChatService();

  Future<List<Message>> getMessages() async {
    try {
      final response = await getApi('chat/history');
      return (response.data as List)
          .map((json) => Message.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch messages: $e');
    }
  }

  Future<Message> sendMessage(int chatId, String content) async {
    try {
      final response = await postApi(
        'chat/$chatId/messages/',
        data: {
          'content': content,
        },
      );

      return Message.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
