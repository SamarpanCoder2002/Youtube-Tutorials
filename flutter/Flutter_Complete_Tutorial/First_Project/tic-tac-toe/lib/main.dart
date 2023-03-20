import 'package:flutter/material.dart';
import './main_screen.dart';

void main() {
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      title: 'Tic-Tac-Toe',
      home: const MainScreen(),
    );
  }
}
