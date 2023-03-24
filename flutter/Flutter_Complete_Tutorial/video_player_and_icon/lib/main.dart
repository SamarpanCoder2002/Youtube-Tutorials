import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isBuffering = false;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Colors.black12,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage('assets/images/thumbnail.png'))),
        child: _isBuffering
            ? const CircularProgressIndicator()
            : _chewieController == null?
            
             IconButton(
                onPressed: _startVideo,
                icon: const Icon(
                  CupertinoIcons.play_arrow_solid,
                  color: Colors.white,
                  size: 50,
                ),
              ):Chewie(controller: _chewieController!),
      ),
    ));
  }

  void _startVideo() {
    _isBuffering = true;
    setState(() {});

    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/beach.mp4')
          ..initialize().then((value) {
            setState(() {});

            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController!,
              autoPlay: true,
              looping: false,
              isLive: true,
              autoInitialize: false,
              allowedScreenSleep: false,
              showControls: true,
              allowPlaybackSpeedChanging: false,
              allowFullScreen: true,
            );

            _isBuffering = false;
            setState(() {});
          });
  }
}
