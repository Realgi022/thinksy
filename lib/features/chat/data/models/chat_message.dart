
enum ChatRole { user, assistant }

class ChatMessage {
  final String text;
  final ChatRole role;
  final DateTime createdAt;

  ChatMessage({
    required this.text,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isUser => role == ChatRole.user;
}
