import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial_continuing/debug/manual_debug.dart';
import 'package:tutorial_continuing/webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();
  String _imagePath = '';

  _initialize() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _quickButtonsCollection(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: _imagePath.isEmpty
            ? null
            : BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: FileImage(File(_imagePath)))),
        child: Center(
            child: Text(
          _imagePath.isEmpty ? 'No Image Found' : '',
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  _quickButtonsCollection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () async {
              final _pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (_pickedFile == null) return;

              _imagePath = File(_pickedFile.path).path;

              setState(() {});
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.camera_alt_outlined,
                color: Colors.white, size: 30),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () async{
              final _pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (_pickedFile == null) return;

              _imagePath = File(_pickedFile.path).path;

              setState(() {});
            },
            backgroundColor: Colors.purpleAccent,
            child: const Icon(Icons.image, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  // void _openLinkInBrowser() async {
  //   final _text = _textController.text;

  //   Logging.info(_text);

  //   try {
  //     launchUrlString(_text);
  //   } catch (e) {
  //     Logging.error('Error in launch url: $e');
  //   }
  // }
}
