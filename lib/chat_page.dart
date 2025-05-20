import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ice_breaker_2025/MyHomePage.dart';
import 'package:ice_breaker_2025/main.dart';
import 'package:ice_breaker_2025/send_maps.dart';

void main() {
  runApp(const IceBreakerApp());
}

class IceBreakerApp extends StatelessWidget {
  const IceBreakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IceBreaker',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: ChatPage(),
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
    "Do you want to send the request for Icebreaker",
    ''
  ];

  int currentMessageIndex = 0;

  void showNextMessage() {
    if (currentMessageIndex < allMessages.length - 1) {
      setState(() {
        currentMessageIndex += 1;
        print("Selected Index: $currentMessageIndex");
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
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        //  color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: index == 2
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        onPressed: () {},
                                        text: 'Yes',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        onPressed: () {},
                                        text: 'No, I changed my mind',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: showNextMessage,
                              child: Text(
                                visibleMessages[index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          // if (currentMessageIndex < allMessages.length - 1)
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: ElevatedButton(
          //       onPressed: showNextMessage,

          //     ),
          //   )
        ],
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _showMessage = false;

  void updateCounter() {
    if (widget.text == 'Yes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SendLocation()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: updateCounter,
          child: Text(widget.text),
        ),
        // const SizedBox(height: 8),
        // AnimatedCrossFade(
        //   duration: Duration(milliseconds: 300),
        //   firstChild: const SizedBox.shrink(),
        //   secondChild: Text(
        //     widget.text == 'Yes' ? "Sending your location......." : '',
        //     style: const TextStyle(fontSize: 16),
        //   ),
        //   crossFadeState: _showMessage
        //       ? CrossFadeState.showSecond
        //       : CrossFadeState.showFirst,
        // )
      ],
    ));
  }
}
