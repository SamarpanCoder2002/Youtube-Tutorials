import 'package:flutter/material.dart';
import 'package:tutorial_first_project/provider/top_level_provider.dart';
import 'package:tutorial_first_project/screens/third_screen.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  final int _number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 25,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
        ),
        body: Consumer<TopLevelProvider>(
          builder: (_, provider, __) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Second Screen',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumber.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumOne.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumTwo.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumThree.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumFour.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumFive.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumSix.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  provider.storedNumSeven.toString(),
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ThirdScreen()));
                    },
                    child: const Text(
                      'Navigate',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ));
  }
}
