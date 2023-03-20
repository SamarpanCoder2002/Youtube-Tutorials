import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_first_project/screens/main_screen.dart';
import 'package:provider/provider.dart';
import './provider/top_level_provider.dart';

void main() {
  runApp(const EntryRoot());
}

class EntryRoot extends StatelessWidget {
  const EntryRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TopLevelProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youtube Tutorial',
        theme: ThemeData(
            // fontFamily: 'Poppins'
            ),
        home: const MainScreen(
          given: 'Youtube Tutorial',
        ),
      ),
    );
  }
}
