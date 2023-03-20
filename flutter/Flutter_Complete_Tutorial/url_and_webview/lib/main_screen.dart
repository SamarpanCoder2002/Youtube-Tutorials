import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial_continuing/debug/manual_debug.dart';
import 'package:tutorial_continuing/webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    child: TextFormField(
                      controller: _textController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          hintText: 'Write link here',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ),
                  ),
                  IconButton(
                      onPressed: _openLinkInBrowser,
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 25,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          LoadWebContent(link: _textController.text)));
                },
                child: const Text(
                  'Load Data',
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  try {
                    final _emailUri = Uri(
                        scheme: 'mailto',
                        path: 'samarpanofficial2021@gmail.com');

                    launchUrl(_emailUri);
                  } catch (e) {
                    Logging.error('Open email error: $e');
                  }
                },
                child: const Text(
                  'Open Email',
                  style: TextStyle(fontSize: 18),
                )),

                const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  try {
                    final _emailUri = Uri(
                        scheme: 'sms',
                        path: '1254864587');

                    launchUrl(_emailUri);
                  } catch (e) {
                    Logging.error('Open email error: $e');
                  }
                },
                child: const Text(
                  'Send sms',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }

  void _openLinkInBrowser() async {
    final _text = _textController.text;

    Logging.info(_text);

    try {
      launchUrlString(_text);
    } catch (e) {
      Logging.error('Error in launch url: $e');
    }
  }
}
