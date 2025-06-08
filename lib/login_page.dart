import 'package:flutter/material.dart';

void main() {
  runApp(IceBreakerApp());
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
      home: LPage(),
    );
  }
}

class LPage extends StatelessWidget {
  const LPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Welcome back fellas!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField()
          ],
        ),
      ),
    );
  }
}
