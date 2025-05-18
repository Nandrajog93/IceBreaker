import 'package:flutter/material.dart';

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> allMessages = [
    "Hi! 👋 Would you like to start your journey?",
    "Great! What's your name?",
    "Nice to meet you, Aakash! 🌟",
    "Do you believe in destiny?",
    "Sometimes the universe aligns just right... ✨",
    "Let's find someone who matches your vibe. ❤️",
  ];

  int currentMessageIndex = 0;

  void showNextMessage() {
    if (currentMessageIndex < allMessages.length - 1) {
      setState(() {
        currentMessageIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> visibleMessages =
        allMessages.sublist(0, currentMessageIndex + 1);

    return Scaffold(
      appBar: AppBar(title: const Text('Ice Breaker Bot 💬')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: visibleMessages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        visibleMessages[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (currentMessageIndex < allMessages.length - 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: showNextMessage,
                child: const Text('Next'),
              ),
            )
        ],
      ),
    );
  }
}
