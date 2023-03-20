import 'package:flutter/material.dart';
import 'package:tutorial_first_project/api/caller.dart';
import 'package:tutorial_first_project/screens/fourth_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _isLoading = false;

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Third Screen',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _getApiCallSection(),
                  const SizedBox(height: 20),
                  _postApiCallSection(),
                  const SizedBox(height: 20),
                  _putApiCallSection(),
                  const SizedBox(height: 20),
                  _deleteApiCallSection(),
                ],
              ),
            ),
    );
  }

  void _popUpDialog(data) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(children: [
                  Text(
                    data['modifiedName'] ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['modifiedTime'] ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data['modifiedPasscode'] ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ]),
              ),
            ));
  }

  _getApiCallSection() {
    return ElevatedButton(
        onPressed: () async {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => const FourthScreen()),
          //     (route) => false);

          if (!mounted) return;

          setState(() {
            _isLoading = true;
          });

          final _data = await ApiCaller.callGetApi;

          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Get api response: ${_data}')));
        },
        child: const Text(
          'Call Get api',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ));
  }

  _postApiCallSection() {
    return ElevatedButton(
        onPressed: () async {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => const FourthScreen()),
          //     (route) => false);

          if (!mounted) return;

          setState(() {
            _isLoading = true;
          });

          final _data = await ApiCaller.callPostApi;

          setState(() {
            _isLoading = false;
          });

          if (!_data['status']) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Post api response not successful')));
            return;
          }

          _popUpDialog(_data['data']);
        },
        child: const Text(
          'Call Post api',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ));
  }

  _putApiCallSection() {
    return ElevatedButton(
        onPressed: () async {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => const FourthScreen()),
          //     (route) => false);

          if (!mounted) return;

          setState(() {
            _isLoading = true;
          });

          final _data = await ApiCaller.callUpdateApi;

          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Put api response: ${_data}')));
        },
        child: const Text(
          'Call Put api',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ));
  }
  
  _deleteApiCallSection() {
     return ElevatedButton(
        onPressed: () async {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => const FourthScreen()),
          //     (route) => false);

          if (!mounted) return;

          setState(() {
            _isLoading = true;
          });

          final _data = await ApiCaller.callDeleteApi;

          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Delete api response: ${_data}')));
        },
        child: const Text(
          'Call Delete api',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ));
  }
}
