import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();
  final String _imagePath =
      'https://images.pexels.com/photos/4962458/pexels-photo-4962458.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  bool _isLoading = false;

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
                    fit: BoxFit.cover, image: NetworkImage(_imagePath))),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Text(
                _imagePath.isEmpty ? 'No Image Found' : '',
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
            onPressed: _downloadContent,
            backgroundColor: Colors.orange,
            child: const Icon(Icons.download, color: Colors.white, size: 30),
          ),
          // const SizedBox(height: 20),
          // FloatingActionButton(
          //   heroTag: '2',
          //   onPressed: () async{
          //     final _pickedFile =
          //         await ImagePicker().pickImage(source: ImageSource.gallery);

          //     if (_pickedFile == null) return;

          //     _imagePath = File(_pickedFile.path).path;

          //     setState(() {});
          //   },
          //   backgroundColor: Colors.purpleAccent,
          //   child: const Icon(Icons.image, color: Colors.white, size: 30),
          // ),
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

  void _downloadContent() async {
    final _permissionStatus = await Permission.storage.request();
    if (_permissionStatus != PermissionStatus.granted) {
      return;
    }

    final _rootDir = await getExternalStorageDirectory();

    if (_rootDir == null) return;

    _isLoading = true;
    setState(() {});

    final _imageStoredDir =
        await Directory('${_rootDir.path}/downloads/').create(recursive: true);

    final _newFilePath = '${_imageStoredDir.path}horse.png';

    final _dio = Dio();

    _dio.download(_imagePath, _newFilePath).whenComplete(() async {
      await ImageGallerySaver.saveFile(_newFilePath);

      _isLoading = false;
      setState(() {});

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Downloaded')));
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image download error: $err')));
    });
  }
}
