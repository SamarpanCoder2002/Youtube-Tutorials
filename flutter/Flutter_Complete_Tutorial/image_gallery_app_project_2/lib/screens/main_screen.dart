import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/search_section.dart';
import './components/image_container_section.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
        child: _actualBody(),
      ),
    );
  }

  _actualBody() {
    return Column(
      children: const [
        SizedBox(height: 30,),
        Center(
          child: Text('Image Search App', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
        ),
        SizedBox(height: 10,),
        // SearchBar
        SearchWidget(),
        SizedBox(height: 10),
        // Image Container
        PhotoCollectionSection()
      ],
    );
  }
}
