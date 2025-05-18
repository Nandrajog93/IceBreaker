import 'package:flutter/material.dart';

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
      home: const IceBreakerHome(),
    );
  }
}

class IceBreakerHome extends StatefulWidget {
  const IceBreakerHome({super.key});

  @override
  State<IceBreakerHome> createState() => _IceBreakerHomeState();
}

class _IceBreakerHomeState extends State<IceBreakerHome> {
  String currentUser = 'A';

  List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) {
    setState(() {
      messages.add({
        'from': currentUser,
        'to': currentUser == 'A' ? 'B' : 'A',
        'text': text,
        'timestamp': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> visibleMessages = messages
        .where((msg) => msg['from'] == currentUser || msg['to'] == currentUser)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('IceBreaker Messages'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              value: currentUser,
              underline: Container(),
              items: ['A', 'B'].map((user) {
                return DropdownMenuItem(
                  value: user,
                  child: Text("User $user"),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    currentUser = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: visibleMessages.length,
              itemBuilder: (context, index) {
                final msg = visibleMessages[index];
                bool isMe = msg['from'] == currentUser;
                return ListTile(
                  leading: isMe ? null : const Icon(Icons.person),
                  trailing: isMe ? const Icon(Icons.person_outline) : null,
                  title: Text(
                    msg['text'],
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "From: User ${msg['from']} → To: User ${msg['to']}",
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              children: [
                if (currentUser == 'A') ...[
                  ElevatedButton(
                    onPressed: () => sendMessage("Send Icebreaker"),
                    child: const Text("Send Icebreaker"),
                  ),
                  ElevatedButton(
                    onPressed: () => sendMessage("Ask for a Coffee"),
                    child: const Text("Ask for Coffee"),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () =>
                        sendMessage("There is an Icebreaker request by User A"),
                    child: const Text("Respond to Icebreaker"),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        sendMessage("Do you accept coffee request?"),
                    child: const Text("Coffee Request"),
                  ),
                  ElevatedButton(
                    onPressed: () => sendMessage("Sending location... 📍"),
                    child: const Text("Send Location"),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
