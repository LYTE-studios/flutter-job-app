import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../models/message.dart';

class ChatService {
  final ApiService _apiService;

  ChatService() : _apiService = ApiService();

  Future<List<Message>> getMessages(int chatId) async {
    try {
      final response = await _apiService.dio.get('chat/$chatId/messages/');
      return (response.data as List)
          .map((json) => Message.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch messages: $e');
    }
  }

  Future<Message> sendMessage(int chatId, String content) async {
    try {
      final response = await _apiService.dio
          .post('chat/$chatId/messages/', data: {'content': content});
      return Message.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
