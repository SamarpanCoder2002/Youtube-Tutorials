import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error Screen', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Go to First Screen', style: TextStyle(fontSize: 18),))
          ],
        ),
      ),
    );
  }
}
