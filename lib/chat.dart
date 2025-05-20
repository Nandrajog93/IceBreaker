import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class Message {
  final String text;
  final bool isLocation;
  final double latitude;
  final double longitude;

  Message({
    required this.text,
    required this.isLocation,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Chat App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(Message(text: _textController.text, isLocation: false));
    });
    _textController.clear();
  }

  Future<void> _sendLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      Message locationMessage = Message(
        text: 'Location Shared',
        isLocation: true,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      setState(() {
        _messages.add(locationMessage);
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Widget _buildMessage(Message message) {
    if (message.isLocation) {
      final lat = message.latitude;
      final lon = message.longitude;
      final mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

      return GestureDetector(
        onTap: () async {
          final uri = Uri.parse(mapsUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open map')),
            );
          }
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.location_pin, color: Colors.red, size: 32),
            title: Text("Shared Location"),
            subtitle: Text("Tap to view on map"),
            tileColor: Colors.grey.shade100,
          ),
        ),
      );
    } else {
      return ListTile(
        title: Text(message.text),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      );
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.redAccent,
            onPressed: _sendLocation,
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(child: Text('No messages yet'))
                : ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessage(_messages[index]);
                    },
                  ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }
}
