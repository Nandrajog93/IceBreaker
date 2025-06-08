import 'package:flutter/material.dart';
import 'package:ice_breaker_2025/component/button.dart';
import 'package:ice_breaker_2025/component/my_text_field.dart';

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
      home: const Registration(),
    );
  }
}

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Icon(
                  Icons.message,
                  size: 60,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Welcome back you\'ve missed",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 50),
                MyTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscurText: false),
                const SizedBox(height: 10),
                MyTextfield(
                    controller: passwordController,
                    hintText: 'password',
                    obscurText: true),
                const SizedBox(height: 25),
                Mybutton(onTap: () {}, text: "sign "),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    const SizedBox(width: 4),
                    Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
