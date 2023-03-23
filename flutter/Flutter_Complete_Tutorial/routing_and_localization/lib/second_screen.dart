import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String name;
  final int age;
  final int roll;
  const SecondScreen({super.key, required this.name, required this.age, required this.roll});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('second_screen'.tr(), style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
             Text('Name: ${widget.name}', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
             Text('Age: ${widget.age}', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
             Text('Roll: ${widget.roll}', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/first');
                },
                child: const Text(
                  'Go to First Screen',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
