import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial_first_project/helper/manual_debug.dart';
import 'package:tutorial_first_project/screens/second_screen.dart';

import '../config/local_storage_management.dart';
import 'package:provider/provider.dart';

import '../provider/top_level_provider.dart';

class MainScreen extends StatefulWidget {
  final String given;
  const MainScreen({super.key, required this.given});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _number = 0;
  int _number2 = 0;

  int? _number3;
  String? _name;

  _initialize() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    final _latestNumber = await LocalStorageManagement.getData();

    if (_latestNumber == null) return;

    _number3 ??= 10;
    _name ??= 'Samarpan Dasgupta';

    setState(() {
      _number = _latestNumber;
    });
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _actionButton(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _number.toString(),
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Text(
              _number2.toString(),
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Text(
              ((_number3 ?? 0) + 5).toString(),
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Text(
              _name!.toLowerCase(),
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SecondScreen()));
                },
                child: const Text(
                  'Navigate',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  _actionButton() {
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          _number++;
          _number2++;
        });

        Logging.info('Updated Number is: ${_number}');
        Logging.warning('Updated Number is: ${_number}');
        Logging.error('Updated Number is: ${_number}');

        Provider.of<TopLevelProvider>(context, listen: false).setData(_number);

        await LocalStorageManagement.storeData(_number);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
