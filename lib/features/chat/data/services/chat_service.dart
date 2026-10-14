
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:thinksy/features/chat/data/models/chat_message.dart';

class ChatService {
  static const String _baseUrl = 'http://127.0.0.1:3000';

  Future<String> sendMessage({
    required String message,
    required List<ChatMessage> history,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Please sign in to use Thinksy AI.');
    }

    final token = await user.getIdToken();

    if (token == null) {
      throw Exception('Unable to verify your login session.');
    }

    final recentHistory = history.length > 10
        ? history.sublist(history.length - 10)
        : history;

    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/chat'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'message': message,
              'history': recentHistory.map((item) {
                return {
                  'role': item.isUser ? 'user' : 'model',
                  'text': item.text,
                };
              }).toList(),
            }),
          )
          .timeout(const Duration(seconds: 65));

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw Exception('Invalid response from Thinksy.');
      }

      if (response.statusCode != 200) {
        throw Exception(
          decoded['error']?.toString() ??
              'Thinksy server returned an error.',
        );
      }

      final reply = decoded['reply'];

      if (reply is! String || reply.trim().isEmpty) {
        throw Exception('Thinksy returned an empty response.');
      }

      return reply.trim();
    } catch (error) {
      throw Exception('Thinksy request failed: $error');
    }
  }
}
