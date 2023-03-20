import 'package:flutter/material.dart';
import 'package:tutorial_continuing/debug/manual_debug.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoadWebContent extends StatefulWidget {
  final String link;
  const LoadWebContent({super.key, required this.link});

  @override
  State<LoadWebContent> createState() => _LoadWebContentState();
}

class _LoadWebContentState extends State<LoadWebContent> {
  WebViewController? _controller;

  _initialize() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
        Logging.info('Progress is: ${progress}');
      }, onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      }))
      ..loadRequest(Uri.parse(widget.link));

    setState(() {});
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _controller == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : WebViewWidget(
                controller: _controller!,
              ),
      ),
    );
  }
}
