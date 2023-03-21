import 'package:flutter/material.dart';
import 'package:tutorial_continuing/main_screen.dart';

void main() {
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube Tutorial Content',
      home: MainScreen(),
    );
  }
}
