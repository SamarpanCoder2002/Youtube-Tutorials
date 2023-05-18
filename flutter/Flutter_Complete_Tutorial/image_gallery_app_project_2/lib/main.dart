import 'package:flutter/material.dart';
import 'package:image_gallery_app/provider/main_provider.dart';
import './screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Searching App',
        home: MainScreen(),
      ),
    );
  }
}
