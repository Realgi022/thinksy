
import 'package:flutter/material.dart';

import 'package:thinksy/features/chat/data/models/chat_message.dart';
import 'package:thinksy/features/chat/data/services/chat_service.dart';
import 'package:thinksy/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:thinksy/features/chat/presentation/widgets/chat_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  final ChatService _chatService = ChatService();

  bool _isLoading = false;

  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hey there! 👋 I'm Thinksy, your learning buddy.\n\n"
          "I'm here to help you understand concepts, not just "
          "hand you answers.\n\n"
          "What are we learning today?",
      role: ChatRole.assistant,
    ),
  ];

  Future<void> _sendMessage(String text) async {
    final question = text.trim();

    if (question.isEmpty || _isLoading) {
      return;
    }

    // Save previous conversation messages.
    // Exclude the initial welcome message.
    final history = _messages.skip(1).toList();

    // Add the student's question to the chat.
    setState(() {
      _messages.add(
        ChatMessage(
          text: question,
          role: ChatRole.user,
        ),
      );

      _isLoading = true;
    });

    _scrollToBottom();

    try {
      // Send the question to our Node.js backend,
      // which communicates with Google Gemini.
      final reply = await _chatService.sendMessage(
        message: question,
        history: history,
      );

      if (!mounted) return;

      // Display the real Gemini response.
      setState(() {
        _messages.add(
          ChatMessage(
            text: reply,
            role: ChatRole.assistant,
          ),
        );
      });
    } catch (error) {
      if (!mounted) return;

      final errorMessage = error.toString().replaceFirst(
        'Exception: ',
        '',
      );

      // Show an error if the backend cannot respond.
      setState(() {
        _messages.add(
          ChatMessage(
            text:
                "Oops! 😅 Something went wrong.\n\n"
                "$errorMessage\n\n"
                "Make sure the Thinksy backend is running "
                "and try again.",
            role: ChatRole.assistant,
          ),
        );
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF7C276F),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFF4EAF3),
              child: Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFF7C276F),
              ),
            ),

            SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thinksy AI',
                  style: TextStyle(
                    color: Color(0xFF33243A),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  'Your learning companion',
                  style: TextStyle(
                    color: Color(0xFF99909D),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),

                itemCount: _messages.length + (_isLoading ? 1 : 0),

                itemBuilder: (context, index) {
                  // Show loading indicator while Gemini responds.
                  if (index == _messages.length) {
                    return const _ThinkingIndicator();
                  }

                  return ChatBubble(
                    message: _messages[index],
                  );
                },
              ),
            ),

            ChatInput(
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

// Loading indicator displayed while waiting for Gemini.
class _ThinkingIndicator extends StatelessWidget {
  const _ThinkingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        decoration: BoxDecoration(
          color: const Color(0xFFF4EAF3),
          borderRadius: BorderRadius.circular(18),
        ),

        child: const Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF7C276F),
              ),
            ),

            SizedBox(width: 10),

            Text(
              'Thinksy is thinking...',
              style: TextStyle(
                color: Color(0xFF7C276F),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
