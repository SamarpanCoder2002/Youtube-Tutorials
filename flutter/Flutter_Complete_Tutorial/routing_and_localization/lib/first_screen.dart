import 'package:flutter/material.dart';
import 'package:routing_and_localization/second_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('first_screen'.tr(), style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/second',
                      arguments: <String, dynamic>{
                        'name': 'Samarpan Dasgupta',
                        'age': 22,
                        'roll': 1456
                      });

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (_) =>
                  //         SecondScreen(name: name, age: age, roll: roll)));
                },
                child: const Text(
                  'Go to Second Screen',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(const Locale('en', 'HN'));
                },
                child: const Text(
                  'Change to Hindi',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(const Locale('en', 'US'));
                },
                child: const Text(
                  'Change to English',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
