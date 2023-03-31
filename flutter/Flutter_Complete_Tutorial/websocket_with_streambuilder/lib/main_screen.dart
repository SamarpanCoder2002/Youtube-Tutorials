import 'package:flutter/material.dart';
import './api/api_caller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  final _channel =
      WebSocketChannel.connect(Uri.parse("ws://echo.websocket.events"));

  @override
  void dispose() {
    _controller.dispose();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // commonButton('Call Get api', _callGetApi),
                  // const SizedBox(height: 20),
                  // commonButton('Call Post api', _callPostApi),
                  // const SizedBox(height: 20),
                  // commonButton('Call Update api', _callUpdateApi),
                  // const SizedBox(height: 20),
                  // commonButton('Call Delete api', _callDeleteApi),
                  // const SizedBox(height: 20),
                  // _fetchPostData(),
                  // const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  _inputSection(),
                  const SizedBox(height: 10),
                  commonButton('Send Data', _sendDataToSocketServer),
                  const SizedBox(height: 10),
                  _showSentData(),
                ],
              ),
      ),
    );
  }

  commonButton(String text, VoidCallback onTap) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ));
  }

  void _callGetApi() async {
    _isLoading = true;
    setState(() {});

    final _data = await ApiCaller.getData;

    _isLoading = false;
    setState(() {});

    final _finalMsg =
        _data.isEmpty ? 'Response Failed' : 'Response Successful: $_data';

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(_finalMsg)));
  }

  void _callPostApi() async {
    _isLoading = true;
    setState(() {});

    final _data = await ApiCaller.postData('ok@tutorial', 'Samarpan', '07:26',
        cat: 'Mobile App Development', topic: 'Api Integration', lang: 'Dart');

    _isLoading = false;
    setState(() {});

    if (_data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Data Came from post api')));
    }

    _commonDialog(_data);
  }

  void _callUpdateApi() async {
    _isLoading = true;
    setState(() {});

    final _data = await ApiCaller.updateData('update_param');

    _isLoading = false;
    setState(() {});

    if (_data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Data Came from update api')));
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(_data['message'] ?? '')));
  }

  void _callDeleteApi() async {
    _isLoading = true;
    setState(() {});

    final _data = await ApiCaller.deleteData('delete_data');

    _isLoading = false;
    setState(() {});

    if (_data.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Data Came from delete api')));
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(_data['message'] ?? '')));
  }

  _commonDialog(Map<dynamic, dynamic> data) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              title: const Text(
                'Post api response',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              content: Container(
                width: double.maxFinite,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Modified Name: ${data["modifiedName"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Modified Time: ${data["modifiedTime"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Modified Passcode: ${data["modifiedPasscode"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Category: ${data["queries"]?["cat"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Topic: ${data["queries"]?["topic"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Language: ${data["queries"]?["lang"] ?? ""}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ));
  }

  _fetchPostData() {
    return FutureBuilder(
      future: ApiCaller.postData('ok@tutorial', 'Samarpan', '07:26',
          cat: 'Mobile App Development',
          topic: 'Api Integration',
          lang: 'Dart'),
      builder: (BuildContext _, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Data Fetching...', style: TextStyle(fontSize: 20)),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Data Fetching Error happening...',
                  style: TextStyle(fontSize: 18, color: Colors.red)),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data;

            if (data.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No Data Came from post api')));
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Modified Name: ${data["modifiedName"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Modified Time: ${data["modifiedTime"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Modified Passcode: ${data["modifiedPasscode"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category: ${data["queries"]?["cat"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Topic: ${data["queries"]?["topic"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Language: ${data["queries"]?["lang"] ?? ""}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            );
          }
        }

        return const Center();
      },
    );
  }

  _inputSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          label: Text('Write a message'),
        ),
      ),
    );
  }

  void _sendDataToSocketServer() {
    if (_controller.text.isEmpty) return;

    _channel.sink.add(_controller.text);
  }

  _showSentData() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: StreamBuilder(
        stream: _channel.stream,
        builder: (BuildContext _, AsyncSnapshot<dynamic> snapshot) {
          return Text(
            snapshot.hasData ? '${snapshot.data}' : '',
            style: TextStyle(fontSize: 18),
          );
        },
      ),
    );
  }
}
