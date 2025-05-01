import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // {'sender': 'user'|'bot', 'text': '...'}
  bool _isSending = false;

  Future<void> sendMessage(String message) async {
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
      _isSending = true;
    });

    _controller.clear();

    try {
      // Replace this with your actual API endpoint
      final response = await http.post(
        Uri.parse('http://www.enviroewatch.com/chatbot'), // Update to your backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      String botReply = "Sorry, I couldn't understand that.";
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        botReply = data['response'] ?? botReply;
      }

      setState(() {
        _messages.add({'sender': 'bot', 'text': botReply});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'bot', 'text': 'Error connecting to server.'});
      });
    } finally {
      setState(() => _isSending = false);
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    final isUser = message['sender'] == 'user';
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message['text']!, style: const TextStyle(fontSize: 15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviro ChatBot'),
        leading: OutlinedButton(onPressed: () => {Get.back()}, 
        child: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _isSending ? null : sendMessage,
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: _isSending
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.send),
                  onPressed: _isSending
                      ? null
                      : () {
                          if (_controller.text.trim().isNotEmpty) {
                            sendMessage(_controller.text.trim());
                          }
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
