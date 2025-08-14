import 'package:flutter/material.dart';
import 'background.dart';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  final String doctorName;

  ChatScreen({required this.doctorName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final Random random = Random();

  final Map<String, List<String>> glucoseResponses = {
    'greeting': [
      "Hello! How are you feeling today?",


    ],
    'high': [
      "Your glucose level is high. Please avoid sugary foods.",
      "Make sure to hydrate and walk for a bit if possible.",
      "This spike may need an insulin adjustment. Monitor closely.",
    ],
    'low': [
      "A drop in glucose can be dangerous. Please eat something with sugar immediately.",
      "Are you feeling dizzy? Take some juice or glucose tablets.",
      "Make sure to keep quick snacks with you at all times.",
    ],
    'normal': [
      "That’s great! Keep maintaining this with your routine.",
      "Sounds like your levels are stable. Good job!",
      "Perfect! Continue your current diet and activity plan.",
    ],
    'default': [
      "Thanks for the update. Please continue to monitor your levels.",
      "Let me know if your glucose fluctuates.",
      "Make sure to track your meals and activity.",
    ],
  };

  void sendMessage() {
    final userInput = _controller.text.trim();
    final text = userInput.toLowerCase();

    if (userInput.isNotEmpty) {
      setState(() {
        messages.add({"text": userInput, "isUser": true});
      });
      _controller.clear();

      String responseType = 'default';

      if (text.contains('hiii doctor') || text.contains('hello') || text.contains('hi mam') || text.contains('hlo') ||text.contains('hii')) {
        responseType = 'greeting';
      } else if (text.contains('high') || text.contains('spike') || text.contains('above')) {
        responseType = 'high';
      } else if (text.contains('low') || text.contains('below') || text.contains('drop') || text.contains('dizzy')) {
        responseType = 'low';
      } else if (text.contains('normal') || text.contains('fine') || text.contains('ok') || text.contains('medium')) {
        responseType = 'normal';
      }

      final replyList = glucoseResponses[responseType]!;
      final reply = replyList[random.nextInt(replyList.length)];

      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          messages.add({"text": reply, "isUser": false});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with ${widget.doctorName}")),
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return Align(
                      alignment: msg['isUser']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: msg['isUser']
                              ? Colors.teal[300]
                              : Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          msg['text'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 1),
              Container(
                color: Colors.white.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}